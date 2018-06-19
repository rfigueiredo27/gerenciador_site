<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

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
String vcor       = "#ECECEC";  // zebra a tabela
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
				<table id="tb_gecoi"><thead>
					<tr>
						<th scope="col" width="4%">MOD</th>
						<th scope="col" width="8%">N� DO PREG&Atilde;O</th>
						<th scope="col" width="35%">OBJETO</th>
						<th scope="col" width="8%">N� DO PROCESSO</th>
						<th scope="col" width="8%">DATA DA ABERTURA</th>
						<th scope="col" width="8%">DATA DA PUBLICA&Ccedil;&Atilde;O</th>
						<!--<th scope="col" width="8%">DATA DO ENCERRAMENTO</th>-->
						<th scope="col" width="6%">SITUA&Ccedil;&Atilde;O</th>
						<th scope="col" colspan="8" width="20%">A&Ccedil;&Otilde;ES</th>
					</tr></thead><tbody>
		<c:forEach var="licitacao" items="${items}" >
<!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
				<td align="center" width="4%">${licitacao.tipo }</td>
				<td align="center" width="8%">${licitacao.numPregao }</td>
				<td align="left" width="35%">${licitacao.descricao }</td>
				<td align="center" width="8%">${licitacao.numProcesso }</td>
				<td align="center" width="8%">${licitacao.dataAbertura }</td>
				<td align="center" width="8%">${licitacao.dataPublicacao }</td>
				<!--<td align="center" width="6%">${licitacao.dataFechamento }</td>-->
				<td align="center" width="8%">${licitacao.situacao }</td>
				<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }" target="_blank" title="Visualiza��o do arquivo"><img id="arquivo${licitacao.idConteudo }" name="arquivo${licitacao.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a></td>		
				<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_dados.jsp?idConteudo=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }&descricao=${licitacao.descricao }&nProcesso=${licitacao.numProcesso }&nPregao=${licitacao.numPregao }&dataAbertura=${licitacao.dataAbertura }&dataFechamento=${licitacao.dataFechamento }&dataPublicacao=${licitacao.dataPublicacao }&tipo=${licitacao.tipo }','divbusca');" title="Manuten��o dos dados da licitacao"><img id="dados${licitacao.idConteudo }" name="dados${licitacao.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
				<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_arquivo.jsp?id=${licitacao.idConteudo }&idArquivo=${licitacao.idArquivo }&nProcesso=${licitacao.numProcesso}&nPregao=${licitacao.numPregao}&descricao=${licitacao.descricao }&tipo=${licitacao.tipo }&origem=principal&titulo=edital de licita��o','divbusca');" title="Substitui&ccedil;&atilde;o do edital"><img id="arquivo${licitacao.idConteudo }" name="arquivo${licitacao.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
				<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=${licitacao.idConteudo }&nProcesso=${licitacao.numProcesso}&nPregao=${licitacao.numPregao}','divbusca');"  title="Manuten��o dos Anexos"><img id="aditivo${licitacao.idConteudo }" name="aditivo${licitacao.idConteudo }" src="/gecoi.3.0/img/clips.png" onclick="" width="16" height="16" /></a></td>
				<td width="2%"><a href="#" title="Exclus�o da licita��o"><img id="excluir${licitacao.idConteudo }" name="excluir${licitacao.idConteudo }" src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" onclick="excluir('${licitacao.idConteudo }', '${licitacao.numPregao }');" /></a></td></tr>
			</tr>					
		</c:forEach>
		</tbody></table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="N�o tem registros" />
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
