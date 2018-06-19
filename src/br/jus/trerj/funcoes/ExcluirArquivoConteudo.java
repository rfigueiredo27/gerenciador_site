package br.jus.trerj.funcoes;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class ExcluirArquivoConteudo {
	
	public String excluir(String vidConteudo, String vusuario, String vsenha)
	{
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			conexao.setAutoCommit(false);
     			String vsql = "{call gecoi.g_processar_exclusao_cont_arq(?, ?) ";
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setString(2,vidConteudo); //idconteudo

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
     				System.out.println(retorno);
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
