package br.jus.trerj.controle.destaque;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraDestaque {
	
	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vobservacao, String vdataIni, String vdataFim, int vpublicadoAtual, int vpublicadoNovo, String usuario, String senha)
	{
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
		int vidArea = parametros.getVidAreaDestaque();
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), parametros.getUsuario(), parametros.getSenha());
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
			//conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_alterar_conteudo(?, ?, ?, ?, ?) ";
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setString(2,vidConteudo); //idconteudo
     			cs.setString(3,vdescricao); //descricao
     			cs.setString(4,vobservacao); //observacao
     			cs.setString(5,usuario); //usuario

     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			System.out.println(retorno);
     			if (retorno.indexOf("Erro") == -1)
     			{
     				if (!(vdescricao == null))
     				{
     					try
     					{
     						vsql = "update gecoi.arquivo set descricao = ? where id_arquivo = ?";
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setString(1, vdescricao);
     						pstm.setInt(2, Integer.parseInt(vidArquivo));
     						pstm.executeUpdate();
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
     				}
     				if (!(vdataIni == null))
     				{
     					try
     					{
     						vsql = "update gecoi.conteudo_area set data_inicio_exib = to_date(?,'dd/mm/yyyy') where id_conteudo = ?";
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setString(1, vdataIni);
     						pstm.setInt(2, Integer.parseInt(vidConteudo));
     						pstm.executeUpdate();
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
     				}
     				if (!(vdataFim == null))
     				{
     					try
     					{
     						vsql = "update gecoi.conteudo_area set data_fim_exib = to_date(?,'dd/mm/yyyy') where id_conteudo = ?";
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setString(1, vdataFim);
     						pstm.setInt(2, Integer.parseInt(vidConteudo));
     						pstm.executeUpdate();
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
     				}
     				if (vpublicadoAtual != vpublicadoNovo)
     				{
     					try
     					{
     						// se publicado atual = 0 e publicado novo então estou reativando o destaque 
     						if ((vpublicadoAtual == 0) && (vpublicadoNovo != 0))
     						{
     							vsql = "UPDATE gecoi.arquivo " +
     									"SET publicado = (SELECT Max(a.publicado)+1 FROM gecoi.arquivo a, gecoi.conteudo_Area ca WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area = ?) " + 
     									"WHERE id_conteudo = ?";
     							PreparedStatement pstm = conexao.prepareStatement(vsql);
     							pstm.setInt(1, vidArea);
     							pstm.setInt(2, Integer.parseInt(vidConteudo));
     							pstm.executeUpdate();
     						}
     						else
     						{
     							// publicado novo = 0 então estou desativando
     							if (vpublicadoNovo == 0)
     								vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
     							else
     								vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and publicado <= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
     							PreparedStatement pstm = conexao.prepareStatement(vsql);
     							pstm.setInt(1, vpublicadoAtual);
     							if (vpublicadoNovo == 0)
     								pstm.setInt(2, vidArea);
     							else
     							{
     								pstm.setInt(2, vpublicadoNovo);
     								pstm.setInt(3, vidArea);
     							}
     							pstm.executeUpdate();

     							vsql = "update gecoi.arquivo set publicado = ? where id_conteudo = ?";
     							pstm = conexao.prepareStatement(vsql);
     							pstm.setInt(1, vpublicadoNovo);
     							pstm.setInt(2, Integer.parseInt(vidConteudo));
     							pstm.executeUpdate();
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
     				}
 					conexao.commit();
     			}
     			else
     			{
     				conexao.rollback();
     				System.out.println(retorno);
     			}
     			conexao.close();
 			 			
 			
     			//if (!parametros.getCaminho().equals(""))
 					//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
     			//out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");
     			//PrintWriter out = response.getWriter();
     			//out.print("<script>top.listar();</script>");     			

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

	public String alterar(String vidConteudo, String vidArquivo, String vordem, String vacao, String usuario, String senha)
	{
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
		//int vidArea = parametros.getVidAreaDestaque();
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), parametros.getUsuario(), parametros.getSenha());
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
			//conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "";
     			PreparedStatement pstm = null;
     			if (vacao.equals("sobe"))
     			{
     				vsql = "update gecoi.arquivo set ordem = ordem + 1 where id_conteudo = ? and ordem = ?";
    				pstm = conexao.prepareStatement(vsql);
    				pstm.setInt(1, Integer.parseInt(vidConteudo));
    				pstm.setInt(2, Integer.parseInt(vordem)-1);
    				pstm.executeUpdate();
    				
     				vsql = "update gecoi.arquivo set ordem = ordem - 1 where id_arquivo = ?";
    				pstm = conexao.prepareStatement(vsql);
    				pstm.setInt(1, Integer.parseInt(vidArquivo));
    				pstm.executeUpdate();
     			}
     			else
     			{
     				vsql = "update gecoi.arquivo set ordem = ordem - 1 where id_conteudo = ? and ordem = ?";
    				pstm = conexao.prepareStatement(vsql);
    				pstm.setInt(1, Integer.parseInt(vidConteudo));
    				pstm.setInt(2, Integer.parseInt(vordem)+1);
    				pstm.executeUpdate();
    				
     				vsql = "update gecoi.arquivo set ordem = ordem + 1 where id_arquivo = ?";
    				pstm = conexao.prepareStatement(vsql);
    				pstm.setInt(1, Integer.parseInt(vidArquivo));
    				pstm.executeUpdate();
     			}
	    			
     			//System.out.println(retorno);
				conexao.commit();
     			conexao.close();
 			 			
 			
     			//if (!parametros.getCaminho().equals(""))
 					//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
     			//out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");
     			//PrintWriter out = response.getWriter();
     			//out.print("<script>top.listar();</script>");     			

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
