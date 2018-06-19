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
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="outros" value=""></c:set>
<c:set var="items" value="${lista.getListaAditivos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
<div id="altera_ata">
	<fieldset>
		<legend>Lista de Aditivos</legend>
		<form name="faditivo" action="">
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
			<input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
			<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" />
			<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>" />
			<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
            <input type="hidden" name="nPregao" id="nPregao" value="<%=vnumPregao %>" />
            <input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" />
           <div id="numero">
           <div id="descricao_arquivo">
        			<p>Descri&ccedil;&atilde;o do Contrato: <strong><%=vnContrato %> - <%=vdescricao %></strong></p>
				</div>
				<div id="numero_processo">
        			<p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso%></strong></p>
				</div>
    			<div id="numero_pregao">
     				<p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnumPregao%></strong></p>
				</div>
            </div>
            <div id="anexo_tabela">
			 <table id="tb_gecoi">
				<tr><thead>
				<th scope="col" width="45%">DESCRI&Ccedil;&Atilde;O</th>
				<th scope="col" width="13%">VIG&Ecirc;NCIA</th>
				<th scope="col" colspan="8" width="20%">A&Ccedil;&Atilde;O</th>
			</tr></thead>
			<c:forEach var="anexo" items="${items}" >
           <!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>

      			<tr  bgcolor=<%=vcor%> >
      				<td align="left">${anexo.descricao }</td>
        			<td align="center">	
        				<c:if test="${((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					-
        				</c:if>
        				<c:if test="${!((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        				</c:if>
        			</td>
        			<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" target="_blank" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=<%=vdescricao%>&titulo=Aditivo&origem=anexo','divbusca');" title="Substitui&ccedil;&atilde;o do Aditivo/Termo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a>
           			<c:if test="${anexo.tipo == 'aditivo' }">
           				<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_aditivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&termo=${anexo.nTermo }','divbusca');" title="Alterar dados do Aditivo"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>	
           			</c:if>
           			<c:if test="${anexo.tipo == 'rescisao' }">	
           				<td width="2%"></td>	
           			</c:if>	
           			<c:if test="${anexo.tipo == 'outros' }">	
           				<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_outros_termos.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&descTermo=${anexo.descricao }','divbusca');" title="Alterar dados do Termo"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>	
           			</c:if>	
           			<td width="2%"><a href="#" onclick="excluirAnexo(${anexo.idArquivo }, '${anexo.descricao }');" title="Exclusão do Aditivo"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"/></a></td>	
           			<c:if test="${anexo.tipo == 'aditivo' }">
        				<c:set var="outros" value="${outros}_${anexo.descricao }"></c:set>
        			</c:if>
        	    </tr>	
        	</c:forEach>
            </table>
            </form>
            <div id="anexo"> 		
      			<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_aditivo.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>','divbusca');">(+) Incluir Aditivo</a>        				
        	</div>
        	<div id="anexo"> 
                    <a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_rescisao.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&outros=${outros }','divbusca');">(+) Incluir Rescis&atilde;o</a>
        	</div>			
            
            <div id="botao">
 				<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnumPregao %>&nProcesso=<%=vnumProcesso %>','divbusca');" />
			</div>
	</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
