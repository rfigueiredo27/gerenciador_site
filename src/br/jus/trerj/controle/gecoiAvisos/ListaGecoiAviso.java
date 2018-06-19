package br.jus.trerj.controle.gecoiAvisos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.ExtratoLicitacao;
import br.jus.trerj.modelo.GecoiAviso;
import br.jus.trerj.modelo.Licitacao;
import br.jus.trerj.modelo.Parametros;
import br.jus.trerj.modelo.RelatorioLicitacao;
import br.jus.trerj.modelo.StatusLicitacao;

public class ListaGecoiAviso {
	//int vidArea = parametros.getVidAreaContrato();

	public List<Integer> getAnos(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
		String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
				"from gecoi.conteudo_area " +
				"WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE '%Aviso%') " +
				"order by To_Char(data_inicio_exib, 'yyyy') DESC";               
		PreparedStatement pstm = conexao.prepareStatement(vsql);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{	
			ano.add(rs.getInt("ano"));
		}
		rs.close();
		conexao.close();
		return ano;
	}

	public List<GecoiAviso> getDestino(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiAviso> lista_gecoi = new ArrayList<GecoiAviso>();

		//String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
		//             "from gecoi.conteudo_area " +
		//             "WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') " +
		//             "AND To_Char(data_inicio_exib, 'yyyy') >= '2013' " +
		//             "order by To_Char(data_inicio_exib, 'yyyy') DESC";               

		String vsql = "select a.id_area, a.descricao " +
				"FROM  gecoi.grupo_area ga, gecoi.area a, gecoi.permissao p " +
				"WHERE ga.id_area=a.id_area AND ga.id_grupo=p.id_grupo " +
				"AND Upper(p.logon_usuario)=UPPER('" + vusuario + "') " +
				"AND a.tipo_area=2 ORDER BY a.descricao ";

		PreparedStatement pstm = conexao.prepareStatement(vsql);

		ResultSet rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiAviso gecoi = new GecoiAviso();
			gecoi.setIdArea(rs.getInt("id_area"));
			gecoi.setDescricao(rs.getString("descricao"));
			lista_gecoi.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_gecoi;
	}

	public List<GecoiAviso> getListaAvisos(int idArea, int vidAno, String vusuario, String vsenha) throws ClassNotFoundException, SQLException{

		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiAviso> lista_gecoi = new ArrayList<GecoiAviso>();
		
		
		//vano = 2017;
		//varea = 132;

		String vsql = "SELECT To_Char(a.data_inclusao,'dd/mm/yyyy') as data, To_Char(a.data_inclusao,'HH24:mi:ss') as hora, a.descricao AS titulo, a.id_arquivo, a.id_conteudo, " +
				"c.logon_usuario_criacao AS usuario_publicador, decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',To_Char(c.data_ult_alteracao,'dd.mm.yyyy HH24:mi')) AS ultima_alteracao, " +
				"decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',c.logon_usuario_ult_alteracao) AS usuario_alteracao, To_Char(a.data_inclusao,'mm') AS mes " + 
				"FROM gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca " +
				"WHERE c.id_conteudo=ca.id_conteudo AND a.id_conteudo=c.id_conteudo " +
				"and a.ordem=0 AND To_Char(a.data_inclusao,'yyyy')=? AND ca.id_area=? ";
				//"and a.ordem=0 AND To_Char(a.data_inclusao,'yyyy')=2017 and ca.id_area=132 ";

		//if (varea.indexOf(",")>0){
		//	vsql = vsql +  "AND ca.id_area in (?) ";
		//}
		//else{
		//	vsql = vsql +  "AND ca.id_area=? ";
		//}

		//stmt = conexao.prepareStatement(vsql);
		//stmt.setInt(1, varea);
		//stmt.setInt(2, vano);
		//rs = stmt.executeQuery();
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1, vidAno);
		pstm.setInt(2, idArea);

		ResultSet rs = pstm.executeQuery();
		
		while (rs.next())
		{
			GecoiAviso gecoi = new GecoiAviso();
			gecoi.setDataPublicacao(rs.getString("data"));
			gecoi.setHoraPublicacao(rs.getString("hora"));
			gecoi.setDescricao(rs.getString("titulo"));
			gecoi.setIdArquivo(rs.getInt("id_arquivo"));
			gecoi.setIdConteudo(rs.getInt("id_conteudo"));
			gecoi.setUsuario(rs.getString("usuario_publicador"));
			gecoi.setDataAlteracao(rs.getString("ultima_alteracao"));
			gecoi.setUsuario_ateracao(rs.getString("usuario_alteracao"));
			gecoi.setMes(rs.getString("usuario_alteracao"));
			gecoi.setIdArea(rs.getInt("mes"));
			lista_gecoi.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_gecoi;

	}
	
	public List<Integer> getListaAnoStatus(int vidArea, String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
	    String vsql = "SELECT To_Char(c.data_inicio_exib, 'yyyy') AS Ano FROM gecoi.arquivo a, gecoi.conteudo_area c " +
	    				"WHERE c.id_area = ? AND a.id_conteudo = c.id_conteudo " +
	    				"GROUP BY To_Char(c.data_inicio_exib, 'yyyy') ORDER BY To_Char(c.data_inicio_exib, 'yyyy') desc ";
		PreparedStatement pstm = conexao.prepareStatement(vsql);

		if (vidArea > 0)
			pstm.setInt(1, vidArea);
		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{	
			ano.add(rs.getInt("ano"));
		}
		rs.close();
		conexao.close();
		return ano;
	}
	
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
