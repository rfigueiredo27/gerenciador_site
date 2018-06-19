<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
<script>

function atualizaTela()
{
	/*parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + document.fanexo.idLicitacao.value + "&nProcesso=" + document.fanexo.nProcesso.value + 
				"&nPregao=" + document.fanexo.nPregao.value + "&descricao=" + document.fanexo.descricaoContrato.value + "&idConteudo=" + document.fanexo.idConteudo.value + 
				"&nContrato=" + document.fanexo.nContrato.value + "&dataPublicacao="  + document.fanexo.dataPublicacao.value, "divbusca");
	*/
}


function excluirAnexo(vid)
{
	if (confirm("Deseja realmente excluir o contrato/aditivo ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao_aditivo.jsp", {idArquivo : vid}, 
				function(){top.listar();document.fanexo.submit()});
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
<c:set var="items" value="${lista.getListaAditivos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fanexo" action="/gecoi.3.0/apps/contrato/alterar_anexo.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
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
        				${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=<%=vdescricao%>&titulo=Aditivo&origem=anexo','divbusca');" title="Substitui&ccedil;&atilde;o do Aditivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_aditivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>','divbusca');" title="Alterar dados do Aditivo"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				<a href="#" onclick="excluirAnexo(${anexo.idArquivo });" title="Exclusão do Aditivo"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">        			
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_aditivo.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>','divbusca');">(+) Incluir Aditivo</a>
        				<br>
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_anexo.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnumPregao %>&nProcesso=<%=vnumProcesso %>','divbusca');">Voltar a lista de contratos</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
