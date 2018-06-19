<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

  
<script>
function ordem(vacao, vidArquivo, vordem, vidConteudo)
{
	$.post("/gecoi.3.0/apps/destaques_intranet/processa_altera_ordem.jsp", {acao: vacao, idArquivo : vidArquivo, ordem : vordem, idConteudo: vidConteudo}, 
			function(){document.fanexo.submit();});
}

function atualizaTela()
{
	top.listar();
	parent.tb_remove();
}


function excluirAnexo(vidArquivo)
{
	if (confirm("Deseja realmente excluir o anexo ?") == true)
		$.post("/gecoi.3.0/apps/destaques_intranet/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, function(){top.listar();document.fanexo.submit()});
}
</script>
<%
//String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
//String vdescricao = request.getParameter("descricao");

%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.destaque.ListaDestaques" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" /> 
<c:set var="items" value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="fanexo" action="/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=${idConteudo}" method="post" enctype="multipart/form-data"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<th>ORDEM</th>
				<th>ID. ARQUIVO</th>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" varStatus="conta" >
      			<tr>
        			<td>
        				${anexo.ordem }
        			</td>
        			<td>
        				${anexo.idArquivo }
        			</td>
        			<td>
        				${anexo.descricao }
        			</td>
        			<td>
        				<c:if test="${conta.index > 0 }">
        					<a href="#" onclick="ordem('sobe', ${anexo.idArquivo }, ${anexo.ordem }, ${idConteudo});"><img src="/gecoi.3.0/img/alto.gif" /></a>
        				</c:if>
        				<c:if test="${conta.index + 1 < anexo.total }">
        					<a href="#" onclick="ordem('desce', ${anexo.idArquivo }, ${anexo.ordem }, ${idConteudo});"><img src="/gecoi.3.0/img/baixo.gif" /></a>
        				</c:if>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/destaques_intranet/alterar_descricao_anexo.jsp?id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=<%=vidConteudo%>','divbusca');"><img width="20" height="20" src="/gecoi.3.0/img/texto.jpg" /></a>
           				<a href="#" onclick="excluirAnexo(${anexo.idArquivo });"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">
        				<a href="/gecoi.3.0/apps/destaques_intranet/incluir_anexo.jsp?idConteudo=${idConteudo}">(+) Incluir Anexo</a>
        			</td>
      			</tr>
		</table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
