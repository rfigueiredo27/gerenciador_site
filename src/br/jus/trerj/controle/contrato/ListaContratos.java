package br.jus.trerj.controle.contrato;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Aditivos;
import br.jus.trerj.modelo.Contrato;
import br.jus.trerj.modelo.Parametros;



public class ListaContratos {

	public List<Integer> getAnos(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaContrato();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
	    String vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano FROM gecoi.conteudo c, gecoi.conteudo_area ca " +
	             "WHERE c.id_conteudo=ca.id_conteudo AND ca.id_area = ? and To_Char(ca.data_inicio_exib,'yyyy') >= '2013' " + 
	 			"order by 1 desc" ;
		PreparedStatement pstm = conexao.prepareStatement(vsql);
	    pstm.setInt(1,vidArea);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			ano.add(rs.getInt("ano"));
		}
		rs.close();
		conexao.close();
		return ano;
	}
	

	public int getOrdem(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT Max(Ordem) + 1 as maior FROM gecoi.arquivo WHERE id_conteudo = ? ORDER BY ordem ";
		
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));

		ResultSet rs = pstm.executeQuery();
		
		int maior = 0;
		while(rs.next()) 
		{
			maior = rs.getInt("maior");
		}
				
		rs.close();
		conexao.close();		
		return maior;
		
	}

	public int getTermo(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT count(*) + 1 as Termo FROM gecoi.arquivo WHERE id_conteudo = ? and descricao like '%Termo Aditivo%' ORDER BY ordem ";
		
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));
		
		ResultSet rs = pstm.executeQuery();
		
		int termo = 0;
		while(rs.next()) 
		{
			termo = rs.getInt("Termo");
		}
		rs.close();
		conexao.close();		
		return termo;
		
	}

	public int getPublicado(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		
		String vsql = "SELECT Max(Publicado) + 1 as maior FROM gecoi.arquivo WHERE id_conteudo = ? ORDER BY ordem ";
		
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,Integer.parseInt(vidConteudo));

		ResultSet rs = pstm.executeQuery();
		
		int maior = 0;
		while(rs.next()) 
		{
			maior = rs.getInt("maior");
		}
				
		rs.close();
		conexao.close();		
		return maior;
		
	}

	// mostra todos os aditivos e outros termos de um determinado contrato
	public List<Aditivos> getListaAditivos(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		String nProcessoAux = "";
		String nContratoAux = "";
		String descricaoAux = "";
		int nTermo = 1;
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Aditivos> aditivos = new ArrayList<Aditivos>();
		
		String vsql = "	SELECT a.ordem, a.id_conteudo, a.id_arquivo, a.descricao, c.observacao " +
			      ",(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
			      "	  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
			      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaInicial, " +
			      "		(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
			      "		  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
			      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaFinal " + 
					  "from gecoi.arquivo a, gecoi.conteudo c " + 
					  "WHERE a.ordem > 0 AND a.id_conteudo =  ? AND a.id_conteudo = c.id_conteudo " +
					  "order by ordem ";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vidValidadeInicial);
		pstm.setInt(2,vidValidadeFinal);
	    pstm.setInt(3,Integer.parseInt(vidConteudo));

		ResultSet rs = pstm.executeQuery();
		while(rs.next()) 
		{
			Aditivos aditivo = new Aditivos();
			aditivo.setIdArquivo(rs.getInt("id_arquivo"));
			aditivo.setIdConteudo(rs.getInt("id_conteudo"));
			nContratoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			nProcessoAux = rs.getString("descricao").substring(nContratoAux.length()+1,rs.getString("descricao").indexOf("-",nContratoAux.length()+1));
			descricaoAux = rs.getString("descricao").substring(nContratoAux.length()+nProcessoAux.length()+2);
			aditivo.setDescricao(descricaoAux.trim());
			aditivo.setOrdem(rs.getInt("ordem"));
			if (rs.getString("VigenciaInicial") == null)
				aditivo.setDataVigenciaInicial("-");
			else
				aditivo.setDataVigenciaInicial(rs.getString("VigenciaInicial"));
			if (rs.getString("VigenciaFinal") == null)
				aditivo.setDataVigenciaFinal("-");
			else
				aditivo.setDataVigenciaFinal(rs.getString("VigenciaFinal"));
			if (descricaoAux.indexOf("Termo Aditivo") >= 0)
			{
				aditivo.setTipo("aditivo");
				aditivo.setnTermo(nTermo++);
			}
			else
			{
				if (descricaoAux.indexOf("Rescisão do Contrato") >= 0)
				{
					aditivo.setTipo("rescisao");
				}
				else
				{
					aditivo.setTipo("outros");
				}
			}
			aditivos.add(aditivo);
		}
		rs.close();
		conexao.close();
		return aditivos;
		
	}

	// mostra apenas os outros termos de um determinado contrato
	public List<Aditivos> getListaOutrosTermos(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		String nProcessoAux = "";
		String nContratoAux = "";
		String descricaoAux = "";
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Aditivos> aditivos = new ArrayList<Aditivos>();
		
		String vsql = "	SELECT a.ordem, a.id_conteudo, a.id_arquivo, a.descricao, c.observacao " +
					  "from gecoi.arquivo a, gecoi.conteudo c " + 
					  "WHERE a.ordem > 0 AND a.id_conteudo =  ? AND a.id_conteudo = c.id_conteudo " +
					  "order by ordem ";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
	    pstm.setInt(1,Integer.parseInt(vidConteudo));

		ResultSet rs = pstm.executeQuery();
		while(rs.next()) 
		{
			nContratoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			nProcessoAux = rs.getString("descricao").substring(nContratoAux.length()+1,rs.getString("descricao").indexOf("-",nContratoAux.length()+1));
			descricaoAux = rs.getString("descricao").substring(nContratoAux.length()+nProcessoAux.length()+2);
			if (descricaoAux.indexOf("Termo Aditivo n") == 0)
			{
				Aditivos aditivo = new Aditivos();
				aditivo.setIdArquivo(rs.getInt("id_arquivo"));
				aditivo.setIdConteudo(rs.getInt("id_conteudo"));
				aditivo.setDescricao(descricaoAux.trim());
				aditivo.setOrdem(rs.getInt("ordem"));
				aditivo.setTipo("outros");
				aditivos.add(aditivo);
			}
		}
		rs.close();
		conexao.close();
		return aditivos;
		
	}
	
	public String pegaDescricaoLicitacao(int vidArquivo, Connection conexao) throws SQLException
	{
		String vsql = "SELECT a.descricao " + 
						"FROM gecoi.arquivo a, gecoi.referencia r " +
						"WHERE r.id_arquivo_principal = a.id_arquivo AND r.id_arquivo_Referencia = ? ";
		String vdescricao = "";
		try
		{
			PreparedStatement pstm = conexao.prepareStatement(vsql);
			pstm.setInt(1,vidArquivo);

			ResultSet rs = pstm.executeQuery();
			if (rs.next())
			{
				String[] adescricao = rs.getString("descricao").split("-");
				if (adescricao.length == 4)
					vdescricao = adescricao[3];
			}
		}
		catch (SQLException e)
		{
			
		}
		return vdescricao;
		
	}
	
	public List<Contrato> getListaReferencia(String vidArquivo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaContrato();
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Contrato> Contrato = new ArrayList<Contrato>();
		
		String nProcessoAux = "";
		String nContratoAux = "";
		//String descricaoAux = "";
		
		String vsql = "SELECT Decode(ordem,0,0,1) AS ordem_principal, Decode(ordem,0,'Contratos','Aditivos/Rescisões') AS tipo, ordem, " +
				  "a.id_arquivo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, a.id_conteudo, a.descricao, nvl(co.observacao,' ') as observacao " +
		 	      ", decode(ordem, 0, to_char(ca.data_inicio_exib, 'yyyy'), to_char(a.data_inclusao, 'yyyy')) as ano, " +
			      "decode(ordem, 0, ca.data_inicio_exib, a.data_inclusao) as data, ca.id_area " +
			      ",(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
			      "	  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
			      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaInicial, " +
			      "		(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
			      "		  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
			      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaFinal " + 
	    				"from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co, gecoi.referencia r " +
	    				"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = co.id_conteudo " +
	    				"AND a.id_arquivo = r.id_arquivo_referencia AND r.id_arquivo_principal = ? and ca.id_area = ? and a.ordem = 0 " +
	    				"order by a.id_conteudo, ordem ";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vidValidadeInicial);
		pstm.setInt(2,vidValidadeFinal);
	    pstm.setInt(3,Integer.parseInt(vidArquivo));
	    pstm.setInt(4,vidArea);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			Contrato contrato = new Contrato();
			contrato.setIdArquivo(rs.getInt("id_arquivo"));
			contrato.setIdConteudo(rs.getInt("id_conteudo"));
			/*nProcessoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			contrato.setnProcesso(nProcessoAux.trim());
			nContratoAux = rs.getString("descricao").substring(nProcessoAux.length()+1,rs.getString("descricao").indexOf("-",nProcessoAux.length()+1));			
			contrato.setnContrato(nContratoAux.trim());*/
			
			nContratoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			contrato.setnContrato(nContratoAux.trim());
			nProcessoAux = rs.getString("descricao").substring(nContratoAux.length()+1,rs.getString("descricao").indexOf("-",nContratoAux.length()+1));
			contrato.setnProcesso(nProcessoAux.trim());
			
			//descricaoAux = rs.getString("descricao").substring(nProcessoAux.length()+nContratoAux.length()+2);
			//contrato.setDescricaoContrato(descricaoAux.trim());
			contrato.setDescricaoContrato(pegaDescricaoLicitacao(rs.getInt("id_arquivo"), conexao));
			contrato.setAno(rs.getInt("ano"));
			contrato.setDataPublicacao(rs.getString("data_inicio_exib"));
			contrato.setDataVigenciaInicial(rs.getString("VigenciaInicial"));
			contrato.setDataVigenciaFinal(rs.getString("VigenciaFinal"));
			contrato.setOrdem(rs.getInt("ordem"));
			contrato.setOrdem_principal(rs.getInt("ordem_principal"));
			contrato.setTipo(rs.getString("tipo"));
			contrato.setIdArea(rs.getInt("id_area"));
			Contrato.add(contrato);
		}
		rs.close();
		conexao.close();
		return Contrato;
		
	}
	
	public List<Integer> getAnosSemLicitacao(String vusuario, String vsenha) throws ClassNotFoundException, SQLException 
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea2 = parametros.getVidAreaContratoAdesaoRP();
		int vidArea3 = parametros.getVidAreaContratoContratacaoDireta();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Integer> ano = new ArrayList<Integer>();
	    String vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano FROM gecoi.conteudo c, gecoi.conteudo_area ca " +
	             "WHERE c.id_conteudo=ca.id_conteudo AND (ca.id_area = ? or ca.id_area = ?) " + 
	 			"order by 1 desc" ;
		PreparedStatement pstm = conexao.prepareStatement(vsql);
	    pstm.setInt(1,vidArea2);
	    pstm.setInt(2,vidArea3);

		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			ano.add(rs.getInt("ano"));
		}
		rs.close();
		conexao.close();
		return ano;
	}
	
	public List<Contrato> getListaContratosSemLicitacao(String vano, String vchave, String vtipo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea2 = parametros.getVidAreaContratoAdesaoRP();
		int vidArea3 = parametros.getVidAreaContratoContratacaoDireta();
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		String nProcessoAux = "";
		String nContratoAux = "";
		String descricaoAux = "";
		int campo = 0;
		int contaParam = 3;
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Contrato> contratos = new ArrayList<Contrato>();
		
		String vsql = "SELECT a.id_arquivo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, a.id_conteudo, a.descricao, observacao " +
			 	      ", decode(ordem, 0, to_char(ca.data_inicio_exib, 'yyyy'), to_char(a.data_inclusao, 'yyyy')) as ano, " +
				      "decode(ordem, 0, ca.data_inicio_exib, a.data_inclusao) as data, ar.descricao AS tipo, ar.id_area " +
				      ",(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
				      "	  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
				      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaInicial, " +
				      "		(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t " +
				      "		  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional " +
				      "		  AND t.id_tipo_campo_adicional = ?) AS VigenciaFinal " + 
				  	  "from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co, gecoi.area ar " +
			       	  "WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = co.id_conteudo " + 
					  "and to_number(to_char(ca.data_inicio_exib, 'yyyy')) >= 2010 AND a.ordem = 0 AND ca.id_area = ar.id_area ";
					
		if (vtipo.equals("todos"))
			vsql = vsql + "AND (ca.id_area in (?, ?)) ";
		else
			vsql = vsql + "AND ca.id_area = ? ";
		if (!vano.equals("0"))
			vsql = vsql + "AND ((To_Char(ca.data_inicio_exib,'yyyy') = ? AND a.ordem = 0) OR (To_Char(a.data_inclusao,'yyyy') = ? AND a.ordem > 0)) ";
					  		   		
		if (vchave.trim().compareToIgnoreCase("")!= 0)
		{ 
			vsql= vsql + "and (";
			//Separa o texto a cada ;
			String[] fil = vchave.split(";");  
			campo = 0;
			for (int i=0;i<fil.length;i++)
			{
				campo = campo + 1;
				if (campo==1)
					vsql= vsql + "(upper(a.descricao) like upper('%" + fil[i] + "%') OR contains(arquivo,'" + fil[i] + "'," + campo + ") > 0) ";
				else
					vsql= vsql + "or (upper(a.descricao) like upper('%" + fil[i] + "%') OR contains(arquivo,'" + fil[i] + "'," + campo + ") > 0) ";	   
			}
			vsql= vsql + ") ";	 
		} 
						
		vsql = vsql +  "order by ano DESC, co.descricao desc, data desc ";

		PreparedStatement pstm = conexao.prepareStatement(vsql);	    
		pstm.setInt(1,vidValidadeInicial);
		pstm.setInt(2,vidValidadeFinal);
		if (vtipo.equals("todos"))
		{
			pstm.setInt(contaParam++,vidArea2);
			pstm.setInt(contaParam++,vidArea3);
		}
		else
		{
			if (vtipo.equals("adesao"))
			{
				pstm.setInt(contaParam++,vidArea2);
			}
			if (vtipo.equals("direta"))
			{
				pstm.setInt(contaParam++,vidArea3);
			}
		}
	    if (!vano.equals("0"))
	    {
	    	pstm.setInt(contaParam++,Integer.parseInt(vano));
	    	pstm.setInt(contaParam++,Integer.parseInt(vano));
	    }
		ResultSet rs = pstm.executeQuery();

		while(rs.next()) 
		{
			Contrato contrato = new Contrato();
			contrato.setIdArquivo(rs.getInt("id_arquivo"));
			contrato.setIdConteudo(rs.getInt("id_conteudo"));
			/*nProcessoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			contrato.setnProcesso(nProcessoAux.trim());
			nContratoAux = rs.getString("descricao").substring(nProcessoAux.length()+1,rs.getString("descricao").indexOf("-",nProcessoAux.length()+1));			
			contrato.setnContrato(nContratoAux.trim());*/

			nContratoAux = rs.getString("descricao").substring(0,rs.getString("descricao").indexOf("-"));
			contrato.setnContrato(nContratoAux.trim());
			nProcessoAux = rs.getString("descricao").substring(nContratoAux.length()+1,rs.getString("descricao").indexOf("-",nContratoAux.length()+1));
			contrato.setnProcesso(nProcessoAux.trim());

			descricaoAux = rs.getString("descricao").substring(nProcessoAux.length()+nContratoAux.length()+2);
			contrato.setDescricaoContrato(descricaoAux.trim());
			contrato.setAno(rs.getInt("ano"));
			contrato.setDataPublicacao(rs.getString("data_inicio_exib"));
			contrato.setDataVigenciaInicial(rs.getString("VigenciaInicial"));
			contrato.setDataVigenciaFinal(rs.getString("VigenciaFinal"));
			contrato.setObservacao(rs.getString("observacao"));
			contrato.setTipo(rs.getString("tipo"));
			contrato.setIdArea(rs.getInt("id_area"));
			contratos.add(contrato);
		}
		rs.close();
		conexao.close();
		return contratos;
		
	}

	public List<Contrato> getListaContrato(String vtexto, String vano, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidArea = parametros.getVidAreaContrato();
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		List<Contrato> Registro = new ArrayList<Contrato>();
		
	    String  vsql = "SELECT a.id_conteudo, a.id_arquivo, a.descricao, a.ordem, ca.data_inicio_exib " +
	    				"FROM gecoi.arquivo a, gecoi.conteudo_area ca WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area IN (?) " + 
	    				"and to_char(ca.data_inicio_exib, 'yyyy') = ? ";
	    //and a.ordem = 0 
	    if (!vtexto.equals(""))
	    	vsql = vsql + "and upper(a.descricao) like upper(?) ";
	    vsql = vsql + "ORDER BY a.descricao, a.id_conteudo, a.ordem ";
			   
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setInt(1,vidArea);
		pstm.setString(2,vano);
		if (!vtexto.equals(""))
			pstm.setString(3, "%" + vtexto + "%");

		ResultSet rs = pstm.executeQuery();
		String vedital = "";
		int vidReferencia = 0;
		while(rs.next()) 
		{
			Contrato contrato = new Contrato();
			contrato.setIdArquivo(rs.getInt("id_arquivo"));
			contrato.setIdConteudo(rs.getInt("id_conteudo"));
			contrato.setDescricaoContrato(rs.getString("descricao"));

			if (rs.getString("descricao").indexOf("-") > 0)
			{
				String[] aDescricao = rs.getString("descricao").split("-");
				contrato.setnContrato(aDescricao[0].trim());
				//for (i = 1; i < aDescricao.length; i++)
					//contrato.setDescricao(aDescricao[i].trim());
			}
			
			//vedital = pegaEdital(rs.getInt("id_arquivo"), conexao);
		    vsql = "SELECT a.id_arquivo, a.descricao FROM gecoi.referencia r, gecoi.arquivo a " +
    				"WHERE r.id_arquivo_referencia = ? AND r.id_arquivo_principal = a.id_arquivo";
		   
		    pstm = conexao.prepareStatement(vsql);
		    pstm.setInt(1,rs.getInt("id_arquivo"));

		    vedital = "";
		    vidReferencia = 0;
		    ResultSet rs2 = pstm.executeQuery();
		    if(rs2.next()) 
		    {			
		    	vedital = rs2.getString("descricao");
		    	vidReferencia = rs2.getInt("id_arquivo");
		    }
			
			
		    contrato.setnPregao("Sem Referência");
		    contrato.setnProcesso("Sem Referência");
		    //contrato.setDescricao("Sem Referência");
		    contrato.setIdReferencia(0);
			if (!vedital.equals(""))
			{
				String[] aEdital = vedital.split("-");
				contrato.setnPregao(aEdital[1]);
				contrato.setnProcesso(aEdital[2]);
				//registro.setDescricao(aEdital[3]); // do edital...
				contrato.setIdReferencia(vidReferencia);
			}
			//contrato.setDataPublicacao(rs.getString("data_inicio_exib"));
			//registro.setDataVigenciaInicial(rs.getString("VigenciaInicial"));
			//registro.setDataVigenciaFinal(rs.getString("VigenciaFinal"));
			//registro.setIdArea(rs.getInt("id_area"));
			Registro.add(contrato);
		}
		rs.close();
		conexao.close();
		return Registro;
		
	}

	
}
