<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="java.util.ArrayList"%>
<html>
<head>


<script>
function ativar(atual, ativo, vidConteudo)
{
	var vativo = "0";
	if (ativo)
		vativo = "1";
	$.post("/gecoi.3.0/apps/destaques_intranet/processa_alteracao.jsp", {idConteudo : vidConteudo, publicadoAtual: atual, publicadoNovo: vativo}, function(){top.listar();});

}

function excluir(vidConteudo, vdescricao, vpublicado)
{
	if (confirm("Deseja realmente excluir o banner de destaque de " + vdescricao) == true)
		$.post("/gecoi.3.0/apps/destaques_intranet/processa_exclusao.jsp", {idConteudo : vidConteudo, publicado: vpublicado}, function(){top.listar();});
}
</script>
</head>
<body>
<%
String vtexto = request.getParameter("vtexto");
String vativo = request.getParameter("vativo");
%>
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ativo" value="<%=vativo %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.destaque.ListaDestaques" /> 
<c:set var="items" value="${lista.getListaDestaques(texto, ativo, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
	<form name="flista">
		<table>
			<tr>
				<th>ORDEM</th>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>LINK</th>
				<th>IN&Iacute;CIO</th>
				<th>FIM</th>
				<th>DADOS</th>
				<th>BANNER</th>
				<th>EXCLUIR</th>
				<th>ATIVO</th>
			</tr>
		<c:forEach var="destaque" items="${items}" >
			<tr>
			    <td>${destaque.publicado }</td>
				<td>${destaque.descricao }</td>
				<c:if test="${destaque.temAnexo == 0 }">
				   <td>${destaque.observacao }</td>
				</c:if>
				<c:if test="${destaque.temAnexo > 0 }">
				   <td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=${destaque.idConteudo }','divbusca');" title="Manutenção do anexo"><img id="foto${destaque.idConteudo }" name="anexo${destaque.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onClick="" width="30" height="30" /></a></td>
				</c:if>
				<td>${destaque.dataIni }</td>
				<td>${destaque.dataFim }</td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/destaques_intranet/alterar_dados.jsp?id=${destaque.idArquivo }&idConteudo=${destaque.idConteudo }&descricao=${destaque.descricao }&publicado=${destaque.publicado }&link=${destaque.observacao }&dataIni=${destaque.dataIni }&dataFim=${destaque.dataFim }','divbusca');"  title="Manutenção do destaque"><img id="foto${destaque.idConteudo }" name="foto${destaque.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onClick="" width="30" height="30" /></a></td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/destaques_intranet/alterar_banner.jsp?id=${destaque.idArquivo }&idConteudo=${destaque.idConteudo }&descricao=${destaque.descricao }&nome=${destaque.nomeArquivo }','divbusca');" title="Manutenção do banner"><img id="foto${destaque.idConteudo }" name="foto${destaque.idConteudo }" src="/gecoi.3.0/img/clips.png" onClick="" width="30" height="30" /></a></td>
				<td><a href="#" title="Exclusão do banner"><img id="excluir${destaque.idArquivo }" name="excluir${destaque.idArquivo }" src="/gecoi.3.0/img/excluir_cinza.png" width="30" height="30" onClick="excluir('${destaque.idConteudo }', '${destaque.descricao }', ${destaque.publicado });" /></a></td>
				<c:set var="ativo" value="" />
				<c:if test="${destaque.publicado > 0}">
					<c:set var="ativo" value="checked='checked'" />
				</c:if>
				<td><input type="checkbox" name="ativo${destaque.idConteudo }" id="ativo${destaque.idConteudo }" onClick="ativar(${destaque.publicado },this.checked, '${destaque.idConteudo }');" ${ativo } /></td>
			</tr>					
		</c:forEach>
		</table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
</body>
</html>