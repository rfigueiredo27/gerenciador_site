<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
int varea  = (request.getParameter("area") == null ? 0 : Integer.parseInt(request.getParameter("area")));
int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer.parseInt(request.getParameter("grupo")));
int vcatalogo = (request.getParameter("catalogo") == null ? 0 : Integer.parseInt(request.getParameter("catalogo")));
%>
<c:set var="idArea" value="<%=varea%>" scope="page" />
<c:set var="idGrupo" value="<%=vgrupo%>" scope="page" />
<c:set var="idCatalogo" value="<%=vcatalogo%>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items" value="${lista.getTipos(sessionScope['login'], sessionScope['senha'], idArea, idGrupo, idCatalogo)}" />
<select name='tipo' class='form-select' id='tipo' onchange="atualiza_area(this.form);"> 
<option value='-1'>Todos</option>
<c:forEach var="tipo" items="${items}" >
	<option value="${tipo.tipo_area }">${tipo.descricao_tipo }</option>
</c:forEach>
</select> 
