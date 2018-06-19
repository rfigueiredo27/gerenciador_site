<%@page import="br.jus.trerj.controle.rodizio.AlteraRodizio"%>

<%
	String vtitulo = request.getParameter("titulo");
	String vtexto = request.getParameter("texto");
	String vtamanhoTitulo = request.getParameter("tamanhoTitulo");
	String vtamanhoTexto = request.getParameter("tamanhoTexto");
	String vtopoTitulo = request.getParameter("topoTitulo");
	String vtopoTexto = request.getParameter("topoTexto");
	String valturaTitulo = request.getParameter("alturaTitulo");
	String valturaTexto = request.getParameter("alturaTexto");
	String vlocal = request.getParameter("local");
	
	AlteraRodizio altera = new AlteraRodizio();
	
	altera.alterar(vtitulo, vtexto, vtamanhoTitulo, vtamanhoTexto, vtopoTitulo, vtopoTexto, valturaTitulo, valturaTexto, vlocal, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
