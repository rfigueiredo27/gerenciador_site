<%@page import="br.jus.trerj.controle.licitacao.AlteraLicitacao"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	 
	AlteraLicitacao altera = new AlteraLicitacao();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
