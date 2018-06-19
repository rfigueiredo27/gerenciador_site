<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vid_grupo = request.getParameter("grupo");
%>
<c:set var="id_grupo" value="<%=vid_grupo %>" scope="page" />
<jsp:useBean id="combo_catalogo2" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items" value="${combo_catalogo2.getComboCatalogo(sessionScope['login'], sessionScope['senha'], id_grupo)}" />
<select name="catalogo" class="form-control" id="catalogo"> 
<option value='0'>--------</option>
<c:forEach var="catalogo" items="${items}" >
	<option value="${catalogo.id_catalogo}">${catalogo.combo_catalogo}</option>
</c:forEach>
</select> 
