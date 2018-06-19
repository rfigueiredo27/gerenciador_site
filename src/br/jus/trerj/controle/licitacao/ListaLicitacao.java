package br.jus.trerj.controle.licitacao;

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
import br.jus.trerj.modelo.Licitacao;
import br.jus.trerj.modelo.Parametros;
import br.jus.trerj.modelo.RelatorioLicitacao;
import br.jus.trerj.modelo.StatusLicitacao;

public class ListaLicitacao {
	//int vidArea = parametros.getVidAreaContrato();

	public List<Integer> getAnos(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
 	   	String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
	                 "from gecoi.conteudo_area " +
	                 "WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') " +
	                 "AND To_Char(data_inicio_exib, 'yyyy') >= '2013' " +
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
	
	public List<Licitacao> getListaLicitacao(String vano, String vchave, String vfiltro, String vfiltroValor, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		int vcontaParam = 2;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidDataPublicacao = parametros.getVidDataPublicacao();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Licitacao> licitacoes = new ArrayList<Licitacao>();
		
		String vsql = "SELECT a.id_arquivo, a.id_conteudo, a.descricao, " +
					"Nvl((Select ad.valor from gecoi.campo_adicional ad where ad.id_tipo_campo_adicional = ? and a.id_arquivo = ad.id_arquivo), c.data_criacao) AS data_publicacao, " + 
			       "Decode (To_Char(ca.data_inicio_exib, 'HH24:mi'), '00:00', To_Char(ca.data_inicio_exib, 'dd/mm/yyyy'), To_Char(ca.data_inicio_exib, 'dd/mm/yyyy HH24:mi')) AS data_abertura, " +
				   "To_Char(ca.data_fim_exib, 'dd/mm/yyyy') AS data_fechamento, sysdate as hoje, c.observacao, data_inicio_exib, data_fim_exib  " +
				   "from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo c " +
				   "WHERE a.id_conteudo = ca.id_conteudo AND a.ordem = 0 AND ca.id_conteudo = c.id_conteudo " +
				   "AND ca.id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') ";
		
			if (!vano.equals("-----------"))
				vsql = vsql + "AND To_Char(ca.data_inicio_exib, 'yyyy') = ? ";

		    if (vchave.compareToIgnoreCase("") != 0)
			   vsql = vsql + "and upper(a.descricao) like upper(?) ";

			if (vfiltro.equals("modalidade"))
				vsql = vsql + "and ca.id_area = ? ";

			if (vfiltro.equals("abertura"))
				vsql = vsql + "and (to_char(ca.data_inicio_exib, 'dd/mm/yyyy') = ?) ";

		    vsql = vsql + "order by data_inicio_exib desc";

		    PreparedStatement pstm = conexao.prepareStatement(vsql);
			pstm.setInt(1, vidDataPublicacao);
			
		    if (!vano.equals("-----------"))
		    	pstm.setString(vcontaParam++,vano);

			if (vchave.compareToIgnoreCase("")!=0)
			   pstm.setString(vcontaParam++,"%" + vchave + "%");

			if (vfiltro.equals("modalidade"))
				pstm.setString(vcontaParam++,vfiltroValor);

			if (vfiltro.equals("abertura"))
				pstm.setString(vcontaParam++,vfiltroValor);

		ResultSet rs = pstm.executeQuery();
		String vsituacao = "";
		boolean mostra = true;
		while(rs.next()) 
		{		
			if (rs.getString("data_fechamento").equals("21/04/1500"))
				vsituacao = "Suspenso";
			else
				if (rs.getTimestamp("hoje").getTime() > rs.getTimestamp("data_fim_exib").getTime())
			   		vsituacao = "Concluído";
				else
					if (rs.getTimestamp("data_inicio_exib").getTime() < rs.getTimestamp("hoje").getTime())
						vsituacao = "Aberto";
					else
						if (rs.getString("data_fechamento").equals("15/11/1880"))
							vsituacao = "Revogado/Anulado";
						else
							vsituacao = "Publicado";
			mostra = true;
			if (vfiltro.equals("situacao"))
			{
				mostra = vfiltroValor.equals(vsituacao);
			}
				
			if (mostra)
			{
				
				String[] arrayDescricao = rs.getString("descricao").split("-",5);
				// tamanho menor que 4 dá erro pois a licitação está no formato antigo, então não mostro
				if (arrayDescricao.length >= 4)
				{
					Licitacao licitacao = new Licitacao();
					licitacao.setIdArquivo(rs.getString("id_arquivo"));
					licitacao.setIdConteudo(rs.getString("id_conteudo"));
					licitacao.setTipo(arrayDescricao[0]);
					licitacao.setNumPregao(arrayDescricao[1]);
					licitacao.setNumProcesso(arrayDescricao[2]);
					licitacao.setDescricao(arrayDescricao[3]);
					licitacao.setDataAbertura(rs.getString("data_abertura"));
					licitacao.setDataFechamento(rs.getString("data_fechamento"));
					if (rs.getString("data_fechamento").equals("21/04/1500"))
						vsituacao = "Suspenso";
					else
						if (rs.getTimestamp("hoje").getTime() > rs.getTimestamp("data_fim_exib").getTime())
							vsituacao = "Concluído";
						else
							if (rs.getTimestamp("data_inicio_exib").getTime() < rs.getTimestamp("hoje").getTime())
								vsituacao = "Aberto";
							else
								if (rs.getString("data_fechamento").equals("15/11/1880"))
									vsituacao = "Revogado/Anulado";
								else
									vsituacao = "Publicado";
					licitacao.setDataPublicacao(rs.getString("data_publicacao"));
					licitacao.setSituacao(vsituacao);
					licitacoes.add(licitacao);
				}
			}
		}
		rs.close();
		conexao.close();
		return licitacoes;
		
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

	public List<Integer> getListaAnoRelatorio(int vidArea, String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
	    String vsql = "SELECT Nvl(To_Char(d.data_download, 'yyyy'),'Nenhum download dessa modalidade foi realizado.') AS Ano " +
	    				"FROM gecoi.download_edital d, gecoi.arquivo a, gecoi.conteudo_area c " +
	    				"WHERE d.id_arquivo = a.id_arquivo AND a.id_conteudo = c.id_conteudo ";
	    if (vidArea > 0)
	    	vsql = vsql + "AND c.id_area = ? ";
	    vsql = vsql + "GROUP BY To_Char(d.data_download, 'yyyy') ORDER BY To_Char(d.data_download, 'yyyy') desc ";
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
	
	public List<Anexo> getListaDescricaoRelatorio(int vidArea, int vano, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Anexo> Anexo = new ArrayList<Anexo>();
		
		String vsql = "SELECT DISTINCT c.id_conteudo, c.id_area, CASE  WHEN length(descricao) > 65 THEN SubStr (descricao,1,50)  || '...' ELSE a.descricao END descricao_redu," +
				    " a.descricao, a.tamanho, a.id_Arquivo " +
	    			"FROM gecoi.conteudo_area c, gecoi.arquivo a, gecoi.download_edital d WHERE c.id_conteudo = a.id_conteudo ";
		if (vidArea > 0)
	          vsql = vsql + "AND c.id_Area = ? ";
		if (vano > 0)
			  vsql = vsql + "AND To_Char(d.data_download, 'yyyy') = ? ";
		vsql = vsql + "AND ordem = 0 AND a.id_arquivo = d.id_arquivo " +
				"ORDER BY a.descricao";

		PreparedStatement pstm = conexao.prepareStatement(vsql);
		int contaParam = 1;
		if (vidArea > 0)
			pstm.setInt(contaParam++,vidArea);
		if (vano > 0)
			pstm.setInt(contaParam++,vano);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			Anexo anexo = new Anexo();
			anexo.setIdArquivo(rs.getInt("id_arquivo"));
			anexo.setDescricaoRedu(rs.getString("descricao_redu"));
			anexo.setDescricao(rs.getString("descricao"));
			Anexo.add(anexo);
		}
		rs.close();
		conexao.close();
		return Anexo;
	}
		
		public List<RelatorioLicitacao> getListaRelatorioControle(int vidArea, int vano, int vidArquivo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			List<RelatorioLicitacao> RelatorioLicitacao = new ArrayList<RelatorioLicitacao>();
			
			   String vsql = "SELECT u.nome, u.cpf_cnpj, u.endereco, u.bairro, u.cidade, u.uf, u.nome_contato, nvl(u.email, '-') as email, u.telefone, u.fax, ";
		          vsql = vsql + "Decode(u.tipo_pessoa, 'F', 'Pessoa Física', 'Pessoa Jurídica') AS Pessoa, a.descricao, ";
		          vsql = vsql + "To_Char(e.data_download, 'dd/mm/yyyy') AS Data, To_Char(e.data_download, 'hh24:mi') AS Hora ";
		          vsql = vsql + "FROM gecoi.usuario u, gecoi.download_edital e, gecoi.arquivo a, gecoi.conteudo_area c, gecoi.area ar ";
		          vsql = vsql + "WHERE u.id_usuario = e.id_usuario AND e.id_arquivo = a.id_arquivo AND a.id_conteudo = c.id_conteudo AND c.id_area = ar.id_area ";
		          vsql = vsql + "And upper(u.email) <> upper('seinte@tre-rj.gov.br') And upper(u.email) <> upper('flima@tre-rj.gov.br') And upper(u.email) <> upper('gdebossa@tre-rj.gov.br')  ";
		          vsql = vsql + "And upper(u.email) <> upper('tpool@tre-rj.gov.br') And upper(u.email) <> upper('amattos@tre-rj.gov.br') And upper(u.email) <> upper('aaraujo@tre-rj.gov.br')  ";
		   
		   if (vidArea > 0)
		   {
		   	  vsql = vsql + "AND c.id_area = ? ";
		   }
		   if (vano > 0)
		   {
		   	  vsql = vsql + "AND To_Char(e.data_download, 'yyyy') = ? ";
		   }
		   if (vidArquivo > 0)
		   {
			  vsql = vsql + "AND a.id_arquivo = ? ";
		   }
		   vsql = vsql + " Order by a.descricao, u.nome ";

			PreparedStatement pstm = conexao.prepareStatement(vsql);
			int contaParam = 1;
			if (vidArea > 0)
				pstm.setInt(contaParam++,vidArea);
			if (vano > 0)
				pstm.setInt(contaParam++,vano);
			if (vidArquivo > 0)
				pstm.setInt(contaParam++,vidArquivo);

			ResultSet rs = pstm.executeQuery();

			while(rs.next()) 
			{
				RelatorioLicitacao relatorioLicitacao = new RelatorioLicitacao();
				relatorioLicitacao.setDescricao(rs.getString("descricao"));
				relatorioLicitacao.setNome(rs.getString("nome"));
				relatorioLicitacao.setBairro(rs.getString("bairro"));
				relatorioLicitacao.setCidade(rs.getString("cidade"));
				relatorioLicitacao.setCpf_cnpj(rs.getString("cpf_cnpj"));
				relatorioLicitacao.setData(rs.getString("data"));
				relatorioLicitacao.setEmail(rs.getString("email"));
				relatorioLicitacao.setEndereco(rs.getString("endereco"));
				relatorioLicitacao.setFax(rs.getString("fax"));
				relatorioLicitacao.setHora(rs.getString("hora"));
				relatorioLicitacao.setNome_contato(rs.getString("nome_contato"));
				relatorioLicitacao.setPessoa(rs.getString("pessoa"));
				relatorioLicitacao.setTelefone(rs.getString("telefone"));
				relatorioLicitacao.setUf(rs.getString("uf"));
				RelatorioLicitacao.add(relatorioLicitacao);
			}
			rs.close();
			conexao.close();
			return RelatorioLicitacao;
			
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
		
		public List<StatusLicitacao> getListaStatus(int vidArea, int vano, String vfiltro, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			List<StatusLicitacao> StatusLicitacao = new ArrayList<StatusLicitacao>();
			
		    String vsql = "SELECT c.id_conteudo, c.id_area, a.descricao, a.tamanho, a.id_Arquivo, To_Char(c.data_fim_exib, 'yyyymmdd') as data_fim, to_char(sysdate, 'yyyymmdd') as hoje " +
		    				"FROM gecoi.conteudo_area c, gecoi.arquivo a WHERE c.id_conteudo = a.id_conteudo " +
		    				"AND c.id_Area = ? AND ordem = 0 AND To_Char(c.data_inicio_exib, 'yyyy') = ? ";
			if (vfiltro.equals("A"))
			   	vsql = vsql + "and c.data_fim_exib > SYSDATE ";
			else
				if (vfiltro.equals("E"))
			   		vsql = vsql + "and c.data_fim_exib <= SYSDATE and to_char(c.data_fim_exib, 'dd/mm/yyyy') <> '21/04/1500' ";
				else
					if (vfiltro.equals("S"))
			   			vsql = vsql + "and to_char(c.data_fim_exib, 'dd/mm/yyyy') = '21/04/1500' ";
					else
						if (vfiltro.equals("R"))
							vsql = vsql + "and to_char(c.data_fim_exib, 'dd/mm/yyyy') = '15/11/1880' ";
			vsql = vsql + "ORDER BY a.descricao";

			PreparedStatement pstm = conexao.prepareStatement(vsql);
			pstm.setInt(1,vidArea);
		    pstm.setInt(2,vano);

			ResultSet rs = pstm.executeQuery();

			while(rs.next()) 
			{
				StatusLicitacao statusLicitacao = new StatusLicitacao();
				String[] aDescricao = rs.getString("descricao").split("-");
				statusLicitacao.setTipo(aDescricao[0]);
				if (aDescricao.length > 1)
				{
					statusLicitacao.setNumPregao(aDescricao[1]);
					if (aDescricao.length > 2)
					{
						statusLicitacao.setNumProcesso(aDescricao[2]);
						if (aDescricao.length > 3)
						{
							statusLicitacao.setDescricao(aDescricao[3]);
						}
					}
				}
				statusLicitacao.setIdConteudo(rs.getString("id_conteudo"));
				statusLicitacao.setDataFim(rs.getInt("data_fim"));
				statusLicitacao.setHoje(rs.getInt("hoje"));
				// no jstl o <c:if> não tá funcionando.  por isso eu mostro o botão ou não pela classe
				if (rs.getInt("data_fim") > rs.getInt("hoje"))
				{
					//statusLicitacao.setStatus("Aberto");
					statusLicitacao.setMostraEncerrar("visible");
					statusLicitacao.setMostraSuspender("visible");
					statusLicitacao.setMostraRevogar("visible");
					statusLicitacao.setMostraReabrir("hidden");
				}
				else
				{
					//statusLicitacao.setStatus("Encerrado");
					statusLicitacao.setMostraEncerrar("hidden");
					statusLicitacao.setMostraSuspender("hidden");
					statusLicitacao.setMostraRevogar("hidden");
					statusLicitacao.setMostraReabrir("visible");
				}
				/*if (rs.getInt("data_fim") == 18801115)
					statusLicitacao.setMostraRevogar("hidden");
				else
					statusLicitacao.setMostraRevogar("visible");*/
				StatusLicitacao.add(statusLicitacao);
			}
			rs.close();
			conexao.close();
			return StatusLicitacao;
			
	}
		
		public List<Integer> getListaAnoExtrato(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			List<Integer> ano = new ArrayList<Integer>();
			String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano " + 
				          "from gecoi.conteudo_area " +
				          "WHERE id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') AND To_Char(data_inicio_exib, 'yyyy') >= '2013' " +
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
		
		public List<ExtratoLicitacao> getListaExtrato(String vchave, int vano, String vfiltro, String vfiltroValor, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			int vidDataPublicacao = parametros.getVidDataPublicacao();

			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			List<ExtratoLicitacao> ExtratoLicitacao = new ArrayList<ExtratoLicitacao>();
			
			String vsql = "SELECT a.id_arquivo, a.id_conteudo, a.descricao, "+ 
				       "Decode (To_Char(ca.data_inicio_exib, 'HH24:mi'), '00:00', To_Char(ca.data_inicio_exib, 'dd/mm/yyyy'), To_Char(ca.data_inicio_exib, 'dd/mm/yyyy HH24:mi')) AS data_abertura, " +
					   "To_Char(ca.data_fim_exib, 'dd/mm/yyyy') AS data_fechamento, sysdate as hoje, c.observacao, data_inicio_exib, data_fim_exib, " +
					   "Nvl((Select ad.valor from gecoi.campo_adicional ad where ad.id_tipo_campo_adicional = ? and a.id_arquivo = ad.id_arquivo), c.data_criacao) AS data_publicacao, " +
					   "To_Char(c.data_criacao, 'dd/mm/yyyy HH24:mi') AS data_criacao " +
					   "from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo c " +
					   "WHERE a.id_conteudo = ca.id_conteudo AND a.ordem = 0 AND ca.id_conteudo = c.id_conteudo " +
					   "AND ca.id_area IN (SELECT id_area FROM gecoi.area WHERE descricao LIKE 'Licitação - %') " +
					   "AND To_Char(ca.data_inicio_exib, 'yyyy') = ? ";

			    if (vchave.compareToIgnoreCase("")!=0)
			       vsql = vsql + "and (upper(a.descricao) like upper(?) OR contains(arquivo,?) > 0) ";
				   
				if (vfiltro.equals("modalidade"))
				{
					vsql = vsql + "and ca.id_area = ? ";
				}

				if (vfiltro.equals("abertura"))
				{
					vsql = vsql + "and (to_char(ca.data_inicio_exib, 'dd/mm/yyyy') = ?) ";
				}

			    vsql = vsql + "order by data_inicio_exib desc";

			PreparedStatement pstm = conexao.prepareStatement(vsql);
			int vcontaParam     = 1;
			pstm.setInt(vcontaParam++,vidDataPublicacao);
			pstm.setInt(vcontaParam++,vano);
			
			if (vchave.compareToIgnoreCase("")!=0)
			{
			   pstm.setString(vcontaParam++,"%" + vchave + "%");
			   pstm.setString(vcontaParam++,vchave);
			}
			
			if (vfiltro.equals("modalidade"))
				pstm.setString(vcontaParam++,vfiltroValor);
				
			if (vfiltro.equals("abertura"))
				pstm.setString(vcontaParam++,vfiltroValor);


			ResultSet rs = pstm.executeQuery();
			boolean mostra      = true;
			String vsituacao 	= "";
			while(rs.next()) 
			{
				if (rs.getString("data_fechamento").equals("21/04/1500"))
					vsituacao = "Suspenso";
				else
					if (rs.getTimestamp("hoje").getTime() > rs.getTimestamp("data_fim_exib").getTime())
						vsituacao = "Concluido";
					else
						if (rs.getTimestamp("data_inicio_exib").getTime() < rs.getTimestamp("hoje").getTime())
							vsituacao = "Aberto";
						else
							if (rs.getString("data_fechamento").equals("15/11/1880"))
								vsituacao = "Revogado/Anulado";
							else
								vsituacao = "Publicado";
							
				mostra = true;
				if (vfiltro.equals("situacao"))
				{
					mostra = vfiltroValor.equals(vsituacao);
				}
					
				if (mostra)
				{
					String[] arrayDescricao = rs.getString("descricao").split("-",5);
					ExtratoLicitacao extratoLicitacao = new ExtratoLicitacao();
					extratoLicitacao.setTipo(arrayDescricao[0]);
					extratoLicitacao.setNumPregao(arrayDescricao[1].trim());
					extratoLicitacao.setDescricao(arrayDescricao[3].trim());
					extratoLicitacao.setNumProcesso(arrayDescricao[2].trim());
					extratoLicitacao.setIdConteudo(rs.getString("id_conteudo"));
					extratoLicitacao.setDataAbertura(rs.getString("data_abertura"));
					extratoLicitacao.setDataCriacao(rs.getString("data_criacao"));
					extratoLicitacao.setDataPublicacao(rs.getString("data_publicacao"));
					extratoLicitacao.setSituacao(vsituacao);
					ExtratoLicitacao.add(extratoLicitacao);
				}
			}
			

			rs.close();
			conexao.close();
			return ExtratoLicitacao;
			
	}
		
		public ExtratoLicitacao getExtrato(int vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			int vidDataPublicacao = parametros.getVidDataPublicacao();
			
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
			String vsql = "SELECT a.id_arquivo, a.id_conteudo, a.descricao, To_Char(ca.data_inicio_exib, 'dd/mm/yyyy HH24:mi') AS data_abertura, " +
						"To_char(sysdate, 'dd/mm/yyyy HH24:mi') as data_impressao, " +
					   "To_Char(ca.data_fim_exib, 'dd/mm/yyyy') AS data_fechamento, sysdate as hoje, c.observacao, data_inicio_exib, data_fim_exib, " +
					   "Nvl((Select ad.valor from gecoi.campo_adicional ad where ad.id_tipo_campo_adicional = ? and a.id_arquivo = ad.id_arquivo), c.data_criacao) AS data_publicacao, " +
					   "To_Char(c.data_criacao, 'dd/mm/yyyy HH24:mi') AS data_criacao " +
					   "from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo c " +
					   "WHERE a.id_conteudo = ca.id_conteudo AND a.ordem = 0 AND ca.id_conteudo = c.id_conteudo " +
					   "and a.id_conteudo = ? ";

			PreparedStatement pstm = conexao.prepareStatement(vsql);
			
			pstm.setInt(1,vidDataPublicacao);
			pstm.setInt(2,vidConteudo);
			ResultSet rs = pstm.executeQuery();
			ExtratoLicitacao extratoLicitacao = new ExtratoLicitacao();
			if (rs.next()) 
			{
					String[] arrayDescricao = rs.getString("descricao").split("-",5);
					extratoLicitacao.setTipo(arrayDescricao[0]);
					extratoLicitacao.setNumPregao(arrayDescricao[1].trim());
					extratoLicitacao.setDescricao(arrayDescricao[3].trim());
					extratoLicitacao.setNumProcesso(arrayDescricao[2].trim());
					extratoLicitacao.setIdConteudo(rs.getString("id_conteudo"));
					extratoLicitacao.setDataAbertura(rs.getString("data_abertura"));
					extratoLicitacao.setDataCriacao(rs.getString("data_criacao"));
					extratoLicitacao.setDataImpressao(rs.getString("data_impressao"));
					extratoLicitacao.setDataPublicacao(rs.getString("data_publicacao"));
				
			}
			
			rs.close();
			conexao.close();
			return extratoLicitacao;
			
	}
		
}
