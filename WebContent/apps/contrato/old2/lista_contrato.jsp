<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>

function excluirAnexo(vidConteudo, plicitacao, pnProcesso, pnPregao, pcontrato)
{
	if (confirm("Deseja realmente excluir o contrato " + pcontrato + " e seus aditivos ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
%>
<h1>Lista de Contratos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="items" value="${lista.getListaReferencia(idLicitacao, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fcontrato" action="/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td>
        			Nº do Pregão: <input type="text" name="nPregao" id="nPregao" value="<%=vnumPregao %>" readonly="readonly" />
        		</td>
      		</tr>
      		<tr>
        		<td>
        			Nº do Processo: <input type="text" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        		</td>
      		</tr>
			<tr>
				<th>CONTRATO</th>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>PUBLICA&Ccedil;&Atilde;O</th>
				<th>VIG&Ecirc;NCIA</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.nContrato }
        			</td>
        			<td>
        				${anexo.descricaoContrato }
        			</td>
        			<td>
        				${anexo.dataPublicacao }
        			</td>
        			<td>
        				${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" target="_blank" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=${anexo.descricaoContrato }&nContrato=${anexo.nContrato}&titulo=Contrato&origem=principal','divbusca');" title="Substitui&ccedil;&atilde;o do Contrato"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_contrato.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&nContrato=${anexo.nContrato}','divbusca');" title="Alterar dados do Contrato"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=${idLicitacao }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&nContrato=${anexo.nContrato}&dataPublicacao=${anexo.dataPublicacao }','divbusca');" title="Aditivos"><img width="20" height="20" src="/gecoi.3.0/img/texto.jpg" /></a>
           				<a href="#" onclick="excluirAnexo(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}', '${anexo.nContrato }');" title="Exclusão do Contrato"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">        			
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_contrato.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}','divbusca');">(+) Incluir Contrato</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />