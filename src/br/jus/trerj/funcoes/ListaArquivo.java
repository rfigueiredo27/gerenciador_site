package br.jus.trerj.funcoes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Arquivo;
import br.jus.trerj.modelo.Parametros;

public class ListaArquivo {

	public ArrayList<Arquivo> getListaAnexos(String vidConteudo, String vidArquivo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT id_arquivo, descricao FROM gecoi.arquivo WHERE id_conteudo=? AND ordem > 0 ";
		           /*"union " +
		           "SELECT r.id_arquivo_referencia, a.descricao FROM gecoi.arquivo a, gecoi.referencia r " +
		           "WHERE a.id_arquivo=r.id_arquivo_referencia AND r.id_arquivo_principal=?";*/
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));
		//pstm.setInt(2,Integer.parseInt(vidArquivo));
		ResultSet rs = pstm.executeQuery();
		ArrayList<Arquivo> listaArquivos = new ArrayList<Arquivo>();
		while (rs.next())
		{
			Arquivo arquivo = new Arquivo();
			arquivo.setIdArquivo(rs.getString("id_Arquivo"));
			arquivo.setDescricao(rs.getString("descricao"));
			listaArquivos.add(arquivo);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaArquivos;
		
	}

	public int getTamanhoAnexos(String vidConteudo, String vidArquivo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT (a.qtd + r.qtd) AS qtd from (" +
	              "SELECT Count(id_arquivo) AS qtd FROM gecoi.arquivo WHERE id_conteudo=? AND ordem>0) a, " +
                "(SELECT Count(id_arquivo_referencia) AS qtd FROM gecoi.referencia WHERE id_arquivo_principal=?) r";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));
		pstm.setInt(2,Integer.parseInt(vidArquivo));
		ResultSet rs = pstm.executeQuery();
		int tamanhoAnexo = 0;
		rs.next();
		if (rs.getInt("qtd") > 0)
			tamanhoAnexo = 120;
		rs.close();
		rs = null;
		conexao.close();
		return tamanhoAnexo;
		
	}
}
