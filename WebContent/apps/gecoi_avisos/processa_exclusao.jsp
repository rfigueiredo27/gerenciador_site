<%@page import="br.jus.trerj.funcoes.UltimosAvisos"%>
<%@page import="br.jus.trerj.funcoes.ExcluirArquivoConteudo"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	ExcluirArquivoConteudo exclui = new ExcluirArquivoConteudo();
	exclui.excluir(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	UltimosAvisos ultimosAvisos = new UltimosAvisos();
	ultimosAvisos.ultimos(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
%>

