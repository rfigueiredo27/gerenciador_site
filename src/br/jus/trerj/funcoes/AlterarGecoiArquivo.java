package br.jus.trerj.funcoes;

import java.io.File;
import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class AlterarGecoiArquivo {

	
	public String substituirArquivo(String idConteudo, String idArquivo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		descricao = new String (descricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
     		try 
    		{
     			String vsql = "{call gecoi.g_processar_substituir_arquivo(?, ?, ?, ?, ?, ?, ?, ?)";
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    		
     			// variáveis de alteração do conteúdo
     			cs.setString(2, idConteudo); //id do conteudo
     			cs.setString(3, descricao); //descricao
     			cs.setString(4, null); //Observação
     			cs.setString(5, vusuario); //usuário de alteração
			
     			// variáveis da substituição de arquivo
     			File arquivo = new File(diretorio + nomeArquivo);
     			FileInputStream fis = new FileInputStream(arquivo);
     			cs.setBinaryStream(6, fis, (int)arquivo.length());
     			cs.setString(7,idArquivo); //id do arquivo
     			cs.setString(8,nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1));//extensao

     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			System.out.println(retorno);
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
	
	public String substituirArquivoExterno(String idConteudo, String idArquivo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		descricao = new String (descricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
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
	     			vsql = "{call gecoi.g_processar_substituir_arquivo(?, ?, ?, ?, ?, ?, ?, ?)";
	 			
	     			CallableStatement cs;
	     			cs = conexao.prepareCall(vsql);
	
	     			// retorno
	     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
		    		
	     			// variáveis de alteração do conteúdo
	     			cs.setString(2, idConteudo); //id do conteudo
	     			cs.setString(3, descricao); //descricao
	     			cs.setString(4, null); //Observação
	     			cs.setString(5, vusuario); //usuário de alteração
				
	     			// variáveis da substituição de arquivo
	     			File arquivo = new File(diretorio + nomeArquivo);
	     			FileInputStream fis = new FileInputStream(arquivo);
	     			cs.setBinaryStream(6, fis, (int)arquivo.length());
	     			cs.setString(7,idArquivo); //id do arquivo
	     			cs.setString(8,nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1));//extensao
	
	     			cs.execute();
		    			
	     			retorno = cs.getString(1);
	     			System.out.println(retorno);
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
