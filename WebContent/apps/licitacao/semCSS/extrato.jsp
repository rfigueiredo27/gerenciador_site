<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<% 
int vidConteudo         = Integer.parseInt(request.getParameter("idconteudo"));
%>
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="extrato" value="${lista.getExtrato(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<br />
		<table width='500' height='60' align='center' cellspacing='1' cellpadding='4' id='tab_extrato'>
		<tr><td colspan='2' height='25' align='center'><img src='/gecoi.3.0/img/2_Marca_TRE_RJ_PeB_Vol.png' width='301' height='60' /></td></tr>
		<tr><th colspan='2' height='25' align='center' class='texto_branco'>Confimação de Publicação de Edital</th></tr>
		<tr><td width='122' >Tipo</td>
		<td width='373' >${extrato.tipo }</td></tr>
		<tr><td >Nº do Processo</td>
		<td >${extrato.numProcesso }</td></tr>
		<tr><td >Nº do Pregão</td>
		<td >${extrato.numPregao }</td></tr>
		<tr><td >Objeto</td>
		<td >${extrato.descricao }</td></tr>
		<tr><td >Data de Abertura</td>
		<td >${extrato.dataAbertura }</td></tr>
		<tr><td >Data de Publicação</td>
		<td >${extrato.dataCriacao }</td></tr>
		<tr><td >Data de Impressão</td>
		<td >${extrato.dataImpressao }</td></tr>
		</table>
		<table width='500' height='10' align='center' border='0'><tr><td>
		<input type='button' name='button' class='item_formulario' value='Imprimir' onclick='window.print();'/>
		</td></tr></table>
