<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
<script>


function excluirContrato(vidConteudo, plicitacao, pnProcesso, pnPregao, pata)
{
	if (confirm("Deseja realmente excluir o contrato " + pata + " ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_registro.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");zera_contador();});
}
</script>
<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
String vcor       = "#ECECEC";  // zebra a tabela
%>
<h1>Lista de Contratos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="items" value="${lista.getListaContrato(texto, ano, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="fanexo" action="" method="post" enctype="multipart/form-data">
			<table id="tb_gecoi"><thead>
				<tr>
			 		<th scope="col" width="8%">N&ordm; DO PREG&Atilde;O</th>
			 		<th scope="col" width="8%">N&ordm; DO PROCESSO</th>
					<th scope="col" width="76%">DESCRI&Ccedil;&Atilde;O</th>
					<th scope="col" colspan="8" width="5%">A&Ccedil;&Atilde;O</th>
				</tr></thead>
			<c:forEach var="anexo" items="${items}" >
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
				<tr bgcolor=<%=vcor%> >
        			<td align="center">${anexo.nPregao }</td>
        			<td align="center">${anexo.nProcesso }</td>
        			<td align="left">${anexo.descricaoContrato }</td>
        			<td><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onClick="" width="22" height="22" target="_blank" /></a></td>
           			<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_referencia_contrato.jsp?id=${anexo.idArquivo }&descricaoContrato=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&nPregao=${anexo.nPregao}&idReferencia=${anexo.idReferencia }','divbuscaContrato');" title="Alterar refer&ecirc;ncia do contrato"><img src="/gecoi.3.0/img/texto.jpg" onClick="" width="22" height="22" /></a></td>
        			
      			</tr>
			</c:forEach>
		</table>
      </form>
	</c:when>
	<c:otherwise>
		<c:out value="Não há registros" />
	</c:otherwise>
</c:choose>
