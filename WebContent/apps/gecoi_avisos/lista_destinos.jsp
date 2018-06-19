<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>




<jsp:useBean id="lista_manutencao" class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
<c:set var="items" value="${lista_manutencao.getDestino(sessionScope['login'], sessionScope['senha'])}" />
<select name='area' id='area' onchange="atualiza_ano_status(this.form);">
<option value='0'>--</option>
<c:forEach var="lista_gecoi" items="${items}">
	<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao }</option>
</c:forEach>
</select>