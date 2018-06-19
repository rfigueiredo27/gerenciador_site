package br.jus.trerj.controle.gecoiArquivos;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.Arquivo;
import br.jus.trerj.modelo.ExtratoLicitacao;
import br.jus.trerj.modelo.GecoiArquivo;
import br.jus.trerj.modelo.GecoiAviso;
import br.jus.trerj.modelo.Licitacao;
import br.jus.trerj.modelo.Parametros;
import br.jus.trerj.modelo.RelatorioLicitacao;
import br.jus.trerj.modelo.StatusLicitacao;

public class ListaGecoiArquivos {
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

	public List<GecoiArquivo> getArea(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiArquivo> lista_gecoi = new ArrayList<GecoiArquivo>();

		//String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
		//             "from gecoi.conteudo_area " +
		//             "WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') " +
		//             "AND To_Char(data_inicio_exib, 'yyyy') >= '2013' " +
		//             "order by To_Char(data_inicio_exib, 'yyyy') DESC";               

		String vsql = "select a.id_area, (g.descricao || ' - ' || a.descricao) as descricao " +
	                  "FROM  gecoi.grupo_area ga, gecoi.area a, gecoi.permissao p, gecoi.grupo g " +
                "WHERE ga.id_area=a.id_area AND ga.id_grupo=g.id_grupo AND g.id_grupo=p.id_grupo " +
                "AND Upper(p.logon_usuario)=UPPER(?) " +
                "AND a.tipo_area=1 " +
				 "order by g.descricao, a.descricao";

		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setString(1, vusuario);
		ResultSet rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiArquivo gecoi = new GecoiArquivo();
			gecoi.setIdArea(rs.getInt("id_area"));
			gecoi.setDescricao_area(rs.getString("descricao"));
			lista_gecoi.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_gecoi;
	}
	
	public List<GecoiArquivo> getAreaById(String vusuario, String vsenha, String id_area) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiArquivo> lista_gecoi = new ArrayList<GecoiArquivo>();

		//String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
		//             "from gecoi.conteudo_area " +
		//             "WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') " +
		//             "AND To_Char(data_inicio_exib, 'yyyy') >= '2013' " +
		//             "order by To_Char(data_inicio_exib, 'yyyy') DESC";               

		String vsql = "select a.id_area, (g.descricao || ' - ' || a.descricao) as descricao " +
	                  "FROM  gecoi.grupo_area ga, gecoi.area a, gecoi.permissao p, gecoi.grupo g " +
                "WHERE ga.id_area=a.id_area AND ga.id_grupo=g.id_grupo AND g.id_grupo=p.id_grupo " +
                "AND Upper(p.logon_usuario)=UPPER(?) " +
                "AND a.tipo_area=1 AND a.id_area = ? " +
				 "order by g.descricao, a.descricao";

		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setString(1, vusuario);
		pstm.setInt(2, Integer.parseInt(id_area));
		ResultSet rs = pstm.executeQuery();

		if (rs.next())
		{
			GecoiArquivo gecoi = new GecoiArquivo();
			gecoi.setIdArea(rs.getInt("id_area"));
			gecoi.setDescricao_area(rs.getString("descricao"));
			lista_gecoi.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_gecoi;
	}

	public List<GecoiArquivo> getListaArquivos(int idArea, int vidAno, String vusuario, String vsenha) throws ClassNotFoundException, SQLException{

		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiArquivo> lista_gecoi = new ArrayList<GecoiArquivo>();
		
		
		//vano = 2017;
		//varea = 132;

		String vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'dd/mm/yyyy') as publicacao, a.descricao as nome_arquivo, c.descricao AS descricao_conteudo, "
				  +"c.observacao, a.id_arquivo, ca.id_area, a.id_conteudo, "
				  +"ar.descricao as descricao_area, "
				  +"c.logon_usuario_criacao AS usuario_publicador, nvl(To_Char(c.data_ult_alteracao,'dd/mm/yyyy - HH24:mi:ss'),'-') AS ultima_alteracao, "
				  +"nvl(c.logon_usuario_ult_alteracao,'-') AS usuario_alteracao, To_Char(ca.data_inicio_exib,'mm') AS mes, a.nome as nome, a.descricao as descricao_arquivo, "  
				  +"(SELECT Count(arq.id_arquivo) FROM gecoi.arquivo arq WHERE arq.id_conteudo = a.id_conteudo AND arq.ordem > 0) AS qtd_arquivo "			 
				  +"FROM gecoi.arquivo a "
				  +"JOIN gecoi.conteudo c ON a.id_conteudo=c.id_conteudo "
				  +"JOIN gecoi.conteudo_area ca ON c.id_conteudo=ca.id_conteudo "
				  +"JOIN gecoi.area ar ON ca.id_area = ar.id_area "
				  +"JOIN gecoi.grupo_area ga ON ga.id_area = ar.id_area "
				  +"WHERE ca.id_area=? and a.ordem=0 AND To_Char(ca.data_inicio_exib,'yyyy')=? ";
				
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1, idArea);
		pstm.setInt(2, vidAno);

		ResultSet rs = pstm.executeQuery();
		
		while (rs.next())
		{
			GecoiArquivo gecoi = new GecoiArquivo();
			gecoi.setDataPublicacao(rs.getString("publicacao"));
			gecoi.setNome_arquivo(rs.getString("nome_arquivo"));
			gecoi.setDescricao(rs.getString("descricao_arquivo"));
			gecoi.setDescricao_conteudo(rs.getString("descricao_conteudo"));
			gecoi.setObservacao(rs.getString("observacao"));
			gecoi.setIdArquivo(rs.getInt("id_arquivo"));
			gecoi.setIdConteudo(rs.getInt("id_conteudo"));
			gecoi.setUsuario(rs.getString("usuario_publicador"));
			gecoi.setDataAlteracao(rs.getString("ultima_alteracao"));
			gecoi.setUsuario_ateracao(rs.getString("usuario_alteracao"));
			gecoi.setIdArea(rs.getInt("id_area"));
			gecoi.setDescricao_area(rs.getString("descricao_area"));
			String  vnome = rs.getString("nome");
			vnome = vnome.substring(vnome.length()-4);
			gecoi.setArquivo_nome(vnome);
			//System.out.println(vnome);
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
