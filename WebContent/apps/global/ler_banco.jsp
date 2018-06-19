<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%
	ListaAmbiente listaAmbiente = new ListaAmbiente();

	String vambiente2 = "Banco de Produção";
	if (session.getAttribute("login") != null)
		vambiente2 = "Banco de " + listaAmbiente.mostraAmbiente(session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>        
