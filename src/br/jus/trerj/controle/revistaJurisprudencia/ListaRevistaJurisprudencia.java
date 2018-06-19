package br.jus.trerj.controle.revistaJurisprudencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.RevistaJurisprudencia;
import br.jus.trerj.modelo.Parametros;

public class ListaRevistaJurisprudencia {
	//int vidArea = parametros.getVidAreaContrato();


	public List<RevistaJurisprudencia> getListaRevistaJurisprudencia(String vusuario, String vsenha) throws ClassNotFoundException, SQLException{

		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		List<RevistaJurisprudencia> documentos = new ArrayList<RevistaJurisprudencia>();
		
		
		int idArea = 1741; //�rea correspondente a Revista Jurisprudencia
		

		String vsql = "SELECT To_Char(a.data_inclusao,'dd/mm/yyyy') as data, To_Char(a.data_inclusao,'HH24:mi:ss') as hora, a.descricao, c.observacao as obs, a.publicado as edital, a.id_arquivo, a.id_conteudo, " +
				"c.logon_usuario_criacao AS usuario_publicador, decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',To_Char(c.data_ult_alteracao,'dd.mm.yyyy HH24:mi')) AS ultima_alteracao, " +
				"decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',c.logon_usuario_ult_alteracao) AS usuario_alteracao, To_Char(a.data_inclusao,'mm') AS mes " + 
				"FROM gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca " +
				"WHERE c.id_conteudo=ca.id_conteudo AND a.id_conteudo=c.id_conteudo " +
				"and a.ordem=0 AND ca.id_area=?";
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1, idArea);

		ResultSet rs = pstm.executeQuery();
		
		while (rs.next())
		{
			RevistaJurisprudencia gecoi = new RevistaJurisprudencia();
			gecoi.setDataPublicacao(rs.getString("data"));
			gecoi.setHoraPublicacao(rs.getString("hora"));
			gecoi.setDescricao_arquivo(rs.getString("descricao"));
			
			String[] descricao_completa = rs.getString("descricao").split(" ");
			//System.out.println(descricao_completa.length);
			
			if(descricao_completa.length == 7)
			{
				gecoi.setVolume(descricao_completa[4].replace(",", " "));
				gecoi.setNumero(descricao_completa[6].replace(",", " "));
			}
			else if(descricao_completa.length == 8) //N�o colocaram o volume
			{
				gecoi.setNumero(descricao_completa[4]);
				gecoi.setComplemento(descricao_completa[6]+" "+descricao_completa[7]);
				gecoi.setVolume("-");
				
			}
			else if(descricao_completa.length == 10)
			{
				gecoi.setVolume(descricao_completa[4].replace(",", " "));
				gecoi.setNumero(descricao_completa[6].replace(",", " "));
				gecoi.setComplemento(descricao_completa[8]+" "+ descricao_completa[9]);
			}
			else
			{
				gecoi.setVolume(descricao_completa[4].replace(",", " "));
				gecoi.setNumero(descricao_completa[5].replace(",", " "));
			}
			
			gecoi.setIdArquivo(rs.getInt("id_arquivo"));
			gecoi.setIdConteudo(rs.getInt("id_conteudo"));
			gecoi.setUsuario(rs.getString("usuario_publicador"));
			gecoi.setDataAlteracao(rs.getString("ultima_alteracao"));
			gecoi.setUsuario_ateracao(rs.getString("usuario_alteracao"));
			gecoi.setMes(rs.getString("usuario_alteracao"));
			gecoi.setMes(rs.getString("mes"));
			documentos.add(gecoi);
		}
		rs.close();
		conexao.close();
		return documentos;

	}
	
}
