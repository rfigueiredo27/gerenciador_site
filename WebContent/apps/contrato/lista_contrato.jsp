<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>

function excluirAnexo(vidConteudo, plicitacao, pnProcesso, pnPregao, pcontrato)
{
	if (confirm("Deseja realmente excluir o contrato " + pcontrato + " e seus aditivos ?") == true)
		$.post("/gecoi.3.0/apps/contrato/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");zera_contador();});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vdescricaoLicitacao = request.getParameter("descricao");
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="items" value="${lista.getListaReferencia(idLicitacao, sessionScope['login'], sessionScope['senha'])}" />
<div id="altera_ata">
	<fieldset>
		<legend>Lista de Contratos</legend>
		<form name="fcontrato" action="/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
            
            <div id="numero">
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
					<th scope="col" width="4%" align="center">CONTRATO</th>
					<th scope="col" width="45%">DESCRI&Ccedil;&Atilde;O</th>
					<th scope="col" width="6%" align="center">PUBLICA&Ccedil;&Atilde;O</th>
					<th scope="col" width="10%" align="center">VIG&Ecirc;NCIA</th>
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
 					<td>${anexo.nContrato }</td>
        			<td>${anexo.descricaoContrato }</td>	
        			<td>${anexo.dataPublicacao }</td>
        			<td>${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }</td>
        			<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" target="_blank"/></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=${anexo.descricaoContrato }&nContrato=${anexo.nContrato}&titulo=Contrato&origem=principal','divbusca');" title="Substitui&ccedil;&atilde;o do Contrato"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22"/></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/alterar_dados_contrato.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&nContrato=${anexo.nContrato}','divbusca');" title="Alterar dados do Contrato"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22"/></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=${idLicitacao }&descricao=${anexo.descricaoContrato }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&nContrato=${anexo.nContrato}&dataPublicacao=${anexo.dataPublicacao }','divbusca');" title="Aditivos"><img width="20" height="20" src="/gecoi.3.0/img/texto.jpg" /></a></td>
           			<td width="2%"><a href="#" onclick="excluirAnexo(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}', '${anexo.nContrato }');" title="Exclusão do Contrato"><img src="/gecoi.3.0/img/excluir_cinza.png" onclick="" width="22" height="22"/></a></td>
      		  </tr>
			</c:forEach>
            </table>
     		  <div id="anexo">   		       			
        		<a href="#" onclick="carregaPag('/gecoi.3.0/apps/contrato/incluir_contrato.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&descricao=<%=vdescricaoLicitacao %>','divbusca');">(+) Incluir Contrato</a>
        	  </div>
        </div>
		
	</form>
    <div id="botao">
 
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
</div>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>