package br.jus.trerj.controle.controleAta;

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

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.ControleAta;
import br.jus.trerj.modelo.Parametros;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;


public class LerXML {

	public ArrayList<ControleAta> getAta(String vlogin, String vsenha) throws IOException, ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
		
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vlogin, vsenha);
		int idArea = parametros.getVidAreaControleAta();

		String vsql = "Select a.arquivo, c.data_criacao from gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c " +
					  "where a.id_conteudo = ca.id_conteudo and ca.id_area = ? and ca.id_conteudo = c.id_conteudo AND Upper(SubStr(a.nome,Length(nome)-2,3)) = 'XML' " +
					  "order by id_arquivo desc";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,idArea);
		
		ResultSet rs = pstm.executeQuery();
		rs.next();
		
		System.out.println(parametros.getLocalXML());
		File arquivoAux = new File(parametros.getLocalXML()); 
		if (!(arquivoAux.exists()) || (arquivoAux.lastModified() < rs.getTimestamp("data_criacao").getTime()))
		{
			byte[] buffer = new byte[1024];
			int tamanho;
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
		stream.alias("atas", ArrayList.class);
		stream.alias("ata", ControleAta.class);
		
		BufferedReader input = new BufferedReader(new FileReader(parametros.getLocalXML()));
		@SuppressWarnings("unchecked")
		ArrayList<ControleAta> listaControle = (ArrayList<ControleAta>) stream.fromXML(input);
				
		input.close();
		return listaControle;
		
	}

}
