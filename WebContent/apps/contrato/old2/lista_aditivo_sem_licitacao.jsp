<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>

function atualizaTelaContrato()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");
}

function atualizaTela()
{
//	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?nProcesso=" + document.fanexo.nProcesso.value + "&idArea=" + document.fanexo.idArea.value +
			"&descricao=" + document.fanexo.descricaoContrato.value + "&idConteudo=" + document.fanexo.idConteudo.value + 
			"&nContrato=" + document.fanexo.nContrato.value + "&dataPublicacao=" + document.fanexo.dataPublicacao.value, "divbusca2");
}


function excluirAnexo(vid, vdescricao)
{
	//if (confirm("Deseja realmente excluir o Termo aditivo nº " + vOrdem + " ?") == true)
	if (confirm("Deseja realmente excluir o aditivo/termo " + vdescricao + " ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao_aditivo.jsp", {idArquivo : vid}, 
				function(){atualizaTela();});
}
</script>
<%
String vnumProcesso = request.getParameter("nProcesso");
String vidConteudo = request.getParameter("idConteudo");
String vnContrato = request.getParameter("nContrato");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("dataPublicacao");
String vidArea = request.getParameter("idArea");

%>
<h1>Lista de Aditivos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="outros" value=""></c:set>
<c:set var="items" value="${lista.getListaAditivos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fanexo" action="">
			<input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
			<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" />
			<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>" />
			<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
			<input type="hidden" name="idArea" id="idArea" value="<%=vidArea %>" />
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo_sem_licitacao.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=<%=vdescricao%>&nProcesso=${numProcesso}&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao%>&idArea=<%=vidArea %>&titulo=Aditivo&origem=anexo','divbusca2');" title="Substitui&ccedil;&atilde;o do Aditivo/Termo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<c:if test="${anexo.tipo == 'aditivo' }">           				
           					<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_aditivo_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataVigenciaInicial=${anexo.dataVigenciaInicial }&dataVigenciaFinal=${anexo.dataVigenciaFinal }&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>','divbusca2');" title="Alterar dados do Aditivo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				</c:if>
           				<c:if test="${anexo.tipo == 'outros' }">
           					<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_outros_termos_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>&descTermo=${anexo.descricao }','divbusca2');" title="Alterar dados do Termo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				</c:if>
           				<a href="#" onclick="excluirAnexo(${anexo.idArquivo }, '${anexo.descricao }');" title="Exclusão do Aditivo/Termos"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
        			<c:if test="${anexo.tipo == 'aditivo' }">
        				<c:set var="outros" value="${outros}_${anexo.descricao }"></c:set>
        			</c:if>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_aditivo_sem_licitacao.jsp?nProcesso=${numProcesso}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>','divbusca2');">(+) Incluir Aditivo</a>
        				<br>
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_outros_termos_sem_licitacao.jsp?nProcesso=${numProcesso}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>&outros=${outros }','divbusca2');">(+) Incluir Outros Termos</a>
        				<br>
        				<a href="#" onclick="atualizaTelaContrato();">Voltar a lista de contratos</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
