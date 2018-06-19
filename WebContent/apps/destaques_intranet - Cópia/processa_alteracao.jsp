<%@page import="br.jus.trerj.controle.destaque.AlteraDestaque"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	String vidArquivo = request.getParameter("idArquivo");
	String vdescricao = request.getParameter("descricao");
	String vobservacao = request.getParameter("link") + "@@" + request.getParameter("alvo");
	String vdataIni = request.getParameter("dataIni");
	String vdataFim = request.getParameter("dataFim");
	int vpublicadoAtual = request.getParameter("publicadoAtual") == null ? 0 : Integer.parseInt(request.getParameter("publicadoAtual"));
	int vpublicadoNovo = request.getParameter("publicadoNovo") == null ? 0 : Integer.parseInt(request.getParameter("publicadoNovo"));
	AlteraDestaque altera = new AlteraDestaque();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vobservacao, vdataIni, vdataFim, vpublicadoAtual, vpublicadoNovo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
