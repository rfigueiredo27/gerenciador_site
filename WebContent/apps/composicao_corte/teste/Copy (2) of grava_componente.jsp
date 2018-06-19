<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.Componente,java.util.ArrayList"%>

<html>
<head>
<!--Scripts do Jquery-->
<script src="../../jquery/jquery-1.10.2.js"></script>  
<script src="../../jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.js"></script>
<link rel="stylesheet" type="text/css" href="../../jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>

<script>
		$(function() {
			$( "#mandatoInicial1" ).datepicker();
			$( "#mandatoFinal1" ).datepicker();
			$( "#mandatoInicial2" ).datepicker();
			$( "#mandatoFinal2" ).datepicker();
			$( "#mandatoInicial3" ).datepicker();
			$( "#mandatoFinal3" ).datepicker();
			$( "#mandatoInicial4" ).datepicker();
			$( "#mandatoFinal4" ).datepicker();
			$( "#mandatoInicial5" ).datepicker();
			$( "#mandatoFinal5" ).datepicker();
			$( "#mandatoInicial6" ).datepicker();
			$( "#mandatoFinal6" ).datepicker();
			$( "#mandatoInicial7" ).datepicker();
			$( "#mandatoFinal7" ).datepicker();
			$( "#mandatoInicial8" ).datepicker();
			$( "#mandatoFinal8" ).datepicker();
			$( "#mandatoInicial9" ).datepicker();
			$( "#mandatoFinal9" ).datepicker();
			$( "#mandatoInicial10" ).datepicker();
			$( "#mandatoFinal10" ).datepicker();
			$( "#mandatoInicial11" ).datepicker();
			$( "#mandatoFinal11" ).datepicker();
			$( "#mandatoInicial12" ).datepicker();
			$( "#mandatoFinal12" ).datepicker();
			$( "#mandatoInicial13" ).datepicker();
			$( "#mandatoFinal13" ).datepicker();
			$( "#mandatoInicial14" ).datepicker();
			$( "#mandatoFinal14" ).datepicker();
			$( "#mandatoInicial15" ).datepicker();
			$( "#mandatoFinal15" ).datepicker();
			$( "#mandatoInicial16" ).datepicker();
			$( "#mandatoFinal16" ).datepicker();
			$( "#mandatoInicial17" ).datepicker();
			$( "#mandatoFinal17" ).datepicker();
		});
</script>

</head>

<body>

<form name="fgravaxml" action="/gecoi.3.0/gravaxml" method="post"> 
<h1>Composi&ccedil;&atilde;o da Corte</h1>

<jsp:useBean id="lista" class="br.jus.trerj.controle.composicao.LerXML" />
<c:set var="listaCurriculos" value="${lista.getListaCurriculos()}" />
<!--<c:set var="items" value="${lista.getComponentes(vlogin, vsenha)}" />-->
<c:set var="items" value="${lista.getComponentes('gecoi', '5851385')}" />


<!-- Membros Efetivos -->
<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
	<thead>
		<tr>
      		<th colspan="6">Membros</th>
    	</tr>
  	</thead>
	<tbody>
    	<tr>
      		<th>NOME</th>
      		<th>CATEGORIA</th>
      		<th>IN&Iacute;CIO</th>
      		<th>T&Eacute;RMINO</th>
      		<th>BI&Ecirc;NIO</th>
      		<th>OBSERVA&Ccedil;&Atilde;O</th>
      		<th>CURRÍCULO</th>
   	 	</tr>
<c:set var="contador" value="${1 }" />
<c:forEach var="componente" items="${items}" begin="0" end="6" >
		<tr>
            <td>
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}" size="80" />
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }"  size="50" /></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }"  size="10" /></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }"  size="10" /></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }"  size="8" /></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }"  size="100" /></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.id == componente.id}">
                			<option value="<c:out value='${curriculo.id}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.id}' />"><c:out value="${curriculo.descricao}" /></option>	
                        </c:otherwise>
                    </c:choose>
                </c:forEach>              
              </select>
            </td>
		</tr>
 	<c:set var="contador" value="${contador + 1}"/>
</c:forEach>
	</tbody>
</table>
<br>

<!-- Membros Substitutos -->
<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
	<tbody>
    	<tr>
      		<th>NOME</th>
      		<th>CATEGORIA</th>
      		<th>IN&Iacute;CIO</th>
      		<th>T&Eacute;RMINO</th>
      		<th>BI&Ecirc;NIO</th>
      		<th>OBSERVA&Ccedil;&Atilde;O</th>
      		<th>CURRÍCULO</th>
   	 	</tr>
<c:set var="contador" value="${8 }" />
<c:forEach var="componente" items="${items}" begin="7" end="13" >
		<tr>
			<td>
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}"  size="80" />
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }"  size="50" /></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" size="10" /></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" size="10" /></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }"  size="8" /></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" size="100" /></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.id == componente.id}">
                			<option value="<c:out value='${curriculo.id}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.id}' />"><c:out value="${curriculo.descricao}" /></option>	
                        </c:otherwise>
                    </c:choose>
                </c:forEach>              
              </select>
            </td>
		</tr>
		<c:set var="contador" value="${contador + 1}"/>
	</c:forEach>
  	</tbody>
</table>
<br>

<!-- Procurador Efetivo -->
<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
	<thead>
		<tr>
      		<th colspan="6">Minist&eacute;rio P&uacute;blico - Procuradores</th>
    	</tr>
  	</thead>
	<tbody>
    	<tr>
      		<th>NOME</th>
      		<th>CATEGORIA</th>
      		<th>IN&Iacute;CIO</th>
      		<th>T&Eacute;RMINO</th>
      		<th>BI&Ecirc;NIO</th>
      		<th>OBSERVA&Ccedil;&Atilde;O</th>
      		<th>CURRÍCULO</th>
   	 	</tr>
<c:set var="contador" value="${15 }" />
<c:forEach var="componente" items="${items}" begin="14" end="14" >
		<tr>
			<td>
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}"  size="80" />
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }"  size="50" /></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" size="10" /></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" size="10" /></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }"  size="8" /></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" size="100" /></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.id == componente.id}">
                			<option value="<c:out value='${curriculo.id}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.id}' />"><c:out value="${curriculo.descricao}" /></option>	
                        </c:otherwise>
                    </c:choose>
                </c:forEach>              
              </select>
            </td>
		</tr>
 	<c:set var="contador" value="${contador + 1}"/>
</c:forEach>
	</tbody>
</table>
<br>

<!-- Procurador Substituto -->
<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
	<tbody>
    	<tr>
      		<th>NOME</th>
      		<th>CATEGORIA</th>
      		<th>IN&Iacute;CIO</th>
      		<th>T&Eacute;RMINO</th>
      		<th>BI&Ecirc;NIO</th>
      		<th>OBSERVA&Ccedil;&Atilde;O</th>
      		<th>CURRÍCULO</th>
   	 	</tr>
<c:set var="contador" value="${16 }" />
<c:forEach var="componente" items="${items}" begin="15" end="15" >
		<tr>
			<td>
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}"  size="80" />
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }"  size="50" /></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" size="10" /></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" size="10" /></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }"  size="8" /></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" size="100" /></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.id == componente.id}">
                			<option value="<c:out value='${curriculo.id}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.id}' />"><c:out value="${curriculo.descricao}" /></option>	
                        </c:otherwise>
                    </c:choose>
                </c:forEach>              
              </select>
            </td>
		</tr>
 	<c:set var="contador" value="${contador + 1}"/>
</c:forEach>
	</tbody>
</table>
<br>

<!-- Defensoria Publica -->
<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
	<thead>
		<tr>
      		<th colspan="6">Defensoria P&uacute;blica</th>
    	</tr>
  	</thead>
	<tbody>
    	<tr>
      		<th>NOME</th>
      		<th>CATEGORIA</th>
      		<th>IN&Iacute;CIO</th>
      		<th>T&Eacute;RMINO</th>
      		<th>BI&Ecirc;NIO</th>
      		<th>OBSERVA&Ccedil;&Atilde;O</th>
      		<th>CURRÍCULO</th>
			<td>
<c:set var="contador" value="${17 }" />
<c:forEach var="componente" items="${items}" begin="16" end="16" >
		<tr>
			<td>
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}"  size="80" />
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }"  size="50" /></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" size="10" /></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }"  size="10" /></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }"  size="8" /></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }"  size="100" /></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.id == componente.id}">
                			<option value="<c:out value='${curriculo.id}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.id}' />"><c:out value="${curriculo.descricao}" /></option>	
                        </c:otherwise>
                    </c:choose>
                </c:forEach>              
              </select>
            </td>
		</tr>
 	<c:set var="contador" value="${contador + 1}"/>
</c:forEach>
	</tbody>
</table>
<br>

<input type="hidden" name="logon_usuario_criacao" id="logon_usuario_criacao" value="gdebossa" />
<input type="submit" name="button" id="button" value="Gravar" /> 
</form>

</body>
</html>