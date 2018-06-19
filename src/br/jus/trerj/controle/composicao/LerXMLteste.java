package br.jus.trerj.controle.composicao;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServlet;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Componente;
import br.jus.trerj.modelo.Curriculo;
import br.jus.trerj.modelo.ParametrosTeste;

public class LerXMLteste extends HttpServlet implements Servlet{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ArrayList<Componente> getComponentes() throws IOException, ClassNotFoundException, SQLException
	{
		return getComponentes("internauta", "internauta");
	}
	
	public ArrayList<Componente> getComponentes(String vlogin, String vsenha) throws IOException, ClassNotFoundException, SQLException
	{
		ParametrosTeste parametrosTeste = new ParametrosTeste();
		
		//Connection conexao = new ConnectionFactory().getConnection(ParametrosTeste.getBanco(), ParametrosTeste.getUsuario(), ParametrosTeste.getSenha());
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
		Connection conexao = new ConnectionFactory().getConnection(parametrosTeste.getBanco(), vlogin, vsenha);
		int idArea = parametrosTeste.getVidAreaComposicao();

		String vsql = "Select a.arquivo, c.data_criacao from gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c " +
					  "where a.id_conteudo = ca.id_conteudo and ca.id_area = ? and ca.id_conteudo = c.id_conteudo AND Upper(SubStr(a.nome,Length(nome)-2,3)) = 'XML' " +
					  "order by id_arquivo desc";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		//pstm.setInt(1,1622);
		pstm.setInt(1,idArea);
		
		ResultSet rs = pstm.executeQuery();
		rs.next();
		
		System.out.println(parametrosTeste.getLocalXML());
		File arquivoAux = new File(parametrosTeste.getLocalXML()); 
		if (!(arquivoAux.exists()) || (arquivoAux.lastModified() < rs.getTimestamp("data_criacao").getTime()))
		//if (arquivoAux.lastModified() < rs.getTimestamp("data_criacao").getTime())
		{
			byte[] buffer = new byte[1024];
			int tamanho;
			FileOutputStream arquivo = new FileOutputStream(parametrosTeste.getLocalXML());
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
		
		BufferedReader input = new BufferedReader(new FileReader(parametrosTeste.getLocalXML()));
		@SuppressWarnings("unchecked")
		ArrayList<Componente> listaComponentes = (ArrayList<Componente>) stream.fromXML(input);
				
		input.close();
		return listaComponentes;
		
	}
	
	public ArrayList<Curriculo> getListaCurriculos() throws ClassNotFoundException, SQLException
	{
		Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1:1521:adm.tre-rj.gov.br", "internauta", "internauta");

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
