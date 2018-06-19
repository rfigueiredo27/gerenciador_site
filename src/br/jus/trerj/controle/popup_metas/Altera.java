package br.jus.trerj.controle.popup_metas;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class Altera {

	public String alterar(String vidConteudo, String vdataIni, String vdataFim, String vmetas, String vusuario, String vsenha)
	{
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaPopupMetas();
		String retorno = "";
		String[] aMetas = vmetas.split(",");
		Arrays.sort(aMetas);
		vmetas = aMetas[0];
		for (int i = 1; i < aMetas.length; i++)
		{
			vmetas = vmetas + "," + aMetas[i];
		}
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			     			
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_alterar_conteudo(?, ?, null, ?, ?) ";
     			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setString(2,vidConteudo); //idconteudo
     			cs.setString(3,vmetas); //observacao
     			cs.setString(4,vusuario); //usuario

     			cs.execute();
	    			
     			retorno = cs.getString(1);
     			System.out.println(retorno);
     			if (retorno.indexOf("Erro") == -1)
     			{
     				
         			vsql = "{call gecoi.g_alterar_conteudo_area(?, ?, ?, null, ?, ?) ";
         			
         			cs = conexao.prepareCall(vsql);

         			// retorno
         			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
    	    			
         			// variáveis da alteração de conteudo
         			cs.setString(2,vidConteudo); //idconteudo
         			cs.setInt(3,vidArea); //data_inicio_exib
         			cs.setString(4,vdataIni); //data_inicio_exib
         			cs.setString(5,vdataFim); //data_fim_exib

         			cs.execute();
    	    			
         			retorno = cs.getString(1);
         			System.out.println(retorno);
         			if (retorno.indexOf("Erro") == -1)
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
