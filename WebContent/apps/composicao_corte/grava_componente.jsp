<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.Componente,java.util.ArrayList"%>

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
<link rel="stylesheet" type="text/css" href="/gecoi.3.0/apps/composicao_corte/composicao_corte.css"/>

<h1>Composi&ccedil;&atilde;o da Corte</h1>   

<form name="fgravaxml" action="/gecoi.3.0/gravaxml" method="post" target="processa_background">
 <jsp:useBean id="lista" class="br.jus.trerj.controle.composicao.LerXML" />
 <c:set var="listaCurriculos" value="${lista.getListaCurriculos(request.getServletPath(), request.getRemoteAddr())}" />
<c:set var="items" value="${lista.getComponentes(sessionScope.login, sessionScope.senha)}" />
<!-- Membros Efetivos -->
<table id="estilo_azul" summary="Tabela contendo os membros que comp&otilde;em o tribunal.">
	<thead>
		<tr>
      		<th colspan="6">Membros</th>
    	</tr>
  	</thead>
	<tbody>
    	<tr>
      		<th>EFETIVOS</th>
      		<th>CLASSE E CARGO</th>
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
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}" class="input_nome"/>
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}"/>
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }" class="input_cargo"/></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" class="input_inicio"/></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" class="input_final"/></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }" class="input_bienio"/></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" class="input_obs"/></td>
			<td>			
              <select name="curriculo${contador}" id="curriculo${contador}" class="input_curriculo">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.idConteudo == componente.id}">
                			<option value="<c:out value='${curriculo.idConteudo}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.idConteudo}' />"><c:out value="${curriculo.descricao}" /></option>	
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
      		<th>SUBSTITUTOS</th>
      		<th>CLASSE</th>
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
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}" class="input_nome"/>
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }" class="input_cargo"/></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" class="input_inicio"/></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" class="input_final"/></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }" class="input_bienio"/></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" class="input_obs"/></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}" class="input_curriculo">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.idConteudo == componente.id}">
                			<option value="<c:out value='${curriculo.idConteudo}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.idConteudo}' />"><c:out value="${curriculo.descricao}" /></option>	
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
      		<th colspan="6">Minist&eacute;rio P&uacute;blico</th>
    	</tr>
  	</thead>
	<tbody>
    	<tr>
      		<th>EFETIVO</th>
      		<th>CLASSE</th>
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
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}" class="input_nome"/>
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }" class="input_cargo"/></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" class="input_inicio"/></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" class="input_final"/></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }" class="input_bienio"/></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" class="input_obs"/></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}" class="input_curriculo">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.idConteudo == componente.id}">
                			<option value="<c:out value='${curriculo.idConteudo}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.idConteudo}' />"><c:out value="${curriculo.descricao}" /></option>	
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
      		<th>SUBSTITUTO</th>
      		<th>CLASSE</th>
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
				<input type="text" name="nome${contador}" id="nome${contador}" value="${componente.nome}" class="input_nome"/>
				<input type="hidden" name="classe${contador}" id="classe${contador}" value="${componente.classe}" />
				<input type="hidden" name="tipo${contador}" id="tipo${contador}" value="${componente.tipo}" />
			</td>
			<td><input type="text" name="cargo${contador}" id="cargo${contador}" value="${componente.cargo }" class="input_cargo"/></td>
			<td align="center"><input type="text" name="mandatoInicial${contador}" id="mandatoInicial${contador}" value="${componente.mandatoInicial }" class="input_inicio"/></td>
			<td align="center"><input type="text" name="mandatoFinal${contador}" id="mandatoFinal${contador}" value="${componente.mandatoFinal }" class="input_final"/></td>
			<td align="center"><input type="text" name="bienio${contador}" id="bienio${contador}" value="${componente.bienio }" class="input_bienio"/></td>
			<td><input type="text" name="obs${contador}" id="obs${contador}" value="${componente.obs }" class="input_obs"/></td>
			<td>
              <select name="curriculo${contador}" id="curriculo${contador}" class="input_curriculo">
                <option value="0"></option>
				<c:forEach var="curriculo" items="${listaCurriculos}">
                	<c:choose>
                    	<c:when test="${curriculo.idConteudo == componente.id}">
                			<option value="<c:out value='${curriculo.idConteudo}' />" selected><c:out value="${curriculo.descricao}" /></option>	
                        </c:when>
                        <c:otherwise>
                        	<option value="<c:out value='${curriculo.idConteudo}' />"><c:out value="${curriculo.descricao}" /></option>	
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

<input type="submit" name="button" id="button" value="Gravar" />
</form>