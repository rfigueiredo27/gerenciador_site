package br.jus.trerj.controle.curriculo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class AlteraCurriculo {
	
	public String alterar(String vidConteudo, String vdescricao, String vpublicado, String usuario, String senha)
	{
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
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
     			cs.setString(4,null); //observacao
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
     						vsql = "update gecoi.arquivo set descricao = ? where id_conteudo = ?";
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setString(1, vdescricao);
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
     				if (!(vpublicado == null))
     				{
     					try
     					{
     						vsql = "update gecoi.arquivo set publicado = ? where id_conteudo = ?";
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setInt(1, Integer.parseInt(vpublicado));
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

}
