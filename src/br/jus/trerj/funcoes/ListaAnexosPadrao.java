package br.jus.trerj.funcoes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.Parametros;

public class ListaAnexosPadrao {
	
	
	public List<Anexo> getListaAnexos(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Anexo> Anexo = new ArrayList<Anexo>();
		
		String vsql = "	SELECT a.ordem, a.id_conteudo, a.id_arquivo, a.descricao, co.descricao as descricaoConteudo " +
					  "from gecoi.arquivo a, gecoi.conteudo co " + 
					  "WHERE a.ordem > 0 AND a.id_conteudo =  ? and a.id_conteudo = co.id_conteudo " +
					  "order by ordem ";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
	    pstm.setInt(1,Integer.parseInt(vidConteudo));

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			Anexo anexo = new Anexo();
			anexo.setIdArquivo(rs.getInt("id_arquivo"));
			anexo.setIdConteudo(rs.getInt("id_conteudo"));
			anexo.setDescricao(rs.getString("descricao"));
			anexo.setDescricaoConteudo(rs.getString("descricaoConteudo"));
			anexo.setOrdem(rs.getInt("ordem"));
			Anexo.add(anexo);
		}
		rs.close();
		conexao.close();
		return Anexo;
		
	}

}
