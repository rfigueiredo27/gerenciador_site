package br.jus.trerj.controle.revistaJE;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraGecoiArquivos {

	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vidArea, String vdataAbertura, String vvigenciaInicial, String vvigenciaFinal, String vobservacao, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		int qtd = 0;
		System.out.println(vidArea);
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			try
			{
				IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
				conexao.setAutoCommit(false);
				String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, ?, ?, null, ?, null, ?, ?, null, null)";
				CallableStatement cs = conexao.prepareCall(vsql);
				cs.registerOutParameter(1, 12);
				cs.setString(2, vdescricao);
				cs.setString(3, vusuario);
				cs.setInt(4, Integer.parseInt(vidConteudo));
				cs.setString(5, vobservacao);
				cs.setInt(6, Integer.parseInt(vidArea));
				cs.setString(7, vdataAbertura);
				cs.setInt(8, Integer.parseInt(vidArquivo));
				cs.setString(9, vdescricao);
				cs.execute();
				retorno = cs.getString(1);

				if (retorno.indexOf("Erro") < 0) {
					conexao.commit();
				} else
					conexao.rollback();
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

	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_alterar_conteudo(?, ?, null, null, ?) "; 
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setInt(2,Integer.parseInt(vidConteudo));
     			cs.setString(3,vusuario); //usuario
     			
     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			
     			System.out.println(retorno);
     			if (retorno.indexOf("Erro:") == -1)
     			{
         			vsql = "{call gecoi.g_alterar_arquivo(?, ?, ?, null, null) "; 
         			
         			cs = conexao.prepareCall(vsql);

         			// retorno
         			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
    	    			
         			// variáveis da alteração de conteudo
         			cs.setInt(2,Integer.parseInt(vidArquivo));
         			cs.setString(3,vdescricao); //descricao
         			
         			cs.execute();
    	    			
         			retorno = cs.getString(1);
         			if (retorno.indexOf("Erro:") == -1)
         			{     				
         				conexao.commit();
         			}
         			else
         			{
         				conexao.rollback();
         			}
     			}
     			else
     			{
     				conexao.rollback();
     			}
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
