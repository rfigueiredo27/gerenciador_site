<%@page import="br.jus.trerj.controle.popup_metas.Altera"%>

<%
	String vdataIni = request.getParameter("dataIni");
	String vdataFim = request.getParameter("dataFim");
	String vidConteudo = request.getParameter("idConteudo");
	String vmetas = request.getParameter("metas");
	
	Altera altera = new Altera();
	altera.alterar(vidConteudo, vdataIni, vdataFim, vmetas, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>