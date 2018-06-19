<%@page import="br.jus.trerj.controle.registroPreco.secomp.AlteraRegistro"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vnumProcesso = request.getParameter("numProcesso");
	String vanoProcesso = request.getParameter("anoProcesso");
	String vidArea = request.getParameter("idArea");
	String vdataAbertura = request.getParameter("dataAbertura");
	String vdataFechamento = request.getParameter("dataFechamento");

	AlteraRegistro altera = new AlteraRegistro();
	vdescricao = "Pregão Eletrônico por Registro de Preço " + vnumProcesso + "/" + vanoProcesso + " - " + vdescricao; 
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vidArea, vdataAbertura, vdataFechamento, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
