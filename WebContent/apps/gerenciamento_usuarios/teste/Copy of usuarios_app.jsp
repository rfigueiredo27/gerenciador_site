<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.App,java.util.ArrayList"%>

<!--Scripts do Jquery-->
<script src="../../jquery/jquery-1.10.2.js"></script>  
<script src="../../jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.js"></script>
<link rel="stylesheet" type="text/css" href="../../jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>

<script>
function listaUsuariosApp()
{
	//alert(document.fUsuariosApp.apps.value);
	$.post("/gecoi.3.0/listaUsuarios", {idApp : document.fUsuariosApp.apps.value}, function(data) {$("#resultado").html(data);});
}
</script>

<h1>Aplicativos</h1>

<p>
  <jsp:useBean id="lista" class="br.jus.trerj.controle.app.LerApp" />

  <c:set var="login" value="gdebossa" scope="session" />
  <c:set var="senha" value="gude0004" scope="session" />
  <c:set var="items" value="${lista.getListaApp(sessionScope.login)}" />
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
