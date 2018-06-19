<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>

<% 
String vano         = request.getParameter("ano");
String vchave       = (request.getParameter("chave")) == null ? "" : request.getParameter("chave");
String vfiltro      = (request.getParameter("filtro")) == null ? "" : request.getParameter("filtro");
String vfiltroValor = (request.getParameter("filtrovalor")) == null ? "" : request.getParameter("filtrovalor");

%>
<c:set var="chaveExtrato" value="<%=vchave %>" scope="page" />
<c:set var="anoExtrato" value="<%=vano %>" scope="page" />
<c:set var="filtroExtrato" value="<%=vfiltro %>" scope="page" />
<c:set var="filtroValorExtrato" value="<%=vfiltroValor %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaExtrato(chaveExtrato, anoExtrato, filtroExtrato, filtroValorExtrato, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<table width='98%' border='0' cellpadding='0' cellspacing='1' id='sublinhado'>
			<tr> 
				<th align='center' >Tipo</th>
				<th align='center' >Nº Pregão</th>
				<th align='center' >Objeto</th>
				<th align='center' >Nº Processo</th>
				<th align='center' >Data Abertura</th>
				<th align='center' >Data Publicação</th>
				<th align='center' >Situação</th>
			</tr>
		<c:forEach var="item" items="${items}" >
			<tr bordercolor='#FFFFFF' bgcolor='#FFFFFF' >
           		<td height='25' width='45' bordercolor='000046'><div align='center'>${item.tipo }</div></td>
				<td width='80' bordercolor='000046'><div align='center'>${item.numPregao }</div></td>
				<td height='25' bordercolor='000046'><a href='/gecoi.3.0/apps/licitacao/extrato.jsp?idconteudo=${item.idConteudo }&keepThis=true&TB_iframe=true&height=400&width=500' class='thickbox' target="divthick" title='Extrato de Publicação'>${item.descricao }</a></td>
				<td width='85'bordercolor='000046'><div align='center'>${item.numProcesso }</div></td>
		   		<td width='85'bordercolor='000046'><div align='center'>${item.dataAbertura }</div></td>
		   		<td width='85'bordercolor='000046'><div align='center'>${item.dataCriacao }</div></td>
				<td width='85'bordercolor='000046'><div align='center'>${item.situacao}</div></td>
           	</tr>
		</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
