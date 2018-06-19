<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList, br.jus.trerj.funcoes.GravarArquivo"%>

<%
String caminho = application.getRealPath("/");
%>
<jsp:useBean id="lista" class="br.jus.trerj.funcoes.ListaApp" />
<c:set var="caminho" value="<%=caminho %>"/>
<c:set var="items" value="${lista.getListaApp(caminho, sessionScope['login'], sessionScope['senha'])}" />
<c:forEach var="item" items="${items}" >
	<div id="app">
		<a href="javascript:void(0)" onclick="carregaAPP('/gecoi.3.0${item.caminho}','${item.descricao}');">
		<img src="/gecoi.3.0/img/${item.nomeArquivo}" onerror="this.src='/gecoi.3.0/img/imagem_indisponivel.jpg';" title="${item.nome}"/>
		<p>${item.nome }</p>
		</a>
		</div>
</c:forEach>
