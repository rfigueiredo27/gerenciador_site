<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.App,java.util.ArrayList"%>

<h1>Aplicativos</h1>

<p>
  <jsp:useBean id="lista" class="br.jus.trerj.controle.app.LerApp" />

  <c:set var="items" value="${lista.getListaApp(sessionScope.login, sessionScope.senha)}" />
  <c:choose>
    <c:when test="${!empty items}">
		<form name="fUsuariosApp" method="post" action="">
  			<select name="apps" id="apps" onChange="listaUsuariosApp();">
            <option value="0"></option>
            <c:forEach var="app" items="${items}" >
            	<option value="<c:out value='${app.id_app}' />"><c:out value='${app.nome}' /></option>
            </c:forEach>
  			</select>
		</form>
    </c:when>
    <c:otherwise>
      <c:out value="Não tem registros" />
    </c:otherwise>
  </c:choose>
</p>
<div id="resultado"></div>
<p>&nbsp; </p>	
