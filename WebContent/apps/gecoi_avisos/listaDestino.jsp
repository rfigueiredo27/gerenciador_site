<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
<c:set var="items"
	value="${lista.getDestino(sessionScope['login'], sessionScope['senha'])}" />
<select style="width:500px;" name='destino' id='destino'>
	<option value='0'>--</option>
	<option value='-1'>Todos</option>
	<c:forEach var="lista_gecoi" items="${items}">
		<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao }</option>
	</c:forEach>
</select>
