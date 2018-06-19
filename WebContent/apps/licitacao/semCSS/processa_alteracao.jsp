<%@page import="br.jus.trerj.controle.licitacao.AlteraLicitacao"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescObjeto = request.getParameter("descricao");
	String vnumProcesso = request.getParameter("numProcesso");
	String vanoProcesso = request.getParameter("anoProcesso");
	String vnumPregao = request.getParameter("numPregao");
	String vanoPregao = request.getParameter("anoPregao");
	String vdataAbertura = request.getParameter("dataAbertura");
	String vdataFechamento = request.getParameter("dataFechamento");
	String vtipo = request.getParameter("tipo");
	
	String vdescricao = vtipo + "-" + vnumPregao + "/" + vanoPregao + "-" + vnumProcesso + "/" + vanoProcesso + "-" + vdescObjeto;

	AlteraLicitacao altera = new AlteraLicitacao();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vdataAbertura, vdataFechamento, vtipo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
