<%@page import="br.jus.trerj.funcoes.IncluirGecoiArquivo"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasSemImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasComImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasInternet"%>
<%@page import="br.jus.trerj.controle.gecoiArquivos.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vDescricao_arquivo = request.getParameter("descricao_arquivo");
	String vDescricao_conteudo = request.getParameter("descricao_conteudo");
	String vObservacao = request.getParameter("observacao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vidArea = request.getParameter("idArea");
	
	vObservacao.trim();
	if(vObservacao.equals(""))
	{
		vObservacao = " ";
	}
	
		
	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vDescricao_arquivo, vidArea, vdataPublicacao, null, null, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vObservacao);
		
		
	IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
	incluir.incluirDescCont(vDescricao_conteudo, vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	
	
	
	
	
%>
