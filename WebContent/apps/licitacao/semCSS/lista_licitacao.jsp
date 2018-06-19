<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>


<script>
//$(document).ready(function(){
		//$( "#tabs" ).tabs();
//	});

function excluir(vidConteudo, vdescricao)
{
	if (confirm("Deseja realmente excluir a licitacao " + vdescricao + " ?") == true)
		$.post("/gecoi.3.0/apps/licitacao/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar();});
}

</script>
<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
String vfiltro = request.getParameter("vfiltro");
String vfiltroValor = request.getParameter("vfiltroValor");
%>
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="filtro" value="<%=vfiltro %>" scope="page" />
<c:set var="filtroValor" value="<%=vfiltroValor %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaLicitacao(ano, texto, filtro, filtroValor, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
				<form name="flista">
				<table>
					<tr>
						<th>MODALIDADE</th>
						<th>Nº DO PREG&Atilde;O</th>
						<th>OBJETO</th>
						<th>Nº DO PROCESSO</th>
						<th>DATA DA ABERTURA</th>
						<th>SITUA&Ccedil;&Atilde;O</th>
						<th>A&Ccedil;&Otilde;ES</th>
					</tr>
		<c:forEach var="licitacao" items="${items}" >
			<tr>
				<td>${licitacao.tipo }</td>
				<td>${licitacao.numPregao }</td>
				<td>${licitacao.descricao }</td>
				<td>${licitacao.numProcesso }</td>
				<td>${licitacao.dataAbertura }</td>
				<td>${licitacao.situacao }</td>
				<td><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }&keepThis=true&TB_iframe=true&height=350&width=800" class="thickbox" title="Visualização do arquivo"><img id="arquivo${licitacao.idConteudo }" name="arquivo${licitacao.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" /></a></td>		
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_dados.jsp?idConteudo=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }&descricao=${licitacao.descricao }&nProcesso=${licitacao.numProcesso }&nPregao=${licitacao.numPregao }&dataAbertura=${licitacao.dataAbertura }&dataFechamento=${licitacao.dataFechamento }&tipo=${licitacao.tipo }','divbusca');" title="Manutenção dos dados da licitacao"><img id="dados${licitacao.idConteudo }" name="dados${licitacao.idConteudo }" src="/gecoi.3.0/img/alterar.gif" onclick="" width="30" height="30" /></a></td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_arquivo.jsp?id=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }&nProcesso=${licitacao.numProcesso}&nPregao=${licitacao.numPregao}&descricao=${licitacao.descricao }&tipo=${licitacao.tipo }&origem=principal&titulo=edital de licitação','divbusca');" title="Substitui&ccedil;&atilde;o do edital"><img id="arquivo${licitacao.idConteudo }" name="arquivo${licitacao.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a></td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=${licitacao.idConteudo }&nProcesso=${licitacao.numProcesso}&nPregao=${licitacao.numPregao}','divbusca');"  title="Manutenção dos Anexos"><img id="aditivo${licitacao.idConteudo }" name="aditivo${licitacao.idConteudo }" src="/gecoi.3.0/img/texto.jpg" onclick="" width="30" height="30" /></a></td>
				<td><a href="#" title="Exclusão da licitação"><img id="excluir${licitacao.idConteudo }" name="excluir${licitacao.idConteudo }" src="/gecoi.3.0/img/botao_excluir.png" width="30" height="30" onclick="excluir('${licitacao.idConteudo }', '${licitacao.numPregao }');" /></a></td>
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
