<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vidArea = request.getParameter("area");
%>
<c:set var="idArea" value="<%=vidArea %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
<c:set var="items" value="${lista.getListaAnoStatus(idArea, sessionScope['login'], sessionScope['senha'])}" />
<select name='ano' class='form-select' id='ano'> 
<option value='0'>--</option>
<c:forEach var="ano" items="${items}" >
	<option value="${ano }">${ano }</option>
</c:forEach>
</select> 
