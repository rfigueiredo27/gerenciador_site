<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + document.faditivo.idLicitacao.value + "&descricao=" + document.faditivo.descricaoContrato.value + "&idConteudo=" + document.faditivo.idConteudo.value + "&nProcesso=" + document.faditivo.nProcesso.value + "&nPregao=" + document.faditivo.nPregao.value + "&nContrato=" + document.faditivo.nContrato.value + "&dataPublicacao=" + document.faditivo.dataPublicacao.value, "divbusca");
}

function excluirAnexo(vid, vdescricao)
{
	//if (confirm("Deseja realmente excluir o Termo Aditivo nº " + vordem  + " ?") == true)
	if (confirm("Deseja realmente excluir o aditivo/termo " + vdescricao + " ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao_aditivo.jsp", {idArquivo : vid}, 
				function(){atualizaTela();});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vidConteudo = request.getParameter("idConteudo");
String vnContrato = request.getParameter("nContrato");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("dataPublicacao");

%>
<h1>Lista de Aditivos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="outros" value=""></c:set>
<c:set var="items" value="${lista.getListaAditivos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="faditivo" action="">
			<input type="text" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
			<input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
			<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" />
			<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>" />
			<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
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
        		<td>
        			Contrato: <input type="text" name="contrato" id="contrato" value="<%=vnContrato %> - <%=vdescricao %>" readonly="readonly" />
        		</td>
      		</tr>
			<tr>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>VIG&Ecirc;NCIA</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.descricao }
        			</td>
        			<td>
        				<c:if test="${((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					-
        				</c:if>
        				<c:if test="${!((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        				</c:if>
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=<%=vdescricao%>&titulo=Aditivo&origem=anexo','divbusca');" title="Substitui&ccedil;&atilde;o do Aditivo/Termo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<c:if test="${anexo.tipo == 'aditivo' }">
           					<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_aditivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>','divbusca');" title="Alterar dados do Aditivo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				</c:if>
           				<c:if test="${anexo.tipo == 'outros' }">
           					<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_outros_termos.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&descTermo=${anexo.descricao }','divbusca');" title="Alterar dados do Termo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				</c:if>
           				<a href="#" onclick="excluirAnexo(${anexo.idArquivo }, '${anexo.descricao }');" title="Exclusão do Aditivo"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
        			<c:if test="${anexo.tipo == 'aditivo' }">
        				<c:set var="outros" value="${outros}_${anexo.descricao }"></c:set>
        			</c:if>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">        			
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_aditivo.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>','divbusca');">(+) Incluir Aditivo</a>
        				<br>
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_outros_termos.jsp?nProcesso=${numProcesso}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&outros=${outros }','divbusca');">(+) Incluir Outros Termos</a>
        				<br>
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnumPregao %>&nProcesso=<%=vnumProcesso %>','divbusca');">Voltar a lista de contratos</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
