<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>
   
<script>

function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fanexo.idConteudo.value + "&nProcesso=" + document.fanexo.nProcesso.value + "&nPregao=" + document.fanexo.nPregao.value, "divbusca");
}


function excluirAnexo(vidArquivo, vidConteudo)
{
	if (confirm("Deseja realmente excluir o anexo ?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + vidConteudo + "&nProcesso=" + document.fanexo.nProcesso.value + "&nPregao=" + document.fanexo.nPregao.value,"divbusca");});

}
</script>
<%
String vidConteudo = request.getParameter("id");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
%>
<h1>Lista de Anexos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" /> 
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" /> 
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="items" value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fanexo" action="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=${idConteudo}&nPregao=${numPregao }&nProcesso=${numProcesso}" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" /> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td>
        			Nº do Pregão:
        			<input type="text" name="nPregao" id="nPregao" value="<%=vnumPregao %>" readonly="readonly" />
        		</td>
      		</tr>
      		<tr>
        		<td>
        			Nº do Processo:
        			<input type="text" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        		</td>
      		</tr>
			<tr>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.descricao }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&keepThis=true&TB_iframe=true&height=350&width=800" class="thickbox" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" target="_blank" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_arquivo.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=<%=vnumProcesso%>&nPregao=<%=vnumPregao%>&descricao=${anexo.descricao }&tipo=${licitacao.tipo }&origem=anexo&titulo=anexo','divbusca');" title="Substitui&ccedil;&atilde;o do Aditivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_descricao_anexo.jsp?id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=<%=vidConteudo%>&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>&tipo=${licitacao.tipo }','divbusca');" title="Alterar dados do anexo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				<a href="#" onclick="excluirAnexo(${anexo.idArquivo },${anexo.idConteudo });"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/incluir_anexo.jsp?idConteudo=${idConteudo}&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>','divbusca');" >(+) Incluir Anexo</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />