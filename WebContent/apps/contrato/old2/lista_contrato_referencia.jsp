<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
<script>


function excluirContrato(vidConteudo, plicitacao, pnProcesso, pnPregao, pata)
{
	if (confirm("Deseja realmente excluir o contrato " + pata + " ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_registro.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");});
}
</script>
<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
%>
<h1>Lista de Contratos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="items" value="${lista.getListaContrato(texto, ano, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fanexo" action="" method="post" enctype="multipart/form-data">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			 	<th>N&ordm; DO PREG&Atilde;O</th>
			 	<th>N&ordm; DO PROCESSO</th>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.nPregao }
        			</td>
        			<td>
        				${anexo.nProcesso }
        			</td>
        			<td>
        				${anexo.descricaoContrato }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" target="_blank" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_referencia_contrato.jsp?id=${anexo.idArquivo }&descricaoContrato=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&nPregao=${anexo.nPregao}&idReferencia=${anexo.idReferencia }','divbuscaContrato');" title="Alterar dados do Contrato"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
        			</td>
      			</tr>
			</c:forEach>
		</table>
	</form>
