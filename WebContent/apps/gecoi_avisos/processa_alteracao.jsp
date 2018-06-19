<%@page import="br.jus.trerj.funcoes.UltimosAvisos"%>
<%@page import="br.jus.trerj.controle.gecoiAvisos.AlteraGecoiAvisos"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vDescricao = request.getParameter("descricao");
	

	AlteraGecoiAvisos altera = new AlteraGecoiAvisos();
	altera.alterar(vidConteudo, vidArquivo, vDescricao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	UltimosAvisos ultimosAvisos = new UltimosAvisos();
	ultimosAvisos.ultimos(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
%>
