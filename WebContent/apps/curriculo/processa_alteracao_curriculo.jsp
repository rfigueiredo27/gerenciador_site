<%@page import="br.jus.trerj.controle.curriculo.AlteraCurriculo"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	String vdescricao = request.getParameter("descricao");
	String vpublicado = request.getParameter("publicado");
	AlteraCurriculo altera = new AlteraCurriculo();
	altera.alterar(vidConteudo, vdescricao, vpublicado, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
