<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>
	
<script>

function atualizaTela()
{
	//parent.tb_remove();
	//carregaPag("/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=" + document.fanexo.idLicitacao.value + "&nProcesso=" + document.fanexo.nProcesso.value + "&nPregao=" + document.fanexo.nPregao.value, "divbusca");
}



function excluirAnexo(vidConteudo, plicitacao, pnProcesso, pnPregao)
{
	if (confirm("Deseja realmente excluir a ata ?") == true)
		$.post("/gecoi.3.0/apps/registro_preco/seccon/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
%>
<h1>Lista de Atas de Registro de Pre&ccedil;os</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.registroPreco.seccon.ListaRegistro" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="items" value="${lista.getListaReferencia(idLicitacao, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fanexo" action="/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td>
        			Nº do Pregão:
        			<input type="text" name="nPregao" id="nPregao" value="<%=vnumPregao %>" readonly="readonly" />
        		</td>
      		</tr>
      		<tr>
        		<td>
        			Nº do Processo:
        			<input type="text" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        		</td>
      		</tr>
			<tr>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>PUBLICA&Ccedil;&Atilde;O</th>
				<th>VIG&Ecirc;NCIA</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.numAta } - ${anexo.descricao }
        			</td>
        			<td>
        				${anexo.dataPublicacao }
        			</td>
        			<td>
        				${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&keepThis=true&TB_iframe=true&height=350&width=800" class="thickbox" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" target="_blank" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=${anexo.descricao }','divbusca');" title="Substitui&ccedil;&atilde;o da Ata"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/alterar_dados_ata.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&numAta=${anexo.numAta }','divbusca');" title="Alterar dados da Ata"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				<a href="#" onclick="excluirAnexo(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}');" title="Exclusão da Ata"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
     			<tr>
        			<td height="40" align="right" valign="middle">        			
        				<!-- <a href="/gecoi.3.0/apps/registro_preco/seccon/incluir_anexo.jsp?idConteudo=${idConteudo}&nProcesso=${numProcesso}&idArquivo=${idArquivo}&nPregao=${numPregao}">(+) Incluir Ata</a> -->
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/incluir_anexo.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}','divbusca');">(+) Incluir Ata</a>
        			</td>
      			</tr>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
