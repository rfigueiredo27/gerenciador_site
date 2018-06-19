package br.jus.trerj.controle.documentoEliminacao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.DocumentoEliminacao;
import br.jus.trerj.modelo.ExtratoLicitacao;
import br.jus.trerj.modelo.GecoiAviso;
import br.jus.trerj.modelo.GecoiCatalogo;
import br.jus.trerj.modelo.Licitacao;
import br.jus.trerj.modelo.Parametros;
import br.jus.trerj.modelo.RelatorioLicitacao;
import br.jus.trerj.modelo.StatusLicitacao;

public class ListaDocumentosEliminacao {
	//int vidArea = parametros.getVidAreaContrato();

	public List<DocumentoEliminacao> getUnidades(String vusuario, String vsenha) throws ClassNotFoundException, SQLException{
		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<DocumentoEliminacao> lista_grupos = new ArrayList<DocumentoEliminacao>();
		
		String vsql = "";
		vsql = "SELECT Upper(login_servidor), sigla_lotacao, descricao_lotacao from guardiao.servidores_ativos where login_servidor = Upper(?) ";
		PreparedStatement pstm = conexao.prepareStatement(vsql);				 
		pstm.setString(1, vusuario);
		ResultSet rs = pstm.executeQuery();
		while (rs.next())
		{
			DocumentoEliminacao gecoi = new DocumentoEliminacao();
			gecoi.setUnidade(rs.getString("descricao_lotacao"));
			lista_grupos.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_grupos;

	
	}
	
public List<DocumentoEliminacao> getGrupo_gecoi(String vusuario, String vsenha) throws ClassNotFoundException, SQLException{
		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<DocumentoEliminacao> lista_grupos = new ArrayList<DocumentoEliminacao>();
		String vsql = "";

		vsql = "SELECT DISTINCT g.descricao FROM gecoi.grupo g, gecoi.permissao p	WHERE g.id_grupo=p.id_grupo AND g.descricao NOT LIKE '%AVISOS%'	AND Upper(p.logon_usuario) = Upper(?) ORDER BY g.descricao";

		PreparedStatement pstm = conexao.prepareStatement(vsql);				 
		pstm.setString(1, vusuario);
		ResultSet rs = pstm.executeQuery();
		while (rs.next())
		{
			DocumentoEliminacao gecoi = new DocumentoEliminacao();
			gecoi.setUnidade(rs.getString("descricao"));
			lista_grupos.add(gecoi);
		}
		rs.close();
		conexao.close();
		return lista_grupos;

	
	}

	public List<DocumentoEliminacao> getListaDocumentos(String vusuario, String vsenha) throws ClassNotFoundException, SQLException{

		
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		List<DocumentoEliminacao> documentos = new ArrayList<DocumentoEliminacao>();
		
		
		int idArea = 2658; //Área correspondente a Eliminação de Documentos
		int id_grupo = 0;

		String vsql = "SELECT To_Char(a.data_inclusao,'dd/mm/yyyy') as data, To_Char(a.data_inclusao,'HH24:mi:ss') as hora, a.descricao, c.observacao as obs, a.publicado as edital, a.id_arquivo, a.id_conteudo, " +
				"c.logon_usuario_criacao AS usuario_publicador, decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',To_Char(c.data_ult_alteracao,'dd.mm.yyyy HH24:mi')) AS ultima_alteracao, " +
				"decode(Sign(c.data_ult_alteracao-a.data_inclusao),-1,'-',0,'-',NULL,'-',c.logon_usuario_ult_alteracao) AS usuario_alteracao, To_Char(a.data_inclusao,'mm') AS mes " + 
				"FROM gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca " +
				"WHERE c.id_conteudo=ca.id_conteudo AND a.id_conteudo=c.id_conteudo " +
				"and a.ordem=0 AND ca.id_area=?";

//		vsql = "SELECT distinct aq.id_conteudo, aq.descricao, To_Char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, To_Char(ca.data_inicio_exib,'mm') AS mes, "+
//		         "To_Char(ca.data_inicio_exib,'yyyy') AS Ano, aq.id_arquivo, To_Char(ca.data_inicio_exib,'dd') as dia, decode(aq.ordem,0,'Principal','Anexo') as Tipo " +
//	             "FROM gecoi.arquivo aq, gecoi.area a, gecoi.conteudo_area ca, gecoi.grupo g, gecoi.grupo_area ga " +
//	             "WHERE aq.id_conteudo = ca.id_conteudo AND ca.id_Area = a.id_area " +
//	             "AND a.id_area = ga.id_area AND ga.id_grupo = g.id_grupo " +
//				 "AND aq.id_arquivo NOT IN (SELECT r.id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = ?) " +
//				 "AND aq.id_arquivo <> ? ";
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1, idArea);

		ResultSet rs = pstm.executeQuery();
		
		while (rs.next())
		{
			DocumentoEliminacao gecoi = new DocumentoEliminacao();
			gecoi.setDataPublicacao(rs.getString("data"));
			gecoi.setHoraPublicacao(rs.getString("hora"));
			gecoi.setDescricao_arquivo(rs.getString("descricao"));
			String[] obs = rs.getString("obs").split(",");
			if(rs.getString("obs").split(",") != null)
			{
				gecoi.setUnidade(obs[0]);
				gecoi.setEdital(obs[1]);
			}
			else
			{ 
				gecoi.setUnidade(null);	
				gecoi.setEdital(null);
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
