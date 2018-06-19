<%@page import="br.jus.trerj.controle.contrato.AlteraContrato"%>

<%
	int vidArea = Integer.parseInt(request.getParameter("idArea"));
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vdataVigenciaInicial = request.getParameter("dataVigenciaInicial");
	String vdataVigenciaFinal = request.getParameter("dataVigenciaFinal");
	String vnumContrato = request.getParameter("numContrato");
	String vanoContrato = request.getParameter("anoContrato");
	String vnumProcesso = request.getParameter("numProcesso");
	String vanoProcesso = request.getParameter("anoProcesso");
	String vobservacao = request.getParameter("observacao");
	
	vdescricao = vnumProcesso + "/" + vanoProcesso + "-" + vnumContrato + "/" + vanoContrato + "-" + vdescricao;
	AlteraContrato altera = new AlteraContrato();
	altera.alterarSemLicitacao(vidArea, vidConteudo, vidArquivo, vdescricao, vobservacao, vdataVigenciaInicial, vdataVigenciaFinal, vdataPublicacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
