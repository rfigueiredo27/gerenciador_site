<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="java.util.ArrayList"%>

Destaques ativos
<jsp:useBean id="lista" class="br.jus.trerj.controle.destaque.ListaDestaques" /> 
<c:set var="items" value="${lista.getListaDestaques('', '1', sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
	<form name="flista">
		<table>
		<c:forEach var="destaque" items="${items}" >
			<tr>
				<td>${destaque.descricao }</td>
			</tr>					
		</c:forEach>
		</table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>