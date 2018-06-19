<%@page import="br.jus.trerj.funcoes.UltimasNoticiasSemImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasComImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasInternet"%>
<%@page import="br.jus.trerj.controle.gecoiArquivos.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");

	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, session
			.getAttribute("login").toString(),
			session.getAttribute("senha").toString());

	UltimasNoticiasComImagem ultimasNoticiasComImagem = new UltimasNoticiasComImagem();
	vmsg = ultimasNoticiasComImagem.ultimasTV(
			session.getAttribute("login").toString(), session
					.getAttribute("senha").toString());

	UltimasNoticiasSemImagem ultimasNoticiasSemImagem = new UltimasNoticiasSemImagem();
	vmsg = ultimasNoticiasSemImagem.ultimas(
			session.getAttribute("login").toString(), session
					.getAttribute("senha").toString());

	UltimasNoticiasInternet ultimasNoticiasInternet = new UltimasNoticiasInternet();
	vmsg = ultimasNoticiasInternet.ultimasTV(
			session.getAttribute("login").toString(), session
					.getAttribute("senha").toString());
%>
