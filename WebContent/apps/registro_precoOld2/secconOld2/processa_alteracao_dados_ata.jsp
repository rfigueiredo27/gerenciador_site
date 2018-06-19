<%@page import="br.jus.trerj.controle.registroPreco.seccon.AlteraRegistro"%>

<%
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vdataPublicacao = request.getParameter("dataPublicacao");
	String vdataVigenciaIni = request.getParameter("dataVigenciaInicial");
	String vdataVigenciaFim = request.getParameter("dataVigenciaFinal");
	String vidArea = request.getParameter("idArea");
	
	AlteraRegistro altera = new AlteraRegistro();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vidArea, vdataPublicacao, vdataVigenciaIni, vdataVigenciaFim, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
