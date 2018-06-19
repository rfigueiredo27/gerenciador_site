package br.jus.trerj.controle.contrato;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ExcluirArquivoConteudo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class ExcluirContratoSemLicitacao {

	public String excluirSemLicitacao(String vidConteudo, String vidArquivo, String vusuario, String vsenha) throws SQLException {
		
		//Connection conexao = null;
		//Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		String retorno = "";
		//try
		//{
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			//conexao.setAutoCommit(false);
			
			//String vsql = "Delete from gecoi.campo_adicional where id_arquivo = ? ";
 			//PreparedStatement pstm;
 			//pstm = conexao.prepareStatement(vsql);
 			//pstm.setInt(1, Integer.parseInt(vidArquivo));
 			//pstm.executeQuery();
			ExcluirArquivoConteudo exclui = new ExcluirArquivoConteudo();
			//System.out.println(exclui.excluir(vidConteudo, vusuario, vsenha));
			retorno =(exclui.excluir(vidConteudo, vusuario, vsenha));
			System.out.println(retorno);
			//conexao.commit();
			//conexao.close();
		//} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
			//System.out.println("e2.getMessage()");
		//}
		
		return retorno;
	}
}
