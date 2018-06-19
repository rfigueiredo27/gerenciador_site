<%@page import="br.jus.trerj.controle.licitacao.AlteraLicitacao"%>

<%
String vacao = (request.getParameter("acao") == null ? "" : request.getParameter("acao"));
int vidConteudo = (request.getParameter("idConteudo") == null ? 0 : Integer.parseInt(request.getParameter("idConteudo")));

AlteraLicitacao altera = new AlteraLicitacao();

if (vacao.equals("Reabrir"))
{
	altera.alterarStatusReabrir(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	out.println("<input type='button' class='form-botao_encerrar' id='botao_e" + vidConteudo + "' onclick='concluir(\"Encerrar\", " + vidConteudo + ");' value='Encerrar' />");
	out.println("<input type='button' class='form-botao_suspender' id='botao_s" + vidConteudo + "' onclick='concluir(\"Suspender\", " + vidConteudo + ");' value='Suspender' />");
}
else
{
	if (vacao.equals("Encerrar"))
	{
		altera.alterarStatusEncerrar(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
		out.println("<input type='button' class='form-botao_reabir' id='botao_r" + vidConteudo + "' onclick='concluir(\"Reabrir\", " + vidConteudo + ");' value='Reabrir' />");
	}
	else
	{
		if (vacao.equals("Suspender"))
		{
			altera.alterarStatusSuspender(vidConteudo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
			out.println("<input type='button' class='form-botao_reabir' id='botao_r" + vidConteudo + "' onclick='concluir(\"Reabrir\", " + vidConteudo + ");' value='Reabrir' />");
		}
	}
}

%>