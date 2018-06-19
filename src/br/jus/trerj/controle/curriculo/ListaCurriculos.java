package br.jus.trerj.controle.curriculo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Curriculo;
import br.jus.trerj.modelo.Parametros;

public class ListaCurriculos {

	

	public ArrayList<Curriculo> getListaCurriculos(String vtexto, String vativo) throws ClassNotFoundException, SQLException
	{
		String usuario = "";
		String senha = "";
		//int vidArea = 60;
		//vidArea = 1622; //teste
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
		int vidArea = parametros.getVidAreaCurriculo();
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), "internauta", "internauta");
		
		String vsql = "SELECT a.id_Conteudo, a.descricao, Nvl(publicado,0) AS publicado, " +
					  "(SELECT id_arquivo FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND Lower(SubStr(nome, Length(nome)-2, 3)) = 'htm' ) AS idArquivoTexto, " +
					  "(SELECT nome FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND Lower(SubStr(nome, Length(nome)-2, 3)) = 'htm' ) AS nomeArquivoTexto, " +
					  "(SELECT id_arquivo FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ((Lower(SubStr(nome, Length(nome)-2, 3)) = 'jpg') OR  (Lower(SubStr(nome, Length(nome)-2, 3)) = 'png'))) AS idArquivoImg,  " +
					  "(SELECT nome FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ((Lower(SubStr(nome, Length(nome)-2, 3)) = 'jpg') OR  (Lower(SubStr(nome, Length(nome)-2, 3)) = 'png'))) AS nomeArquivoImg  " +
						"FROM gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c " +
						"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = c.id_Conteudo AND ca.id_area = ? ";
		if (!vtexto.equals(""))
			vsql = vsql + "and upper(a.descricao) like upper(?) ";
		if (!vativo.equals("todos"))
			vsql = vsql + "and a.publicado = ? ";
		vsql = vsql + "GROUP BY a.id_Conteudo, a.descricao, publicado ORDER BY a.descricao ";

		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vidArea);
		int contaParam = 2;
		if (!vtexto.equals(""))
			pstm.setString(contaParam++, "%" + vtexto + "%");
		if (!vativo.equals("todos"))
			pstm.setInt(contaParam++, Integer.parseInt(vativo));	
		ResultSet rs = pstm.executeQuery();
		ArrayList<Curriculo> listaCurriculos = new ArrayList<Curriculo>();
		while (rs.next())
		{
			Curriculo curriculo = new Curriculo();
			curriculo.setIdConteudo(rs.getString("id_Conteudo"));
			curriculo.setDescricao(rs.getString("descricao"));
			//curriculo.setArquivo(rs.getClob("arquivo"));
			curriculo.setIdArquivoTexto(rs.getString("idArquivoTexto"));
			curriculo.setNomeArquivoTexto(rs.getString("nomeArquivoTexto"));
			curriculo.setIdArquivoImg(rs.getString("idArquivoImg"));
			curriculo.setNomeArquivoImg(rs.getString("nomeArquivoImg"));
			curriculo.setPublicado(Integer.parseInt(rs.getString("publicado")));
			listaCurriculos.add(curriculo);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaCurriculos;
		
	}
		
}
