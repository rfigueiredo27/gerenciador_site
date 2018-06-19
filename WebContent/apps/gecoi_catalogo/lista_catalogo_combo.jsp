<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vid_grupo = request.getParameter("grupo");
%>
<c:set var="id_grupo" value="<%=vid_grupo %>" scope="page" />
<jsp:useBean id="combo_catalogo" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items" value="${combo_catalogo.getComboCatalogo(sessionScope['login'], sessionScope['senha'], id_grupo)}" />
<select name="catalogo" class='form-select' id="catalogo" onchange="atualiza_tipo(this.form);"> 
<option value='0'>--</option>
<c:forEach var="catalogo" items="${items}" >
	<option value="${catalogo.id_catalogo}">${catalogo.combo_catalogo}</option>
</c:forEach>
</select> 
