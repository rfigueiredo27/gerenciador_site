<%@page import="br.jus.trerj.controle.contrato.AlteraContrato"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vtermo = request.getParameter("termo");
	String vnumProcesso = request.getParameter("numProcesso");
	String vnumContrato = request.getParameter("numContrato");
	String vdataIni = request.getParameter("dataIni");
	String vdataFim = request.getParameter("dataFim");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	int vidArea = Integer.parseInt(request.getParameter("idArea"));
	
	String vdescricao = vnumContrato + "-" + vnumProcesso + "-" + vtermo + "� Termo Aditivo";

	AlteraContrato altera = new AlteraContrato();
	
	altera.alterarSemLicitacao(vidArea, vidConteudo, vidArquivo, vdescricao, "", vdataIni, vdataFim, vdataPublicacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
