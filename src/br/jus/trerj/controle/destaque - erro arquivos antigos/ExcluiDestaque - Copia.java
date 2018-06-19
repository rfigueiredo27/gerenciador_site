package br.jus.trerj.controle.destaque;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ExcluirArquivoConteudo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class ExcluiDestaque {
	
	public String excluir(String vidConteudo, String usuario, String senha, int vpublicadoAtual)
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
     			String vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
				PreparedStatement pstm = conexao.prepareStatement(vsql);
				pstm.setInt(1, vpublicadoAtual);
				pstm.setInt(2, parametros.getVidAreaDestaque());
				pstm.executeUpdate();

     			ExcluirArquivoConteudo excluir = new ExcluirArquivoConteudo();
     			retorno = excluir.excluir(vidConteudo, usuario, senha);
				
     			/*vsql = "{call gecoi.g_processar_exclusao_cont_arq(?, ?) ";
 			
     			CallableStatement cs;
     			cs = conexao.prepareCall(vsql);

     			// retorno
     			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
     			// variáveis da alteração de conteudo
     			cs.setString(2,vidConteudo); //idconteudo

     			cs.execute();
	    			
     			retorno = cs.getString(1);*/
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
 			 			
 			
     			//if (!parametros.getCaminho().equals(""))
 					//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
     			//out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");

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
