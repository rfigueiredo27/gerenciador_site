package br.jus.trerj.controle.destaque;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Destaque;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.Parametros;

public class ListaDestaques {

	public ArrayList<Destaque> getListaDestaques(String vtexto, String vativo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaDestaque();
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", vusuario, vsenha);
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT a.id_Conteudo, a.id_arquivo, a.descricao, c.observacao, to_char(ca.data_inicio_exib,'dd/mm/yyyy') as data_inicio_exib, " +
						"to_char(ca.data_fim_exib,'dd/mm/yyyy') as data_fim_exib, a.nome, a.ordem, a.publicado, " +
						"Nvl((SELECT Nvl(id_arquivo,0) FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ordem = 1),0) AS anexo " +
						//"Nvl((SELECT Nvl(descricao,'') FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ordem = 1),0) AS descricaoAnexo " +
						"FROM gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c " +
						"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = c.id_Conteudo AND ca.id_area = ? AND a.ordem = 0 ";
		if (!vtexto.equals(""))
			vsql = vsql + "and upper(a.descricao) like upper(?) ";
		if (!vativo.equals("todos"))
			if (vativo.equals("0"))
				vsql = vsql + "and a.publicado = ? ";
			else
				vsql = vsql + "and a.publicado >= ? ";
		vsql = vsql + "ORDER BY a.publicado, a.ordem, a.id_arquivo ";
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vidArea);
		int contaParam = 2;
		if (!vtexto.equals(""))
			pstm.setString(contaParam++, "%" + vtexto + "%");
		if (!vativo.equals("todos"))
			pstm.setString(contaParam++, vativo);	
		ResultSet rs = pstm.executeQuery();
		ArrayList<Destaque> listaDestaques = new ArrayList<Destaque>();
		while (rs.next())
		{
			Destaque destaque = new Destaque();
			destaque.setIdConteudo(rs.getString("id_Conteudo"));
			destaque.setDescricao(rs.getString("descricao"));
			destaque.setDataFim(rs.getString("data_fim_exib"));
			destaque.setDataIni(rs.getString("data_inicio_exib"));
			destaque.setIdArquivo(rs.getString("id_Arquivo"));
			destaque.setNomeArquivo(rs.getString("nome"));
			destaque.setObservacao(rs.getString("observacao"));
			destaque.setOrdem(rs.getInt("ordem"));
			destaque.setPublicado(rs.getInt("publicado"));
			destaque.setTemAnexo(rs.getInt("anexo"));
			//destaque.setAnexo(rs.getInt("anexo"));
			//destaque.setDescricaoAnexo(rs.getString("descricaoAnexo"));
			listaDestaques.add(destaque);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaDestaques;
		
	}
		
	
	public ArrayList<Anexo> getListaAnexos(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		/*System.out.println(System.getProperties());
		System.out.println(System.getProperty("user.name"));
		 NTSystem infoSystem = new NTSystem();  
	        System.out.println(infoSystem.getName()); // username logado no windows/domínio  
	        System.out.println(infoSystem.getDomain()); // nome do dominio do sistema windows
	        System.out.println(System.getenv("USERNAME"));*/
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT a.ordem, a.id_arquivo, a.descricao, (SELECT Count(*) FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ordem > 0) AS total " + 
					"FROM gecoi.arquivo a WHERE a.id_conteudo = ? AND a.ordem > 0 order by a.ordem";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));
		ResultSet rs = pstm.executeQuery();
		ArrayList<Anexo> listaAnexos = new ArrayList<Anexo>();
		while (rs.next())
		{
			Anexo anexo = new Anexo();
			anexo.setDescricao(rs.getString("descricao"));
			anexo.setIdArquivo(rs.getInt("id_Arquivo"));
			anexo.setOrdem(rs.getInt("ordem"));
			anexo.setTotal(rs.getInt("total"));
			listaAnexos.add(anexo);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaAnexos;
		
	}
	
}
