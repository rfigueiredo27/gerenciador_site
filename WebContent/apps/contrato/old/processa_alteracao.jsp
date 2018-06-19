<%@page import="br.jus.trerj.controle.contrato.AlteraContrato"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescContrato = request.getParameter("descContrato");
	String vnumProcesso = request.getParameter("numProcesso");
	String vanoProcesso = request.getParameter("anoProcesso");
	String vnumContrato = request.getParameter("numContrato");
	String vanoContrato = request.getParameter("anoContrato");
	String vdataIni = request.getParameter("dataIni");
	String vdataFim = request.getParameter("dataFim");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	
	String vdescricao = vnumProcesso + "/" + vanoProcesso + "-" + vnumContrato + "/" + vanoContrato + "-" + vdescContrato;
	String vobservacao = vdataIni + " a " + vdataFim;

	AlteraContrato altera = new AlteraContrato();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vobservacao, vdataPublicacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
