<%@page import="br.jus.trerj.funcoes.ExcluirArquivo"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	ExcluirArquivo exclui = new ExcluirArquivo();
	exclui.excluir(vidArquivo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>

