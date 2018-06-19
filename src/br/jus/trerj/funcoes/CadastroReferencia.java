package br.jus.trerj.funcoes;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class CadastroReferencia {

	public String incluir(int id_arquivo_principal, int id_arquivo_referencia, String vusuario, String vsenha, int id_grupo){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
				conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
     		try 
    		{
     			String vsql = "";
     			vsql = "{call gecoi.g_incluir_referencia(?, ?, ?, ?, ?, ?)";
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			cs.setInt(2,id_arquivo_principal); //id_arquivo_principal
     			cs.setInt(3,id_arquivo_referencia); //id_arquivo_referencia
     			cs.setString(4,vusuario); //logon_usuario
     			cs.setInt(5,0); //id_grupo
     			cs.setInt(6,0); //id_cruzada

     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			//conexao.commit();
     			conexao.close();
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

	
	public String alterar(int idArquivo, int idReferencia, String vusuario, String vsenha){
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
				conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
     		try 
    		{
     			String vsql = "";
     			PreparedStatement pstm = null;

     			vsql = "update gecoi.referencia set id_arquivo_principal = ? where id_arquivo_referencia = ? ";
 			
     			pstm = conexao.prepareStatement(vsql);
 				pstm.setInt(1, idReferencia);
 				pstm.setInt(2, idArquivo);
 				pstm.executeUpdate();
     			//conexao.commit();

     			conexao.close();
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
	
	
	public String alterarReferencia(String vidConteudo, String vidArquivo, int vidReferencia, int vidReferenciaAnterior, String vorigem, String vusuario, String vsenha)
	{
		Connection conexao = null;
		String retorno = "";
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "";
     			PreparedStatement pstm = null;
     			ResultSet rs = null;
     			if (vidReferenciaAnterior == 0)
     			{
     				vsql = "SELECT id_arquivo FROM gecoi.arquivo WHERE id_conteudo = ? "; 
 			
     				pstm = conexao.prepareStatement(vsql);
     				pstm.setInt(1, Integer.parseInt(vidConteudo));
     				rs = pstm.executeQuery();
     				while (rs.next())
     				{
     					incluir(vidReferencia, rs.getInt("id_arquivo"), vusuario, vsenha, 0);
     				}
     			}
     			else
     			{
   					alterar(Integer.parseInt(vidArquivo), vidReferencia, vusuario, vsenha);
   					if (vorigem.equals("contrato"))
   					{
   						vsql = "select ca.id_area, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, a.descricao, " +
   								"(SELECT descricao " +  
   								"FROM gecoi.arquivo " +
   								"WHERE id_arquivo = ?) as processo " +	
   								"from gecoi.arquivo a, gecoi.conteudo_area ca " +
   								"where a.id_arquivo = ? and a.id_conteudo = ca.id_conteudo ";

   						pstm = conexao.prepareStatement(vsql);
   	     				pstm.setInt(1, vidReferencia);
   	     				pstm.setInt(2, Integer.parseInt(vidArquivo));
   	     				rs = pstm.executeQuery();
   	     				rs.next();
   	     				String[] aprocesso = rs.getString("processo").split("-");
   	     				String[] adescricao = rs.getString("descricao").split("-");
   	     				String vdescricao = ""; 
   	     				if (adescricao.length > 2)
   	     					vdescricao = adescricao[0].trim() + "-" + aprocesso[2].trim() + "-" + adescricao[2];
   	     				else
   	     				vdescricao = adescricao[0].trim() + "-" + aprocesso[2].trim() + "-";
   						
   		     			vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, null, " + //alteracao do conteudo 
     							//"?, null, to_date(?,'dd/mm/yyyy'), '', " + //alteracao do conteudo_area
     							"?, null, ?, '', " + //alteracao do conteudo_area
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
   		     			cs.setInt(5,rs.getInt("id_area")); //idArea
   		     			cs.setString(6,rs.getString("data_inicio_exib")); //data_inicio_exib
     			     			
   		     			// variáveis da alteração de arquivo
   		     			cs.setInt(7,Integer.parseInt(vidArquivo)); //idArquivo
   		     			cs.setString(8,vdescricao); //
     			
   		     			cs.execute();
	    			
   		     			retorno = cs.getString(1);
   		     			System.out.println(retorno);

   					}
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
	
}
