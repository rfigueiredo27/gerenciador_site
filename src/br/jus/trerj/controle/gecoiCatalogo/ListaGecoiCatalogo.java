package br.jus.trerj.controle.gecoiCatalogo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.GecoiArquivo;
import br.jus.trerj.modelo.GecoiCatalogo;
import br.jus.trerj.modelo.Parametros;

public class ListaGecoiCatalogo {

	public List<GecoiCatalogo> getGrupo(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiCatalogo> lista_grupos = new ArrayList<GecoiCatalogo>();
		String vsql = "";

		vsql = "SELECT DISTINCT gc.id_grupo, g.descricao FROM gecoi.grupo g, gecoi.grupo_catalogo gc, gecoi.permissao p " +
				"WHERE g.id_grupo=gc.id_grupo AND g.id_grupo=p.id_grupo " +
				"AND Upper(p.logon_usuario) = Upper(?) ORDER BY g.descricao";

		PreparedStatement pstm = conexao.prepareStatement(vsql);				 
		pstm.setString(1, vusuario);
		ResultSet rs = pstm.executeQuery();
		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setId_grupo(rs.getString("id_grupo"));
			gecoi.setDescricao_grupo(rs.getString("descricao"));
			lista_grupos.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_grupos;

	}

	public List<GecoiCatalogo> getListaArea(String vusuario, String vsenha, int vtipo, int vgrupo, int vcatalogo) throws ClassNotFoundException, SQLException
	{

		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<GecoiCatalogo> lista_areas = new ArrayList<GecoiCatalogo>();
		String vsql = "";
		int conta_var = 0;
		//int conta;

		if (vcatalogo == 0)
		{
			vsql = "select distinct a.id_area, a.descricao " +
					"FROM  gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga " +
					"where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo ";										 
		}
		else
		{
			vsql = "SELECT distinct a.id_area, a.descricao " +
					"FROM  gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga, gecoi.conteudo_area ca " +
					"where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo AND ga.id_area = ca.id_area ";
		}

		if (vtipo > 0)
		{
			vsql = vsql + "AND a.tipo_area = ? ";
		}
		if (vgrupo > 0)
		{
			vsql = vsql + "AND g.id_grupo = ? ";
		}
		if (vcatalogo > 0)
		{
			vsql = vsql + "AND (ca.id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_catalogo WHERE id_catalogo = ?) OR " +
					"ca.id_conteudo IN (SELECT id_conteudo FROM gecoi.arquivo_catalogo WHERE id_catalogo = ?)) ";
		}

		vsql = vsql + "ORDER BY a.descricao ";

		PreparedStatement pstm = conexao.prepareStatement(vsql);				 
		if (vtipo > 0)
		{
			conta_var++;						
			pstm.setInt(conta_var,vtipo);
		}
		if (vgrupo > 0)
		{
			conta_var++;
			pstm.setInt(conta_var,vgrupo);
		}                                                            							  
		if (vcatalogo > 0)
		{
			conta_var++;
			pstm.setInt(conta_var,vcatalogo);
			conta_var++;
			pstm.setInt(conta_var,vcatalogo);
		}                                                            							  

		ResultSet rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setId_area(rs.getInt("id_area"));
			gecoi.setDescricao_area(rs.getString("descricao"));
			lista_areas.add(gecoi);
		}

		rs.close();
		conexao.close();
		return lista_areas;
	}

	public List<GecoiCatalogo> getCatalogo(String vusuario, String vsenha, String vcatalogo, String vano, int vordem, String vtexto, int varea, int vtipo) throws ClassNotFoundException, SQLException
	{
//		System.out.println(vusuario);
//		System.out.println(vsenha);
//		System.out.println(vcatalogo);
//		System.out.println(vano);
//		System.out.println(vordem);
//		System.out.println(vtexto);
//		System.out.println(varea);
//		System.out.println(vtipo);
		
		vtexto = "";
		Parametros parametro = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametro.getBanco(), vusuario, vsenha);
		PreparedStatement pstm;
		ResultSet rs;
		String vsql;
		List<GecoiCatalogo> lista_catalogo = new ArrayList<GecoiCatalogo>();
		int parametros  = 2;

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//seleciona os conteuúdos com os parâmetros informados
		vsql = "SELECT To_Char(ca.data_inicio_exib,'yyyy') as ano, ca.data_inicio_exib, Nvl(ac.descricao, r.descricao) AS descricao, ac.id_catalogo, r.id_arquivo, ac.id_conteudo, 'arquivo' as tabela, " +
				"To_Char(ca.data_inicio_exib, 'dd/mm/yyyy') AS data, To_Char(ca.data_inicio_exib,'mm') AS mes, To_Char(ca.data_inicio_exib,'yyyy') AS ano, nvl(r.nome_arquivo_reduzido,'X') as reduzido " +
				"FROM gecoi.arquivo_catalogo ac, gecoi.conteudo_area ca, gecoi.arquivo r, gecoi.area ar " +
				"WHERE ac.id_conteudo = ca.id_conteudo AND ca.id_conteudo = r.id_conteudo AND ac.id_arquivo = r.id_arquivo AND ca.id_area = ar.id_area AND ac.id_catalogo = ? ";
		if (!vano.equals("0"))
		{
			vsql = vsql + "AND To_Char(ca.data_inicio_exib,'yyyy') = ? ";
		}			 
		if (varea > 0)
		{
			vsql = vsql + "AND ar.id_area = ? ";
		}			 
		if (vtipo > 0)
		{
			vsql = vsql + "AND ar.tipo_area = ? ";
		}			 
		if (!vtexto.equals(""))
		{
			// se o conteudo_catalogo.descricao for nulo é preciso fazer o filtro pelo arquivo.descricao
			vsql = vsql + "and ((Upper(ac.descricao) like Upper(?)) OR ((ac.descricao IS NULL) AND (Upper(r.descricao) like Upper(?)))) ";
			vtexto = "%" + vtexto + "%";
		}

		vsql = vsql + "UNION ALL " +
				"SELECT To_Char(ca.data_inicio_exib,'yyyy') as ano, ca.data_inicio_exib, Nvl(c.descricao, r.descricao) AS descricao, a.id_catalogo, r.id_arquivo, ca.id_conteudo, 'conteudo' as tabela, " +
				"To_Char(ca.data_inicio_exib, 'dd/mm/yyyy') AS data, To_Char(ca.data_inicio_exib,'mm') AS mes, To_Char(ca.data_inicio_exib,'yyyy') AS ano, nvl(r.nome_arquivo_reduzido,'X') as reduzido " +
				"FROM gecoi.catalogo a, gecoi.conteudo_catalogo c, gecoi.conteudo_area ca, gecoi.arquivo r, gecoi.area ar " +
				"WHERE  a.id_catalogo = c.id_catalogo AND c.id_conteudo = ca.id_conteudo AND c.id_conteudo = r.id_conteudo " +
				"AND r.ordem=0 AND ca.id_area = ar.id_area AND a.id_catalogo=?  ";
		if (!vano.equals("0"))
		{
			vsql = vsql + "AND To_Char(ca.data_inicio_exib,'yyyy') = ? ";
		}			 
		if (varea > 0)
		{
			vsql = vsql + "AND ar.id_area = ? ";
		}			 
		if (vtipo > 0)
		{
			vsql = vsql + "AND ar.tipo_area = ? ";
		}			 
		if (!vtexto.equals(""))
		{
			// se o conteudo_catalogo.descricao for nulo é preciso fazer o filtro pelo arquivo.descricao
			vsql = vsql + "and ((Upper(c.descricao) like Upper(?)) OR ((c.descricao IS NULL) AND (Upper(r.descricao) like Upper(?)))) ";
			vtexto = "%" + vtexto + "%";
		}

		if (vordem == 1)
		{
			vsql = vsql + "ORDER BY 1, 2, 3, id_conteudo, Descricao";
		}
		else
		{
			vsql = vsql + "ORDER BY 1, 3, 2, id_conteudo, Descricao";
		}

		pstm = conexao.prepareStatement(vsql);
		pstm.setString(1,vcatalogo);
		parametros = 1;
		if (!vano.equals("0"))
		{
			parametros++; 
			pstm.setString(parametros,vano);
		}
		if (varea > 0)
		{
			parametros++; 
			pstm.setInt(parametros,varea);
		}
		if (vtipo > 0)
		{
			parametros++; 
			pstm.setInt(parametros,vtipo);
		}	  
		if (!vtexto.equals(""))
		{
			parametros++; 
			pstm.setString(parametros,vtexto);
			parametros++; 
			pstm.setString(parametros,vtexto);
		}

		parametros++; 
		pstm.setString(parametros,vcatalogo);
		if (!vano.equals("0"))
		{
			parametros++; 
			pstm.setString(parametros,vano);
		}
		if (varea > 0)
		{
			parametros++; 
			pstm.setInt(parametros,varea);
		}
		if (vtipo > 0)
		{
			parametros++; 
			pstm.setInt(parametros,vtipo);
		}	  
		if (!vtexto.equals(""))
		{
			parametros++; 
			pstm.setString(parametros,vtexto);
			parametros++; 
			pstm.setString(parametros,vtexto);
		}

		rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setData(rs.getString("data"));
			gecoi.setId_conteudo(rs.getString("id_conteudo"));
			gecoi.setId_catalogo(rs.getString("id_catalogo"));
			gecoi.setDescricao_catalogo(rs.getString("Descricao"));
			gecoi.setId_arquivo(rs.getString("id_arquivo"));
			gecoi.setAno(rs.getString("ano"));
			gecoi.setNome_reduzido(rs.getString("reduzido"));
			gecoi.setTabela(rs.getString("tabela"));
			lista_catalogo.add(gecoi);
		}

		rs.close();
		conexao.close();
		return lista_catalogo;
	}

	public List<GecoiCatalogo> getAno(String vusuario, String vsenha, int varea, int vgrupo, int vtipo, int vcatalogo, String vano) throws ClassNotFoundException, SQLException
	{
		int contaParam = 0;
		Parametros parametro = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametro.getBanco(), vusuario, vsenha);
		PreparedStatement pstm;
		ResultSet rs;
		String vsql;
		List<GecoiCatalogo> lista_anos = new ArrayList<GecoiCatalogo>();
		if (vcatalogo > 0)
		{
			//seleciona os anos que tem arquivos cadastrados
			vsql = "SELECT DISTINCT ano FROM ( " +
					"SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano " +
					"FROM gecoi.catalogo c, gecoi.arquivo_catalogo ac, gecoi.conteudo_area ca, gecoi.area a " +
					"WHERE c.id_catalogo = ac.id_catalogo AND ac.id_conteudo = ca.id_conteudo AND ca.id_area = a.id_area " +
					"AND c.id_catalogo = ? ";
			if (varea > 0)
			{
				vsql = vsql + "AND a.id_area = ? ";
			}
			if (vtipo > 0)
			{
				vsql = vsql + "AND a.tipo_area = ? ";
			}
			vsql = vsql + "UNION ALL " +
					"SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano " +
					"FROM gecoi.catalogo c, gecoi.conteudo_catalogo cc, gecoi.conteudo_area ca, gecoi.area a " +
					"WHERE c.id_catalogo = cc.id_catalogo AND cc.id_conteudo = ca.id_conteudo AND ca.id_area = a.id_area " +
					"AND c.id_catalogo = ? ";			   
			if (varea > 0)
			{
				vsql = vsql + "AND a.id_area = ? ";
			}
			if (vtipo > 0)
			{
				vsql = vsql + "AND a.tipo_area = ? ";
			}
			vsql = vsql + ") order by 1 desc";

			pstm = conexao.prepareStatement(vsql);

			// poe os parametros da primeira parte do union	   
			pstm.setInt(1,vcatalogo);
			contaParam++;
			if (varea > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,varea);
			}
			if (vtipo > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,vtipo);
			}
			// poe os parametros da segunda parte do union
			contaParam++;
			pstm.setInt(contaParam,vcatalogo);
			if (varea > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,varea);
			}
			if (vtipo > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,vtipo);
			}

		}
		else
		{
			//seleciona os anos que tem arquivos cadastrados
			vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano " +
					"FROM gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga, gecoi.conteudo_area ca " +
					"where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo AND a.id_area = ca.id_area ";			   

			if (varea > 0)
			{
				vsql = vsql + "AND a.id_area = ? ";
			}
			if (vgrupo > 0)
			{
				vsql = vsql + "AND g.id_grupo = ? ";
			}
			if (vtipo > 0)
			{
				vsql = vsql + "AND a.tipo_area = ? ";
			}

			vsql = vsql + "order by 1 desc ";

			pstm = conexao.prepareStatement(vsql);
			if (varea > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,varea);
			}
			if (vgrupo > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,vgrupo);
			}
			if (vtipo > 0)
			{
				contaParam++;
				pstm.setInt(contaParam,vtipo);
			}
		}

		rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setAno(rs.getString("ano"));
			lista_anos.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_anos;
	}

	public List<GecoiCatalogo> getComboCatalogo(String vusuario, String vsenha, int vgrupo) throws ClassNotFoundException, SQLException
	{
		Parametros parametro = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametro.getBanco(), vusuario, vsenha);
		PreparedStatement pstm;
		ResultSet rs;
		String vsql;
		List<GecoiCatalogo> lista_combo_catalogo = new ArrayList<GecoiCatalogo>();
		vsql = "SELECT c.id_catalogo, c.descricao FROM  gecoi.catalogo c, gecoi.grupo_catalogo gc " +
				"WHERE c.id_catalogo = gc.id_catalogo AND gc.id_grupo=? " +
				"ORDER BY c.descricao";
		pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vgrupo);
		rs = pstm.executeQuery();
		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setId_catalogo(rs.getString("id_catalogo"));
			gecoi.setCombo_catalogo(rs.getString("descricao"));
			lista_combo_catalogo.add(gecoi);
		}
		rs.close(); 
		conexao.close();
		return lista_combo_catalogo;
	}

	public List<GecoiCatalogo> getTipos(String vusuario, String vsenha, int varea, int vgrupo, int vcatalogo) throws ClassNotFoundException, SQLException
	{
		int conta_var = 0;
		int conta;
		Parametros parametro = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametro.getBanco(), vusuario, vsenha);
		PreparedStatement pstm;
		ResultSet rs;
		String vsql;
		List<GecoiCatalogo> lista_tipos = new ArrayList<GecoiCatalogo>();
		if (vcatalogo == 0)
		{
			vsql = "select distinct a.tipo_area, decode(a.tipo_area, 1, 'Arquivos', 2, 'Avisos', 3, 'Álbum', 4, 'Calendário') as Descricao " +
					"FROM  gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga " +
					"where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo AND a.tipo_area <> 4 ";										 
		}
		else
		{
			vsql = "SELECT distinct a.tipo_area, decode(a.tipo_area, 1, 'Arquivos', 2, 'Avisos', 3, 'Álbum', 4, 'Calendário') as Descricao " +
					"FROM  gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga, gecoi.conteudo_area ca " +
					"where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo AND ga.id_area = ca.id_area AND a.tipo_area <> 4 ";
		}

		if (varea > 0)
		{
			vsql = vsql + "AND a.id_area = ? ";
		}
		if (vgrupo > 0)
		{
			vsql = vsql + "AND g.id_grupo = ? ";
		}
		if (vcatalogo > 0)
		{
			vsql = vsql + "AND (ca.id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_catalogo WHERE id_catalogo = ?) OR " +
					"ca.id_conteudo IN (SELECT id_conteudo FROM gecoi.arquivo_catalogo WHERE id_catalogo = ?)) ";
		}

		vsql = vsql + "ORDER BY descricao ";

		pstm = conexao.prepareStatement(vsql);				 
		if (varea > 0)
		{
			conta_var++;						
			pstm.setInt(conta_var,varea);
		}
		if (vgrupo > 0)
		{
			conta_var++;
			pstm.setInt(conta_var,vgrupo);
		}                                                            							  
		if (vcatalogo > 0)
		{
			conta_var++;
			pstm.setInt(conta_var,vcatalogo);
			conta_var++;
			pstm.setInt(conta_var,vcatalogo);
		}                                                            							  

		rs = pstm.executeQuery();

		while (rs.next())
		{
			GecoiCatalogo gecoi = new GecoiCatalogo();
			gecoi.setTipo_area(rs.getString("tipo_area"));
			gecoi.setDescricao_tipo(rs.getString("descricao"));
			lista_tipos.add(gecoi);
		}

		rs.close(); 
		conexao.close();
		return lista_tipos;
	}

}
