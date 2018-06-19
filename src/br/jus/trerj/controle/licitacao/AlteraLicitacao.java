package br.jus.trerj.controle.licitacao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraLicitacao {

	//int vidArea = parametros.getVidAreaContrato();

	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vdataAbertura, String vdataFechamento, String vdataPublicacao, String vtipo, String vusuario, String vsenha)
	{
		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidDataPublicacao = parametros.getVidDataPublicacao();
		Connection conexao = null;
		String retorno = "";		
		int vidArea = 0;
		vdataFechamento = vdataAbertura.substring(0,6) + (Integer.parseInt(vdataAbertura.substring(6,10)) + 1);
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
     		try 
    		{
    			if (vtipo.equals("PE"))
    				vidArea = parametros.getVidAreaLicitacaoPregaoEletronico();
    			if (vtipo.equals("PERP"))
    				vidArea = parametros.getVidAreaLicitacaoPregaoEletronicoRegistroPreco();
    			if (vtipo.equals("PP"))
    				vidArea = parametros.getVidAreaLicitacaoPregaoPresencial();
    			if (vtipo.equals("PPRP"))
    				vidArea = parametros.getVidAreaLicitacaoPregaoPresencialRegistroPreco();
    			if (vtipo.equals("CO")) //??????????????
    				vidArea = parametros.getVidAreaLicitacaoConvite();
    			if (vtipo.equals("TO")) //???????????????????
    				vidArea = parametros.getVidAreaLicitacaoTomadaPreco();
    			if (vtipo.equals("CP")) 
    				vidArea = parametros.getVidAreaLicitacaoConcorrenciaPublica();
    			
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, null, " + //alteracao do conteudo 
     							//"?, null, to_date(?,'dd/mm/yyyy hh24:mi'), to_date(?,'dd/mm/yyyy'), " + //alteracao do conteudo_area
     							"?, null, ?, ?, " + //alteracao do conteudo_area
     							"?, ?, null, null)"; //alteracao do arquivo
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setString(2,vdescricao); //descricao
     			cs.setString(3,vusuario); //usuario
     			cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo

     			// variáveis da alteração de conteudo_area
     			cs.setInt(5,vidArea); //idArea
     			cs.setString(6,vdataAbertura); //data_inicio_exib
     			cs.setString(7,vdataFechamento); //data_fim_exib
     			
     			// variáveis da alteração de arquivo
     			cs.setInt(8,Integer.parseInt(vidArquivo)); //idArquivo
     			cs.setString(9,vdescricao); //
     			     			
     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			System.out.println(retorno);
     			if ((!vdataPublicacao.equals("")) && (retorno.indexOf("Erro") < 0))
     			{
     				retorno = "";
     				vsql = "{call gecoi.g_alterar_campo_adicional(?, ?, ?, ?)}";
     				cs = conexao.prepareCall(vsql);
     				// retorno
     				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
     				cs.setString(2,vidArquivo); //idarquivo
     				cs.setInt(3, vidDataPublicacao); //id_tipo_campo_adicional
     				cs.setString(4, vdataPublicacao); //valor
     				cs.execute();
     				retorno = cs.getString(1);
     			}
     			
				if (retorno.indexOf("Erro") < 0)
					conexao.commit();
				else
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
	
	public String alterarStatusReabrir(int vidConteudo, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			//String vsql = "Update gecoi.conteudo_area set data_fim_exib = add_months(data_inicio_exib, 12) where id_conteudo = ? ";
     			String vsql = "Update gecoi.conteudo_area set data_fim_exib = add_months(sysdate, 12) where id_conteudo = ? ";
     			PreparedStatement pstm;
     			pstm = conexao.prepareStatement(vsql);
     			pstm.setInt(1, vidConteudo);
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
	
	public String alterarStatusEncerrar(int vidConteudo, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "Update gecoi.conteudo_area set data_fim_exib = sysdate where id_conteudo = ? "; 
 			
     			PreparedStatement pstm;
     			pstm = conexao.prepareStatement(vsql);
     			pstm.setInt(1, vidConteudo);
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
	
	public String alterarStatusSuspender(int vidConteudo, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "Update gecoi.conteudo_area set data_fim_exib = to_date('21/04/1500') where id_conteudo = ? "; 
 			
     			PreparedStatement pstm;
     			pstm = conexao.prepareStatement(vsql);
     			pstm.setInt(1, vidConteudo);
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
	
	public String alterarStatusRevogar(int vidConteudo, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "Update gecoi.conteudo_area set data_fim_exib = to_date('15/11/1880') where id_conteudo = ? "; 
 			
     			PreparedStatement pstm;
     			pstm = conexao.prepareStatement(vsql);
     			pstm.setInt(1, vidConteudo);
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
	
}
