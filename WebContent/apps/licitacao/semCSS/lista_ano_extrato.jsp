<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaAnoExtrato(sessionScope['login'], sessionScope['senha'])}" />
<select name='ano' class='form-select' id='ano' > 
<c:forEach var="ano" items="${items}" varStatus="conta" >
	<c:if test="${conta.index == 0 }" >
		<option value="${ano }" selected="selected">${ano }</option>
	</c:if>
	<c:if test="${conta.index > 0 }" >
		<option value="${ano }">${ano }</option>
	</c:if>
</c:forEach>
</select> 
