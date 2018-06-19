<%@page import="br.jus.trerj.funcoes.ExcluirArquivoConteudo"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	ExcluirArquivoConteudo exclui = new ExcluirArquivoConteudo();
	exclui.excluir(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>

