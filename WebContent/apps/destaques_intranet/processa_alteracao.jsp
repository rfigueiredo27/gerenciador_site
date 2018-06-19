<%@page import="br.jus.trerj.controle.destaque.AlteraDestaque"%>

<%
	String vidConteudo = request.getParameter("idConteudo");
	String vidArquivo = request.getParameter("idArquivo");
	String vdescricao = request.getParameter("descricao");
	String vobservacao = request.getParameter("link");
	String vdataIni2 = request.getParameter("dataIni2");
	String vdataFim2 = request.getParameter("dataFim2");
	int vpublicadoAtual = request.getParameter("publicadoAtual") == null ? 0 : Integer.parseInt(request.getParameter("publicadoAtual"));
	int vpublicadoNovo = request.getParameter("publicadoNovo") == null ? 0 : Integer.parseInt(request.getParameter("publicadoNovo"));
	AlteraDestaque altera = new AlteraDestaque();	
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vobservacao, vdataIni2, vdataFim2, vpublicadoAtual, vpublicadoNovo, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
%>
<script>
alert(<%=vdescricao%>);
alert(<%=vobservacao%>);
</script>
