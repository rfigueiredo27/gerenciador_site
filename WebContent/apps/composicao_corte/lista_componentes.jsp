<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="br.jus.trerj.modelo.Componente,java.util.ArrayList"%>

<div id="origem_informacao">
      <a href='javascript:window.print();' class='imprimir' title="imprimir"><img src="/site/img/printer.gif" width="22" height="22" border="0"/></a>&nbsp;&nbsp;
      <a href="#" id="opener"><img src="/site/img/mais_informacoes.png" width="14" height="15" title="Gestor desse conte&uacute;do"/></a>
      <div id="dialog-message" title="Gestor desse conteúdo">
        <%//@include file="/origem_informacao/tre_secjul.jsp"%>
      </div>
</div>  

<h1>Composi&ccedil;&atilde;o da Corte</h1>

<jsp:useBean id="lista" class="br.jus.trerj.controle.composicao.LerXML" />
<c:set var="items" value="${lista.componentes}" />
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
				<table id="estilo_azul" summary="Tabela contendo os membros que comp&otilde;em o tribunal." width="95%">
					<c:if test="${componente.classe != classeAnterior }" >
  						<thead>
    						<tr>
      							<th colspan="6"><c:out value="${componente.classe }"/></th>
    						</tr>
  						</thead>
  					</c:if>
  					<tbody>
    				<tr>
      					<th width="29%"><c:out value="${componente.tipo }"/></th>
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
            	<c:choose>
                	<c:when test="${componente.id > 0}">
						<td><a title="Membro da corte" href="javascript:void(0);" onclick="carrega_pagina('/site/institucional/composicao/mostra_curriculo.jsp?id=<c:out value='${componente.id }'/>')"><c:out value="${componente.nome}"/></a></td>
                    </c:when>
                    <c:otherwise>
						<td><c:out value="${componente.nome}"/></td>
                    </c:otherwise>
                </c:choose>
				<td><c:out value="${componente.cargo }"/></td>
				<td align="center"><c:out value="${componente.mandatoInicial }"/></td>
				<td align="center"><c:out value="${componente.mandatoFinal }"/></td>
				<td align="center"><c:out value="${componente.bienio }"/></td>
				<td><c:out value="${componente.obs }"/></td>
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