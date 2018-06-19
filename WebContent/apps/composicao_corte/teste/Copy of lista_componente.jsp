<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.Componente,java.util.ArrayList"%>

<h1>Composi&ccedil;&atilde;o da Corte</h1>

<jsp:useBean id="lista" class="br.jus.trerj.controle.composicao.LerXML" />
<c:set var="items" value="${lista.getComponentes('internauta', 'internauta')}" />
<c:choose>
	<c:when test="${!empty items}">
   	 	<c:set var="tipoAnterior" value=""/>
   	 	<c:set var="classeAnterior" value=""/>
		<c:forEach var="componente" items="${items}" >
			<c:if test="${componente.tipo != tipoAnterior }" >
				<c:if test="${tipoAnterior != '' }" >
						</tbody>
					</table>
    				<br>
				</c:if>
				<table id="estilo_azul" summary="Tabela contendo os ministros que comp&otilde;em o tribunal. S&atilde;o apresentados a origem e o per&iacute;odo de vig&ecirc;ncia no mandato." width="80%">
					<c:if test="${componente.classe != classeAnterior }" >
  						<thead>
    						<tr>
      							<th colspan="6">${fn:toUpperCase(componente.classe) }</th>
    						</tr>
  						</thead>
  					</c:if>
  					<tbody>
    				<tr>
      					<th width="29%">${fn:toUpperCase(componente.tipo) }</th>
                        <c:if test="${componente.tipo == 'EFETIVO' && componente.classe == 'Membro' }" >
      						<th width="20%">CLASSE E CARGO</th>
                        </c:if>
                        <c:if test="${componente.tipo == 'EFETIVO' && componente.classe != 'Membro' }" >
      						<th width="20%">CLASSE</th>
                        </c:if>
                        <c:if test="${componente.tipo == 'SUBSTITUTO' }" >
                        	<th width="20%">CLASSE</th>
                        </c:if>
      					<th width="10%">IN&Iacute;CIO</th>
      					<th width="10%">T&Eacute;RMINO</th>
      					<th width="7%">BI&Ecirc;NIO</th>
      					<th width="20%">OBSERVA&Ccedil;&Atilde;O</th>
   	 				</tr>
			</c:if>
			<c:set var="tipoAnterior" value="${componente.tipo }"/>
			<c:set var="classeAnterior" value="${componente.classe }"/>
			<tr>
				<td><a title="" href="mostra_curriculo.jsp?id=${componente.id }" target="_self">${componente.nome}</a></td>
				<td>${componente.cargo }</td>
				<td align="center">${componente.mandatoInicial }</td>
				<td align="center">${componente.mandatoFinal }</td>
				<td align="center">${componente.bienio }</td>
				<td>${componente.obs }</td>
			</tr>
		</c:forEach>
  		</tbody>
	</table>
    <br>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>	
