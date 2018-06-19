<%@page import="br.jus.trerj.controle.destaque.AlteraDestaque"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vordem = request.getParameter("ordem");
	String vacao = request.getParameter("acao");
	AlteraDestaque altera = new AlteraDestaque();
	altera.alterar(vidConteudo, vidArquivo, vordem, vacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>

