<%@page import="br.jus.trerj.funcoes.CadastroReferencia"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vorigem = request.getParameter("origem");
	int vidReferencia = 0;
	try
	{
		vidReferencia = Integer.parseInt(request.getParameter("idReferencia")); 
	}
	catch (Exception e)
	{
		vidReferencia = 0;
	}
	int vidReferenciaAnterior = 0;
	try
	{
		vidReferenciaAnterior = Integer.parseInt(request.getParameter("idReferenciaAnterior")); 
	}
	catch (Exception e)
	{
		vidReferenciaAnterior = 0;
	}
	CadastroReferencia altera = new CadastroReferencia();
	altera.alterarReferencia(vidConteudo, vidArquivo, vidReferencia, vidReferenciaAnterior, vorigem, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
