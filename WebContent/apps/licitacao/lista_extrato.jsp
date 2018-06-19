<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>

<% 
String vano         = request.getParameter("ano");
String vchave       = (request.getParameter("chave")) == null ? "" : request.getParameter("chave");
String vfiltro      = (request.getParameter("filtro")) == null ? "" : request.getParameter("filtro");
String vfiltroValor = (request.getParameter("filtrovalor")) == null ? "" : request.getParameter("filtrovalor");
String vcor       = "#ECECEC";  // zebra a tabela

%>
<c:set var="chaveExtrato" value="<%=vchave %>" scope="page" />
<c:set var="anoExtrato" value="<%=vano %>" scope="page" />
<c:set var="filtroExtrato" value="<%=vfiltro %>" scope="page" />
<c:set var="filtroValorExtrato" value="<%=vfiltroValor %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaExtrato(chaveExtrato, anoExtrato, filtroExtrato, filtroValorExtrato, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<table id="tb_gecoi"><thead>
					<tr>
				<th scope="col" width="4%" >Tipo</th>
				<th scope="col" width="6%" >Nº Pregão</th>
				<th scope="col" width="40%" >Objeto</th>
				<th scope="col" width="6%" >Nº Processo</th>
				<th scope="col" width="8%" >Data Abertura</th>
				<th scope="col" width="8%" >Data Publicação</th>
				<th scope="col" width="6%" >Situação</th>
			</tr>
		<c:forEach var="item" items="${items}" >
 <!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
           		<td align="center">${item.tipo }</td>
				<td align="center">${item.numPregao }</td>
                <td align="left"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/extrato.jsp?idconteudo=${item.idConteudo }','divExtrato');">${item.descricao }</a></td>
				<td align="center">${item.numProcesso }</td>
		   		<td align="center">${item.dataAbertura }</td>
		   		<td align="center">${item.dataPublicacao }</td>
				<td align="center">${item.situacao}</td>
           	</tr>
		</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
