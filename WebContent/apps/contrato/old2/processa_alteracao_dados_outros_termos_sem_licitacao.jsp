<%@page import="br.jus.trerj.controle.contrato.AlteraContrato"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vordem = request.getParameter("ordem");
	String vnumProcesso = request.getParameter("numProcesso");
	String vnumContrato = request.getParameter("numContrato");
	String vdescricao = request.getParameter("descricao");
	
	vdescricao = vnumProcesso + "-" + vnumContrato + "-" + vdescricao;
	
	AlteraContrato altera = new AlteraContrato();
	
	altera.alterar(vidConteudo, vidArquivo, vdescricao, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vordem);
%>
