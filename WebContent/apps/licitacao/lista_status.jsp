<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
String vidArea = request.getParameter("area");
String vano = request.getParameter("ano");
String vfiltro = request.getParameter("filtro");
String vcor       = "#ECECEC";  // zebra a tabela

%>
<c:set var="idArea" value="<%=vidArea %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="filtro" value="<%=vfiltro %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaStatus(idArea, ano, filtro, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
    	<table id="tb_gecoi"><thead>
			<tr>
				<th scope="col" width="4%">MOD</th>
				<th scope="col" width="6%">Nº DA ATA</th>
				<th scope="col" width="6%">Nº DO PROCESSO</th>
                <th scope="col" width="35%">DESCRI&Ccedil;&Atilde;O</th>
                <th scope="col" colspan="8" width="20%">A&Ccedil;&Otilde;ES</th>
			</tr></thead><tbody>
		<c:forEach var="item" items="${items}">
        <!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
            	<td align="center" width="4%">${item.tipo }</td>
				<td align="center" width="6%">${item.numPregao }</td>
				<td align="center" width="6%">${item.numProcesso }</td>
				<td align="left" width="33%">${item.descricao }</td>
                <td width="2%" id="tdEncerrar${item.idConteudo }" class="divbotao">
                	<input type="button" style="visibility: ${item.mostraEncerrar};" class="form-botao_encerrar" id="botao_e${item.idConteudo }" onclick="concluir('Encerrar', ${item.idConteudo});" value="Encerrar" /></td>
				<td width="2%" id="tdSuspender${item.idConteudo }" class="divbotao"><input type="button" style="visibility: ${item.mostraSuspender};"" class="form-botao_suspender" id="botao_s${item.idConteudo }" onclick="concluir('Suspender', ${item.idConteudo});" value="Suspender" /></td>
					<!-- /c:if" -->
					<!-- c:if test="${item.dataFim <= item.hoje} >" -->
				<td width="2%" id="tdRevogar${item.idConteudo }" class="divbotao"><input type="button" style="visibility: ${item.mostraRevogar};" class="form-botao_reabir" id="botao_c${item.idConteudo }" onclick="concluir('Revogar', ${item.idConteudo});" value="Revogar/Anular" /></td>
				<td width="2%" id="tdReabrir${item.idConteudo }" class="divbotao"><input type="button" style="visibility: ${item.mostraReabrir};" class="form-botao_reabir" id="botao_c${item.idConteudo }" onclick="concluir('Reabrir', ${item.idConteudo});" value="Reabrir" /></td>
               		
                </td>
            </tr>
            </c:forEach>
        	</tbody></table>
 
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
