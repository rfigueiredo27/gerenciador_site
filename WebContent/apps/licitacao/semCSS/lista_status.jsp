<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vidArea = request.getParameter("area");
String vano = request.getParameter("ano");
String vfiltro = request.getParameter("filtro");

%>
<c:set var="idArea" value="<%=vidArea %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="filtro" value="<%=vfiltro %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaStatus(idArea, ano, filtro, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<c:forEach var="item" items="${items}" >
			<div class="divconteudo">
				<div id="divdescricao" class="divdescricao">${item.descricao }</div>
				<div id="divbotao${item.idConteudo }" class="divbotao">
					<!-- o c:if não tá funcionando então eu mostro o botão pela classe java -->
					<!-- c:if test="${item.dataFim > item.hoje} >" -->
						<input type="button" style="visibility: ${item.mostraEncerrar};" class="form-botao_encerrar" id="botao_e${item.idConteudo }" onclick="concluir('Encerrar', ${item.idConteudo});" value="Encerrar" />
						<input type="button" style="visibility: ${item.mostraSuspender};"" class="form-botao_suspender" id="botao_s${item.idConteudo }" onclick="concluir('Suspender', ${item.idConteudo});" value="Suspender" />
					<!-- /c:if" -->
					<!-- c:if test="${item.dataFim <= item.hoje} >" -->
						<input type="button" style="visibility: ${item.mostraReabrir};" class="form-botao_reabir" id="botao_c${item.idConteudo }" onclick="concluir('Reabrir', ${item.idConteudo});" value="Reabrir" />
					<!-- /c:if" -->
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
