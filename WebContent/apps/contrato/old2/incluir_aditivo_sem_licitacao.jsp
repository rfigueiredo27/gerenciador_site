<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
   
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
   
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>

function atualizaTela()
{

	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?nProcesso=" + document.fincAnexo.numProcesso.value + "&idArea=" + document.fincAnexo.idArea.value +
				"&descricao=" + document.fincAnexo.descricaoContrato.value + "&idConteudo=" + document.fincAnexo.idConteudo.value + 
				"&nContrato=" + document.fincAnexo.nContrato.value + "&dataPublicacao=" + document.fincAnexo.dataPublicacao.value, "divbusca2");

}


function criticaAnexo()
{
	critica_inclusao_aditivo_sem_licitacao(document.fincAnexo);
}

$(document).ready(function(){
	$( "#vigenciaIni6" ).datepicker();
	$( "#vigenciaFim6" ).datepicker();
});


</script>
<%
String vnumProcesso = request.getParameter("nProcesso");
String vcontrato = request.getParameter("nContrato");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("dataPublicacao");
String vidArea = request.getParameter("idArea");

%>
<h1>Inclus&atilde;o de Aditivos</h1>
<form name="fincAnexo" action="/gecoi.3.0/IncluirAditivo" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>

<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idConteudo" value="<%=vidConteudo %>" />
<c:set var="ordem" value="${lista.getOrdem(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Número do Processo:</td>
        <td>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        </td>
      </tr>
	 <tr><td>Contrato</td>
        <td>
        	<input type="text" name="contrato" id="contrato" value="<%=vcontrato %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
      	<td>Termo aditivo nº </td>
        <td>
        	<div id="divordem">
        		<input type="text" name="ordem" id="ordem" value="${ordem }" readonly="readonly" />
        	</div>
        </td>
      </tr>
      <tr><td>Vigência</td>
        <td >
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni6" id="vigenciaIni6" size="10" maxlength="10"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim6" id="vigenciaFim6" size="10" maxlength="10" " />
        </td>
      </tr>
      <tr>
        <td>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
        </td>
      </tr>
  </table>
  <input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
  <input type="hidden" name="nContrato" id="nContrato" value="<%=vcontrato %>" />
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
  <input type="hidden" name="idArea" id="idArea" value="<%=vidArea %>" />
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
