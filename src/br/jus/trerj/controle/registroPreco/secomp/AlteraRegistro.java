package br.jus.trerj.controle.registroPreco.secomp;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraRegistro {


	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vidArea, String vdataAbertura, String vvigenciaInicial, String vvigenciaFinal, String vusuario, String vsenha)
	{		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		Connection conexao = null;
		String retorno = "";
		int qtd = 0;
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, null, " + //alteracao do conteudo 
     							//"?, null, to_date(?, 'dd/mm/yyyy'), null, " + //alteracao do conteudo_area
     							"?, null, ?, null, " + //alteracao do conteudo_area
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
     			cs.setInt(5,Integer.parseInt(vidArea)); //idArea
     			cs.setString(6,vdataAbertura); //data_inicio_exib
     			
     			// variáveis da alteração de arquivo
     			cs.setInt(7,Integer.parseInt(vidArquivo)); //idArquivo
     			cs.setString(8,vdescricao); //
     			
     			
     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			if ((!vvigenciaInicial.equals("")) && (retorno.indexOf("Erro") < 0))
     			{
     				retorno = "";
     				vsql = "{call gecoi.g_alterar_campo_adicional(?, ?, ?, ?)}";
     				cs = conexao.prepareCall(vsql);
     				// retorno
     				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
     				cs.setString(2,vidArquivo); //idarquivo
     				cs.setInt(3, vidValidadeInicial); //id_tipo_campo_adicional
     				cs.setString(4, vvigenciaInicial); //valor
     				cs.execute();
     				retorno = cs.getString(1);
     				qtd = Integer.parseInt(retorno.substring(1,2));
     				if (qtd == 0)
     				{
     					retorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeInicial, vvigenciaInicial, vusuario, vsenha);
     				}
     			}
     			
     			if ((!vvigenciaFinal.equals("")) && (retorno.indexOf("Erro") < 0))
     			{
     				vsql = "{call gecoi.g_alterar_campo_adicional(?, ?, ?, ?)}";
     				cs = conexao.prepareCall(vsql);
     				// retorno
     				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
     				cs.setString(2,vidArquivo); //idarquivo
     				cs.setInt(3, vidValidadeFinal); //id_tipo_campo_adicional
     				cs.setString(4, vvigenciaFinal); //valor
     				cs.execute();
     				retorno = cs.getString(1);
     				qtd = Integer.parseInt(retorno.substring(1,2));
     				if (qtd == 0)
     				{
     					retorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeFinal, vvigenciaFinal, vusuario, vsenha);
     				}
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

/*	public String alterarReferencia(String vidConteudo, String vidArquivo, int vidReferencia, String vusuario, String vsenha)
	{
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "";
     			PreparedStatement pstm = null;
     			ResultSet rs = null;
     			if (vidReferencia == 0)
     			{
     				vsql = "SELECT id_arquivo FROM gecoi.arquivo WHERE id_conteudo = ? "; 
 			
     				pstm = conexao.prepareStatement(vsql);
     				pstm.setInt(1, Integer.parseInt(vidConteudo));
     				rs = pstm.executeQuery();
     				CadastroReferencia incluirReferencia = new CadastroReferencia();
     				while (rs.next())
     				{
     					incluirReferencia.incluir(vidReferencia, rs.getInt("id_arquivo"), vusuario, vsenha, 0);
     				}
     			}
     			else
     			{
     				CadastroReferencia alterarReferencia = new CadastroReferencia();
   					alterarReferencia.alterar(Integer.parseInt(vidArquivo), vidReferencia, vusuario, vsenha);
     			}
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
	*/
}
