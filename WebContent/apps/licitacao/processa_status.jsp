<%@page import="br.jus.trerj.controle.licitacao.AlteraLicitacao"%>

<%
String vacao = (request.getParameter("acao") == null ? "" : request.getParameter("acao"));
int vidConteudo = (request.getParameter("idConteudo") == null ? 0 : Integer.parseInt(request.getParameter("idConteudo")));

AlteraLicitacao altera = new AlteraLicitacao();

if (vacao.equals("Reabrir"))
{
	altera.alterarStatusReabrir(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
}
else
{
	if (vacao.equals("Encerrar"))
	{
		altera.alterarStatusEncerrar(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	}
	else
	{
		if (vacao.equals("Suspender"))
		{
			altera.alterarStatusSuspender(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
			
		}
		else
		{
			if (vacao.equals("Revogar"))
			{
				altera.alterarStatusRevogar(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
				
			}
		}
	}
}

%>