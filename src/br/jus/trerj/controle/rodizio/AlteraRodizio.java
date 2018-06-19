package br.jus.trerj.controle.rodizio;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraRodizio {

	public String alterar(String vtitulo, String vtexto, String vtamanhoTitulo, String vtamanhoTexto, String vtopoTitulo, String vtopoTexto, String valturaTitulo, String valturaTexto, String vlocal, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidAreaRodizioInternet = parametros.getVidAreaRodizioInternet();
		int vidAreaRodizioIntranet = parametros.getVidAreaRodizioIntranet();
		Connection conexao = null;
		String retorno = "";
		int vidConteudo = 0;
		int vidArquivo = 0;
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
     		try 
    		{
     			//pegar o idconteudo e o idarquivo
     			String vsql = "Select a.id_conteudo, a.id_arquivo from gecoi.arquivo a, gecoi.conteudo_area ca " +
     							"where a.id_conteudo = ca.id_conteudo and ca.id_area = ?";
     		    PreparedStatement pstm = conexao.prepareStatement(vsql);
     		    if (vlocal.equals("internet"))
     		    	pstm.setInt(1,vidAreaRodizioInternet);
     		    else
     		    	pstm.setInt(1,vidAreaRodizioIntranet);
     			 
     			ResultSet resultSet = pstm.executeQuery();
     				
     			if(resultSet.next())
     		    {	
     				vidConteudo = resultSet.getInt("id_conteudo");
     				vidArquivo = resultSet.getInt("id_arquivo");
     				resultSet.close();
     						
     				CallableStatement cs;
     				
     				conexao.setAutoCommit(false);
     				
     				//salvar a observacao no conteudo
     				vsql = "{call gecoi.g_alterar_conteudo(?, ?, ?, ?, ?) "; 
     	 			
     				cs = conexao.prepareCall(vsql);

     				// retorno
     				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     				// variáveis da alteração de conteudo
     				cs.setInt(2,vidConteudo);
         			cs.setString(3,vtitulo + "##" + vtexto); //descricao
         			cs.setString(4, "tamanhoTitulo=" + vtamanhoTitulo + "##tamanhoTexto=" + vtamanhoTexto + "##topoTitulo=" + vtopoTitulo + "##topoTexto=" + vtopoTexto + "##alturaTitulo=" + valturaTitulo + "##alturaTexto=" + valturaTexto); //observacao
         			cs.setString(5,vusuario); //usuario
     			
     				cs.execute();
	    			
     				retorno = cs.getString(1);
         			if (retorno.indexOf("Erro:") == -1)
         			{     				
         				//salvar a descricao no arquivo
         				vsql = "{call gecoi.g_alterar_arquivo(?, ?, ?, null, null) "; 
     			
         				cs = conexao.prepareCall(vsql);

         				// retorno
         				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
    	    			
         				// variáveis da alteração de conteudo
         				cs.setInt(2,vidArquivo);
         				cs.setString(3,vtitulo + "##" + vtexto); //descricao
         			
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

     		    }
     			System.out.println(retorno);
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
