<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
String vfiltro = request.getParameter("vfiltro");
String vfiltroValor = request.getParameter("vfiltroValor");
%>

<h2>Selecione a licita&ccedil;&atilde;o para incluir ou alterar um contrato ou aditivo</h2>
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
						<th>Nº DO PREG&Atilde;O</th>
						<th>OBJETO</th>
						<th>Nº DO PROCESSO</th>
						<th>A&Ccedil;&Otilde;ES</th>
					</tr>
		<c:forEach var="registro" items="${items}" >
			<tr>
				<td>${registro.numPregao }</td>
				<td>${registro.descricao }</td>
				<td>${registro.numProcesso }</td>
				<td><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${registro.idConteudo }&idArquivo=${registro.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" /></a></td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=${registro.idArquivo }&nPregao=${registro.numPregao }&nProcesso=${registro.numProcesso }','divbusca');"  title="Manutenção dos Contratos"><img id="aditivo${registro.idConteudo }" name="aditivo${registro.idConteudo }" src="/gecoi.3.0/img/texto.jpg" onclick="" width="30" height="30" /></a></td>
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
