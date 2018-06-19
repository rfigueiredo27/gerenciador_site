<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>

function atualizaTelaContrato()
{
	if (document.fbusca2.tipo[0].checked)
		ptipo = "todos";
	else
		if (document.fbusca2.tipo[1].checked)
			ptipo = "adesao";
		if (document.fbusca2.tipo[2].checked)
			ptipo = "direta";
	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + ptipo, "divbusca2");
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
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="outros" value=""></c:set>
<c:set var="items" value="${lista.getListaAditivos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
<div id="altera_ata">
	<fieldset>
		<legend>Lista de Aditivos</legend>
		<form name="fanexo" action="">
			<input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
			<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" />
			<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>" />
			<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
			<input type="hidden" name="idArea" id="idArea" value="<%=vidArea %>" />
            <input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" />
            
        <div id="numero">
           <div id="descricao_arquivo">
        			<p>Descri&ccedil;&atilde;o do Contrato: <strong><%=vnContrato %> - <%=vdescricao %></strong></p>
				</div>
				<div id="numero_processo">
        			<p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso%></strong></p>
				</div>
            </div>
            
			 <table id="tb_gecoi">
             	<tr><thead>
					<th scope="col" width="45%">DESCRI&Ccedil;&Atilde;O</th>
					<th scope="col" width="13%">VIG&Ecirc;NCIA</th>
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
        			<td align="left">${anexo.descricao }</td>
        			<td align="center">
        				<c:if test="${((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					-
        				</c:if>
        				<c:if test="${!((anexo.dataVigenciaInicial == '-') && (anexo.dataVigenciaFinal == '-'))}">
        					${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }
        				</c:if>
        			</td>
        			<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo_sem_licitacao.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=<%=vdescricao%>&nProcesso=${numProcesso}&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao%>&idArea=<%=vidArea %>&titulo=Aditivo&origem=anexo','divbusca2');" title="Substitui&ccedil;&atilde;o do Aditivo/Termo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
           				<c:if test="${anexo.tipo == 'aditivo' }">           				
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_aditivo_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataVigenciaInicial=${anexo.dataVigenciaInicial }&dataVigenciaFinal=${anexo.dataVigenciaFinal }&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>&termo=${anexo.nTermo }','divbusca2');" title="Alterar dados do Aditivo"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
           				</c:if>
           				<c:if test="${anexo.tipo == 'rescisao' }">	
           		  <td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_rescisao.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&descTermo=${anexo.descricao }','divbusca');" title="Alterar dados da Rescis&atilde;o"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>	
           				</c:if>	
           				<c:if test="${anexo.tipo == 'outros' }">
           				<td width="2%">	<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_outros_termos_sem_licitacao.jsp?id=${anexo.idArquivo }&descricao=<%=vdescricao %>&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nContrato=<%=vnContrato %>&ordem=${anexo.ordem}&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>&descTermo=${anexo.descricao }','divbusca2');" title="Alterar dados do Termo"><img src="/gecoi.3.0/img/editar_cinza.png" width="22" height="22" /></a></td>
           				</c:if>
           				<td width="2%"><a href="#" onclick="excluirAnexo(${anexo.idArquivo }, '${anexo.descricao }');" title="Exclusão do Aditivo/Termos"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"/></a></td>
        			
        			<c:if test="${anexo.tipo == 'aditivo' }">
        				<c:set var="outros" value="${outros}_${anexo.descricao }"></c:set>
        			</c:if>
      			</tr>
			</c:forEach>
            </table>
	       </form>
     			<div id="anexo">
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_aditivo_sem_licitacao.jsp?nProcesso=${numProcesso}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>','divbusca2');">(+) Incluir Aditivo</a>
        		</div>
                <div id="anexo">
        				<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_rescisao_sem_licitacao.jsp?nProcesso=${numProcesso}&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao %>&idArea=<%=vidArea %>&outros=${outros }','divbusca2');">(+) Incluir Rescis&atilde;o</a>
        		</div>
                <div id="botao">
        		 
                  <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaContrato();"/>
                  </div>
   </fieldset>
</div>		
		
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
