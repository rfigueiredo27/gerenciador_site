package br.jus.trerj.controle.popup_metas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.PopupMetas;
import br.jus.trerj.modelo.Parametros;

public class Lista {
	
	
	public List<Integer> getMetas(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta","internauta");
		List<Integer> metas = new ArrayList<Integer>();
	    String vsql = "SELECT numero_meta FROM metas.zon_eleit_devedora_meta WHERE numero_meta < 999 GROUP BY numero_meta ORDER BY numero_meta" ;
		PreparedStatement pstm = conexao.prepareStatement(vsql);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			metas.add(rs.getInt("numero_meta"));
		}
		rs.close();
		conexao.close();
		return metas;
	}

	public PopupMetas getListaPopup(String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaPopupMetas();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "Select a.id_arquivo, ca.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, to_char(ca.data_fim_exib, 'dd/mm/yyyy') as data_fim_exib, a.nome " +
				  "from gecoi.conteudo_area ca, gecoi.arquivo a " +
				  "where ca.id_area = ? AND ca.id_conteudo = a.id_conteudo order by ca.id_conteudo";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
	    pstm.setInt(1,vidArea);

		ResultSet rs = pstm.executeQuery();

		rs.next(); 
		PopupMetas popupMeta = new PopupMetas();
		popupMeta.setNomeArquivo(rs.getString("nome"));
		popupMeta.setIdConteudo(rs.getString("id_conteudo"));
		popupMeta.setIdArquivo(rs.getString("id_arquivo"));
		popupMeta.setDataIni(rs.getString("data_inicio_exib"));
		popupMeta.setDataFim(rs.getString("data_fim_exib"));
		String vAno = rs.getString("data_fim_exib").substring(6,10);
		String[] vMesExt = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};
		popupMeta.setAno(vAno);
		int vMes = Integer.parseInt(rs.getString("data_fim_exib").substring(3,5)) - 2;
		if (vMes < 0)
			vMes = 0;
		popupMeta.setMesExt(vMesExt[vMes]);

		rs.close();
		conexao.close();
		return popupMeta;
		
	}

}
