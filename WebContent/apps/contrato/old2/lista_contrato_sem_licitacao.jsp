<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>


function excluirAnexo(vnContrato, vidConteudo, vidArquivo)
{
	if (confirm("Deseja realmente excluir o contrato " + vnContrato + " e seus aditivos ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao_sem_licitacao.jsp", {idConteudo : vidConteudo, idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vano = request.getParameter("ano");
String vchave = request.getParameter("texto");
String vtipo = request.getParameter("tipo");
%>
<h1>Lista de Contratos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="chave" value="<%=vchave %>" scope="page" />
<c:set var="tipo" value="<%=vtipo %>" scope="page" /> 
<c:set var="items" value="${lista.getListaContratosSemLicitacao(ano, chave, tipo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fcontratosem" action="">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<th>TIPO</th>
				<th>CONTRATO</th>
				<th>PROCESSO</th>
				<th>DESCRI&Ccedil;&Atilde;O</th>
				<th>PUBLICA&Ccedil;&Atilde;O</th>
				<th>VIG&Ecirc;NCIA</th>
				<th>OBSERVA&Ccedil;&Atilde;O</th>
				<th>A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
      			<tr>
        			<td>
        				${anexo.tipo }
        			</td>
        			<td>
        				${anexo.nContrato }
        			</td>
        			<td>
        				${anexo.nProcesso }
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
        				${anexo.observacao }
        			</td>
        			<td>
           				<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/visualizar.gif" onclick="" width="30" height="30" target="_blank" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo_sem_licitacao.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&nProcesso=${anexo.nProcesso}&nContrato=${anexo.nContrato}&titulo=Contrato&origem=principal','divbusca2');" title="Substitui&ccedil;&atilde;o do Contrato"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/substituir.gif" onclick="" width="30" height="30" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_contrato_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&nContrato=${anexo.nContrato}&observacao=${anexo.observacao }','divbusca2');" title="Alterar dados do Contrato"><img width="20" height="20" src="/gecoi.3.0/img/alterar.gif" /></a>
           				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&nContrato=${anexo.nContrato}&dataPublicacao=${anexo.dataPublicacao}&idArea=${anexo.idArea }','divbusca2');" title="Aditivos"><img width="20" height="20" src="/gecoi.3.0/img/texto.jpg" /></a>
           				<a href="#" onclick="excluirAnexo('${anexo.nContrato }', ${anexo.idConteudo }, ${anexo.idArquivo });" title="Exclusão do Contrato"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>
        			</td>
      			</tr>
			</c:forEach>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
