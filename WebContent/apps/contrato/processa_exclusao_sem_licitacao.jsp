<%@page import="br.jus.trerj.controle.contrato.ExcluirContratoSemLicitacao"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	String vidArquivo = request.getParameter("idArquivo");
	ExcluirContratoSemLicitacao exclui = new ExcluirContratoSemLicitacao();
	exclui.excluirSemLicitacao(vidConteudo, vidArquivo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>

