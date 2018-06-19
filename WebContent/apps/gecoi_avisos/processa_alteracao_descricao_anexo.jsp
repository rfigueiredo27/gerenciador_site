<%@page import="br.jus.trerj.controle.gecoiAvisos.AlteraGecoiAvisos"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	 
	AlteraGecoiAvisos altera = new AlteraGecoiAvisos();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
