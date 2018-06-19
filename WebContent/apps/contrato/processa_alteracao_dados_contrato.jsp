<%@page import="br.jus.trerj.controle.contrato.AlteraContrato"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vdataVigenciaInicial = request.getParameter("dataVigenciaInicial");
	String vdataVigenciaFinal = request.getParameter("dataVigenciaFinal");
	String vnumContrato = request.getParameter("numContrato");
	String vanoContrato = request.getParameter("anoContrato");
	String vnumProcesso = request.getParameter("nProcesso");
	
	vdescricao =  vnumContrato + "/" + vanoContrato + "-" + vnumProcesso + "-";// + vdescricao;
	
	AlteraContrato altera = new AlteraContrato();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vdataVigenciaInicial, vdataVigenciaFinal, vdataPublicacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
