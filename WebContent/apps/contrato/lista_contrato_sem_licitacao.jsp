<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>


function excluirAnexo(vnContrato, vidConteudo, vidArquivo)
{
	if (confirm("Deseja realmente excluir o contrato " + vnContrato + " e seus aditivos ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao_sem_licitacao.jsp", {idConteudo : vidConteudo, idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");zera_contador();});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vano = request.getParameter("ano");
String vchave = request.getParameter("texto");
String vtipo = request.getParameter("tipo");
String vcor       = "#ECECEC";  // zebra a tabela
%>
<h1>Lista de Contratos</h1>
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="chave" value="<%=vchave %>" scope="page" />
<c:set var="tipo" value="<%=vtipo %>" scope="page" /> 
<c:set var="items" value="${lista.getListaContratosSemLicitacao(ano, chave, tipo, sessionScope['login'], sessionScope['senha'])}" />
		<form name="fcontratosem" action="">
			<table id="tb_gecoi"><thead>
					<tr>
				<th scope="col" width="10%">TIPO</th>
				<th scope="col" width="6%">CONTRATO</th>
				<th scope="col" width="6%">PROCESSO</th>
				<th scope="col" width="30%">DESCRI&Ccedil;&Atilde;O</th>
				<th scope="col" width="8%">PUBLICA&Ccedil;&Atilde;O</th>
				<th scope="col" width="14%">VIG&Ecirc;NCIA</th>
				<th scope="col" width="10%">OBSERVA&Ccedil;&Atilde;O</th>
				<th scope="col" colspan="8" width="20%">A&Ccedil;&Atilde;O</th>
			</tr>
			<c:forEach var="anexo" items="${items}" >
<!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			    <tr bgcolor=<%=vcor%> >
        			<td align="center" width="10%">${anexo.tipo }</td>
        			<td align="center" width="6%">${anexo.nContrato }</td>	
        			<td align="center" width="6%">${anexo.nProcesso }</td>
        			<td align="left" width="30%">${anexo.descricaoContrato }</td>
        			<td align="center" width="8%">${anexo.dataPublicacao }</td>	
        			<td align="center" width="14%">${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }</td>
        			<td align="left" width="10%">${anexo.observacao }</td>
        			<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo_sem_licitacao.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&nProcesso=${anexo.nProcesso}&nContrato=${anexo.nContrato}&titulo=Contrato&origem=principal','divbusca2');" title="Substitui&ccedil;&atilde;o do Contrato"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_contrato_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&nContrato=${anexo.nContrato}&observacao=${anexo.observacao }','divbusca2');" title="Alterar dados do Contrato"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.nProcesso}&nContrato=${anexo.nContrato}&dataPublicacao=${anexo.dataPublicacao}&idArea=${anexo.idArea }','divbusca2');" title="Aditivos"><img width="22" height="22" src="/gecoi.3.0/img/texto.jpg" /></a></td>
           			<td width="2%"><a href="#" onclick="excluirAnexo('${anexo.nContrato }', ${anexo.idConteudo }, ${anexo.idArquivo });" title="Exclusão do Contrato"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a></td>
        			
      			</tr>
			</c:forEach>
		</table>
	</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
