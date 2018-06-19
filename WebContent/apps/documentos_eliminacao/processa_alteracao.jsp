<%@page import="br.jus.trerj.controle.documentoEliminacao.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vDescricao = request.getParameter("descricao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vidArea = request.getParameter("idArea");
	String vobservacao = request.getParameter("unidade")+","+request.getParameter("edital");

	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vDescricao, vidArea, vdataPublicacao, null, null, vobservacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	
	
%>
