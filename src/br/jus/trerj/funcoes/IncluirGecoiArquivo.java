package br.jus.trerj.funcoes;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import java.text.DecimalFormat;
import java.text.NumberFormat;

import oracle.sql.BLOB;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import oracle.jdbc.OracleTypes;


public class IncluirGecoiArquivo {

	
	public String incluirImagemReduzida(String vidarquivo, String vdirName, String vnomeArquivo, String vusuario, String vsenha)
	{
		Connection conexao = null;
		PreparedStatement pstm;
		ResultSet rs;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		String vsql = "";

		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{

				vsql = "select arquivo_reduzido from gecoi.arquivo where id_arquivo = ? for update ";
				
				pstm = conexao.prepareStatement(vsql);
				pstm.setString(1, vidarquivo);
				rs = pstm.executeQuery();
				
				if(rs.next()){
				//aponta para o arquivo gravado em disco
				File file = new File(vdirName + "/" + vnomeArquivo);
				//File file = new File(vdirName + "/redu" + vnomeArquivo);

				// copia arquivo para campo blob
				Blob blob = rs.getBlob("arquivo_reduzido");
				byte[] bbuf = new byte[1024];  
				InputStream bin = new FileInputStream(file);  
				
				OutputStream bout = ((BLOB) blob).getBinaryOutputStream(); // específico driver oracle  

				int bytesRead = 0;  
				while ((bytesRead = bin.read(bbuf)) != -1)
				{  
					bout.write(bbuf, 0, bytesRead); 
				}  

				bin.close();  
				bout.close(); 

				file.delete();	

				vsql = "update gecoi.arquivo set nome_arquivo_reduzido = ? where id_arquivo = ? ";
				
				pstm = conexao.prepareStatement(vsql);
				pstm.setString(1, "arq_" + (vidarquivo) + "_min" + vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")));
				pstm.setString(2, vidarquivo);
				pstm.executeQuery();
				conexao.commit();
				conexao.close();
				}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 

		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}
	
	public String incluirDescCont(String desc_cont, String id_conteudo, String vusuario, String vsenha)
	{
		Connection conexao = null;
		PreparedStatement pstm;
		//ResultSet rs;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		String vsql = "";
		

		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{

				vsql = "update gecoi.conteudo set descricao = ? where id_conteudo = ? ";
				
				pstm = conexao.prepareStatement(vsql);
				pstm.setString(1, desc_cont);
				pstm.setString(2, id_conteudo);
				pstm.executeQuery();
				conexao.commit();
				conexao.close();
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 

		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}
	
	
	// Inclusão completa:  Incluir o arquivo, incluir o conteúdo e o conteúdo área
	public String incluir(String descricao, String diretorio, String nomeArquivo, int idArea, String vusuario, String vsenha, String dataIni, String dataFim, int ordem, String observacao, int publicado){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		descricao = new String (descricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		observacao = new String (observacao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		
		System.out.println(descricao);

		try {
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), parametros.getUsuario(), parametros.getSenha());
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			//conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			try 
			{
				String vsql = "{call gecoi.g_proc_inc_arq_cont_inexist(?, ?, ?, ?, ";  // parametros do conteudo

				// parametros do conteudo_area
				vsql = vsql + "?, ";
				if (dataIni.equals(""))
					vsql = vsql + "Sysdate, "; // parametros do conteudo_area
				else
					if (dataIni.length() > 10)
						vsql = vsql + "to_date(?, 'dd/mm/yyyy hh24:mi:ss'), ";
					else
						vsql = vsql + "to_date(?, 'dd/mm/yyyy'), ";

				if (dataFim.length() == 0)
					vsql = vsql + "? , ";
				else
					if (dataFim.length() > 10)
						vsql = vsql + "to_date(?, 'dd/mm/yyyy hh24:mi:ss'), "; // parametros do conteudo_area
					else
						vsql = vsql + "to_date(?, 'dd/mm/yyyy'), "; // parametros do conteudo_area

				vsql = vsql + "?, ?, ?, ?)}"; // parametros do arquivo

				CallableStatement cs;
				cs = conexao.prepareCall(vsql);
				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

				// variáveis da inclusão de conteudo
				cs.setString(2,descricao); //descricao
				cs.setString(3,observacao); //observacao
				cs.setString(4,vusuario); //usuario

				// variáveis da inclusão de conteudo_area
				cs.setInt(5, idArea); //vid_area
				int contaParam = 6;

				if (!dataIni.equals(""))
					cs.setString(contaParam++, dataIni);

				if (dataFim.length() == 0)
				{
					dataFim = dataIni.substring(0,6) + (Integer.parseInt(dataIni.substring(6,10)) + 1);
					cs.setString(contaParam++, dataFim);
				}
				else
				{
					cs.setString(contaParam++, dataFim);
				}

				// variáveis da inclusão de arquivo
				File arquivo = new File(diretorio + nomeArquivo);
				FileInputStream fis = new FileInputStream(arquivo);
				cs.setBinaryStream(contaParam++, fis, (int)arquivo.length());
				//cs.setBinaryStream(5,arquivo.getInputStream(), (int) arquivo.getSize()); //arquivo
				cs.setString(contaParam++,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
				//cs.setString(6,"xml");//extensao
				cs.setInt(contaParam++,ordem);//ordem
				cs.setInt(contaParam++,publicado);//publicado

				cs.execute();

				retorno = cs.getString(1);
				conexao.commit();
				conexao.close();



				//if (!parametros.getCaminho().equals(""))
				//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
				//out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}

	// Inclusão simples é só incluir o arquivo de um conteúdo informado no gecoi.arquivo e alterar os campos usuario_ultima_alteracao e data_ultima_alteracao no gecoi.conteudo 
	public String incluir(String idConteudo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha, int ordem, int publicado, String observacao){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		descricao = new String (descricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		observacao = new String (observacao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{
				String vsql = "";
				if (ordem == 0)
				{
					vsql = "Select Max(ordem) + 1 as ordem from gecoi.arquivo where id_conteudo = ? ";
					PreparedStatement pstm = conexao.prepareStatement(vsql);
					pstm.setInt(1, Integer.parseInt(idConteudo));
					ResultSet rs = pstm.executeQuery();
					rs.next();
					ordem = rs.getInt("ordem");

				}
				vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ?, ?, ?, ?)";

				CallableStatement cs;
				cs = conexao.prepareCall(vsql);

				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

				// variáveis da alteração do conteúdo
				cs.setString(2,idConteudo); //id do conteudo
				cs.setString(3,descricao); //descricao
				cs.setString(4,observacao); //observacao
				cs.setString(5,vusuario); //usuario

				// variáveis da inclusão de arquivo
				File arquivo = new File(diretorio + nomeArquivo);
				FileInputStream fis = new FileInputStream(arquivo);
				cs.setBinaryStream(6, fis, (int)arquivo.length());
				cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
				cs.setInt(8,ordem); //ordem
				cs.setInt(9,publicado);//publicado

				cs.execute();

				retorno = cs.getString(1);
				conexao.commit();
				conexao.close();

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}

	//
	public String incluirAnexo(String idConteudo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha, int ordem, int publicado, String observacao){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		descricao = new String (descricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		observacao = new String (observacao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{
				String vsql = "";
				vsql = "{call gecoi.g_alterar_conteudo(?, ?, null, ?, ?)";
				CallableStatement cs;
				cs = conexao.prepareCall(vsql);

				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

				// variáveis da alteração do conteúdo
				cs.setString(2,idConteudo); //id do conteudo
				//cs.setString(3,descricao); //descricao
				cs.setString(3,observacao); //observacao
				cs.setString(4,vusuario); //usuario

				cs.execute();

				retorno = cs.getString(1);

				if (ordem == 0)
				{
					vsql = "Select Max(ordem) + 1 as ordem from gecoi.arquivo where id_conteudo = ? ";
					PreparedStatement pstm = conexao.prepareStatement(vsql);
					pstm.setInt(1, Integer.parseInt(idConteudo));
					ResultSet rs = pstm.executeQuery();
					rs.next();
					ordem = rs.getInt("ordem");

				}

				vsql = "{call gecoi.g_incluir_arquivo(?, ?, ?, ?, ?, Empty_Blob(), ?, ?)";

				cs = conexao.prepareCall(vsql);

				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

				// variáveis da alteração do conteúdo
				cs.setString(2,idConteudo); //id do conteudo
				cs.setString(3,descricao); //descricao

				// variáveis da inclusão de arquivo
				File arquivo = new File(diretorio + nomeArquivo);
				FileInputStream fis = new FileInputStream(arquivo);
				cs.setBinaryStream(4, fis, (int)arquivo.length());
				cs.setString(5,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
				cs.setInt(6,ordem); //ordem
				cs.setInt(7,publicado);//publicado

				cs.execute();

				retorno = cs.getString(1);
				conexao.commit();
				conexao.close();

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}

	public String incluirCampoAdicional(String idArquivo, int idCampoAdicional, String valor, String vusuario, String vsenha){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{
				String vsql = "";
				vsql = "{call gecoi.g_incluir_campo_adicional(?, ?, ?, ?)";

				CallableStatement cs;
				cs = conexao.prepareCall(vsql);

				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

				cs.setString(2,idArquivo); 
				cs.setInt(3,idCampoAdicional); 
				cs.setString(4,valor); 

				cs.execute();

				retorno = cs.getString(1);
				conexao.commit();
				conexao.close();

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}

	/*	
	// Inclusão simples é só incluir o arquivo de um conteúdo informado
	public String incluir(String idConteudo, String descricao, String diretorio, String nomeArquivo, String usuario, String senha, int ordem){
		Connection conexao = null;
		Parametros parametros = new Parametros();
		//PrintWriter out = response.getWriter();
		String retorno = "";
		System.out.println(diretorio+nomeArquivo);
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
     		try 
    		{
			String vsql = "{call gecoi.g_incluir_arquivo(?, ?, ?, ?, ?, Empty_Blob(), ?)";

 			CallableStatement cs;
 			cs = conexao.prepareCall(vsql);

			// retorno
			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno

			// variáveis da inclusão de arquivo
			cs.setString(2,idConteudo); //id do conteudo
			cs.setString(3,descricao); //descricao
			File arquivo = new File(diretorio + nomeArquivo);
			FileInputStream fis = new FileInputStream(arquivo);
			cs.setBinaryStream(4, fis, (int)arquivo.length());
			cs.setString(5,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")));//extensao
			cs.setInt(6,ordem); //ordem

			cs.execute();

			retorno = cs.getString(1);
 			conexao.commit();
 			conexao.close();
 			System.out.println(idConteudo);
 			System.out.println(retorno); 			 			
    		} 
    		catch (Exception e) 
    		{
    			e.printStackTrace();
    			try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
    		} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}
	 */
	
	// Inclusão completa:  Incluir o arquivo, incluir o conteúdo e o conteúdo área
	public String incluirExterno(String descricao, String diretorio, String nomeArquivo, int idArea, String vusuario, String vsenha, String dataIni, String dataFim, int ordem, String observacao, int publicado){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";

		try {
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), parametros.getUsuario(), parametros.getSenha());
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			//conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			try 
			{
				String vsql = "select (guardiao.pkg_validar_usuario.autenticar_usuario(?,?,?)) as retorno from dual";
				PreparedStatement pstm = conexao.prepareStatement(vsql);
				pstm.setString(1,vusuario);
				pstm.setString(2,vsenha);
				pstm.setInt(3,74);
				ResultSet resultSet = pstm.executeQuery();
				if (resultSet.next())
				{
					vsql = "{call gecoi.g_proc_inc_arq_cont_inexist(?, ?, ?, ?, ";  // parametros do conteudo
	
					// parametros do conteudo_area
					vsql = vsql + "?, ";
					if (dataIni.equals(""))
						vsql = vsql + "Sysdate, "; // parametros do conteudo_area
					else
						if (dataIni.length() > 10)
							vsql = vsql + "to_date(?, 'dd/mm/yyyy hh24:mi:ss'), ";
						else
							vsql = vsql + "to_date(?, 'dd/mm/yyyy'), ";
	
					if (dataFim.length() == 0)
						vsql = vsql + "? , ";
					else
						if (dataFim.length() > 10)
							vsql = vsql + "to_date(?, 'dd/mm/yyyy hh24:mi:ss'), "; // parametros do conteudo_area
						else
							vsql = vsql + "to_date(?, 'dd/mm/yyyy'), "; // parametros do conteudo_area
	
					vsql = vsql + "?, ?, ?, ?)}"; // parametros do arquivo
	
					CallableStatement cs;
					cs = conexao.prepareCall(vsql);
					// retorno
					cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	
					// variáveis da inclusão de conteudo
					cs.setString(2,descricao); //descricao
					cs.setString(3,observacao); //observacao
					cs.setString(4,vusuario); //usuario
	
					// variáveis da inclusão de conteudo_area
					cs.setInt(5, idArea); //vid_area
					int contaParam = 6;
	
					if (!dataIni.equals(""))
						cs.setString(contaParam++, dataIni);
	
					if (dataFim.length() == 0)
					{
						dataFim = dataIni.substring(0,6) + (Integer.parseInt(dataIni.substring(6,10)) + 1);
						cs.setString(contaParam++, dataFim);
					}
					else
					{
						cs.setString(contaParam++, dataFim);
					}
	
					// variáveis da inclusão de arquivo
					File arquivo = new File(diretorio + nomeArquivo);
					FileInputStream fis = new FileInputStream(arquivo);
					cs.setBinaryStream(contaParam++, fis, (int)arquivo.length());
					//cs.setBinaryStream(5,arquivo.getInputStream(), (int) arquivo.getSize()); //arquivo
					cs.setString(contaParam++,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
					//cs.setString(6,"xml");//extensao
					cs.setInt(contaParam++,ordem);//ordem
					cs.setInt(contaParam++,publicado);//publicado
	
					cs.execute();
	
					retorno = cs.getString(1);
					conexao.commit();
				}
				resultSet.close();
				conexao.close();
	
	
	
					//if (!parametros.getCaminho().equals(""))
					//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
					//out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");
					

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}

	// Inclusão simples é só incluir o arquivo de um conteúdo informado no gecoi.arquivo e alterar os campos usuario_ultima_alteracao e data_ultima_alteracao no gecoi.conteudo 
	public String incluirExterno(String idConteudo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha, int ordem, int publicado, String observacao){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try 
			{
				String vsql = "";
				vsql = "select (guardiao.pkg_validar_usuario.autenticar_usuario(?,?,?)) as retorno from dual";
				PreparedStatement pstm = conexao.prepareStatement(vsql);
				pstm.setString(1,vusuario);
				pstm.setString(2,vsenha);
				pstm.setInt(3,74);
				ResultSet resultSet = pstm.executeQuery();
				if (resultSet.next())
				{
					if (ordem == 0)
					{
						vsql = "Select Max(ordem) + 1 as ordem from gecoi.arquivo where id_conteudo = ? ";
						pstm = conexao.prepareStatement(vsql);
						pstm.setInt(1, Integer.parseInt(idConteudo));
						ResultSet rs = pstm.executeQuery();
						rs.next();
						ordem = rs.getInt("ordem");
	
					}
					vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
					CallableStatement cs;
					cs = conexao.prepareCall(vsql);
	
					// retorno
					cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	
					// variáveis da alteração do conteúdo
					cs.setString(2,idConteudo); //id do conteudo
					cs.setString(3,descricao); //descricao
					cs.setString(4,observacao); //observacao
					cs.setString(5,vusuario); //usuario
	
					// variáveis da inclusão de arquivo
					File arquivo = new File(diretorio + nomeArquivo);
					FileInputStream fis = new FileInputStream(arquivo);
					cs.setBinaryStream(6, fis, (int)arquivo.length());
					cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
					cs.setInt(8,ordem); //ordem
					cs.setInt(9,publicado);//publicado
	
					cs.execute();
	
					retorno = cs.getString(1);
					conexao.commit();
				}
				resultSet.close();
				conexao.close();

			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
			} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
		return retorno;
	}
	
}
