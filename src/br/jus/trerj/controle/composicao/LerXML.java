package br.jus.trerj.controle.composicao;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.security.PublicKey;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServlet;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.Criptografia;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Componente;
import br.jus.trerj.modelo.Curriculo;
import br.jus.trerj.modelo.Parametros;

public class LerXML extends HttpServlet implements Servlet{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String getComponentesteste() throws IOException, ClassNotFoundException, SQLException
	{
		String vretorno = "1";
		return vretorno;
	}

	public ArrayList<Componente> getComponentes() throws IOException, ClassNotFoundException, SQLException
	{
		Criptografia cripto = new Criptografia();
		byte[] usuario = null;
		byte[] senha = null;
		ObjectInputStream inputStream = null;

		inputStream = new ObjectInputStream(new FileInputStream(cripto.PATH_CHAVE_PUBLICA));
		final PublicKey chavePublica = (PublicKey) inputStream.readObject();
		inputStream.close();
		
		inputStream = new ObjectInputStream(new FileInputStream(cripto.caminho + "g1.key"));
		usuario = (byte[]) inputStream.readObject();
		inputStream.close();
		
		inputStream = new ObjectInputStream(new FileInputStream(cripto.caminho + "g2.key"));
		senha = (byte[]) inputStream.readObject();
		inputStream.close();
		
		return getComponentes(cripto.decriptografa(usuario, chavePublica), cripto.decriptografa(senha, chavePublica));
	}

	public ArrayList<Componente> getComponentes(String vlogin, String vsenha) throws IOException, ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
		//Parametros parametros = new Parametros();
		System.out.println(vlogin + "-"+vsenha);
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vlogin, vsenha);
		//Connection conexao = new ConnectionFactory().getConnection(2, vlogin, vsenha);
		int idArea = parametros.getVidAreaComposicao();

		String vsql = "Select a.arquivo, c.data_criacao from gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c " +
					  "where a.id_conteudo = ca.id_conteudo and ca.id_area = ? and ca.id_conteudo = c.id_conteudo AND Upper(SubStr(a.nome,Length(nome)-2,3)) = 'XML' " +
					  "order by id_arquivo desc";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		//pstm.setInt(1,1622);
		pstm.setInt(1,idArea);
		
		ResultSet rs = pstm.executeQuery();
		rs.next();
		
		File arquivoAux = new File(parametros.getLocalXML()); 
		//System.out.println(arquivoAux.getAbsolutePath());
		if (!(arquivoAux.exists()) || (arquivoAux.lastModified() < rs.getTimestamp("data_criacao").getTime()))
		//if (arquivoAux.lastModified() < rs.getTimestamp("data_criacao").getTime())
		{
			byte[] buffer = new byte[1024];
			int tamanho;
			System.out.println("xml="+parametros.getLocalXML());
			FileOutputStream arquivo = new FileOutputStream(parametros.getLocalXML());
			InputStream inputStream = rs.getBlob("arquivo").getBinaryStream();
		
			while ((tamanho = inputStream.read(buffer)) != -1)
			{
				arquivo.write(buffer, 0, tamanho);
			}
			inputStream.close();
			arquivo.close();
		}
		rs.close();
		rs = null;
		conexao.close();
		
		XStream stream = new XStream(new DomDriver());
		stream.alias("componentes", ArrayList.class);
		stream.alias("componente", Componente.class);
		
		BufferedReader input = new BufferedReader(new FileReader(parametros.getLocalXML()));
		@SuppressWarnings("unchecked")
		ArrayList<Componente> listaComponentes = (ArrayList<Componente>) stream.fromXML(input);
				
		input.close();
		return listaComponentes;
		
	}
	
	public ArrayList<Curriculo> getListaCurriculos(String vpagina, String vip) throws ClassNotFoundException, SQLException, FileNotFoundException, IOException
	{
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1:1521:adm.tre-rj.gov.br", "internauta", "internauta");
		Connection conexao = new ConnectionFactory().getConnection(2, vpagina, vip);

		String vsql = "SELECT a.id_Conteudo, a.descricao FROM gecoi.arquivo a, gecoi.conteudo_Area ca " +
					  "WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area = ? AND a.ordem = 0";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,60);
		ResultSet rs = pstm.executeQuery();
		ArrayList<Curriculo> listaCurriculos = new ArrayList<Curriculo>();
		while (rs.next())
		{
			Curriculo curriculo = new Curriculo();
			curriculo.setIdConteudo(rs.getString("id_Conteudo"));
			curriculo.setDescricao(rs.getString("descricao"));
			listaCurriculos.add(curriculo);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaCurriculos;
		
	}	
}
