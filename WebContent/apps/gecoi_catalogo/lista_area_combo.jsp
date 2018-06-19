<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
int vtipo  = (request.getParameter("tipo") == null ? 0 : Integer.parseInt(request.getParameter("tipo")));
int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer.parseInt(request.getParameter("grupo")));
int vcatalogo = (request.getParameter("catalogo") == null ? 0 : Integer.parseInt(request.getParameter("catalogo")));
%>
<c:set var="idTipo" value="<%=vtipo%>" scope="page" />
<c:set var="idGrupo" value="<%=vgrupo%>" scope="page" />
<c:set var="idCatalogo" value="<%=vcatalogo%>" scope="page" />
<jsp:useBean id="listas" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items" value="${listas.getListaArea(sessionScope['login'], sessionScope['senha'], idTipo, idGrupo, idCatalogo)}" />
<select name='area' class='form-select' id='area' onchange="atualiza_ano(this.form);"> 
<option value='-1'>Todos</option>
<c:forEach var="area" items="${items}" >
	<option value="${area.id_area }">${area.descricao_area }</option>
</c:forEach>
</select> 