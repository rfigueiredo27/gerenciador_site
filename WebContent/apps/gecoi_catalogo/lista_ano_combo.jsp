<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
int varea     =  (request.getParameter("area")==null) ? 0 : Integer.parseInt(request.getParameter("area").toString());
int vgrupo    =  (request.getParameter("grupo")==null) ? 0 : Integer.parseInt(request.getParameter("grupo").toString());
int vtipo     =  (request.getParameter("tipo")==null) ? 0 : Integer.parseInt(request.getParameter("tipo").toString());
int vcatalogo =  (request.getParameter("id")==null) ? 0 : Integer.parseInt(request.getParameter("id").toString());
int vano      =  (request.getParameter("ano")==null) ? 0 : Integer.parseInt(request.getParameter("ano").toString());
%>
<c:set var="idTipo" value="<%=vtipo%>" scope="page" />
<c:set var="idGrupo" value="<%=vgrupo%>" scope="page" />
<c:set var="idCatalogo" value="<%=vcatalogo%>" scope="page" />
<c:set var="idArea" value="<%=varea%>" scope="page" />
<c:set var="anos" value="<%=vano%>" scope="page" />
<jsp:useBean id="listas" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items" value="${listas.getAno(sessionScope['login'], sessionScope['senha'], idArea, idGrupo, idTipo, idCatalogo, anos)}" />
<select name='ano' class='form-select' id='ano'> 
<option value='0'>Todos</option>
<c:forEach var="vano" items="${items}" >
	<option value="${vano.ano }">${vano.ano }</option>
</c:forEach>
</select> 