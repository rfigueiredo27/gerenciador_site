<%@page import="br.jus.trerj.controle.destaque.ExcluiDestaque"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	int vidPublicado = Integer.parseInt(request.getParameter("publicado"));
	ExcluiDestaque exclui = new ExcluiDestaque();
	exclui.excluir(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vidPublicado);
%>

