<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vidArea = request.getParameter("area");
String vano = request.getParameter("ano");
%>
<c:set var="idArea" value="<%=vidArea %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaDescricaoRelatorio(idArea, ano, sessionScope['login'], sessionScope['senha'])}" />
<select name='descricao' class='form-select' id='descricao'> 
<c:forEach var="item" items="${items}" >
	<option value="${item.idArquivo }">${item.descricaoRedu }</option>
</c:forEach>
</select> 
