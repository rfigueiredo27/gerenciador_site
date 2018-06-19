<%@page import="br.jus.trerj.controle.estudosPreliminares.AlteraEstudo"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vidArea = request.getParameter("idArea");
	
	AlteraEstudo altera = new AlteraEstudo();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vidArea, vdataPublicacao, null, null, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
