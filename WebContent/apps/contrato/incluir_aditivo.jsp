<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
   
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
   
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + document.fincAnexo.idLicitacao.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + 
				"&nPregao=" + document.fincAnexo.numPregao.value + "&descricao=" + document.fincAnexo.descricaoContrato.value + "&idConteudo=" + document.fincAnexo.idConteudo.value + 
				"&nContrato=" + document.fincAnexo.nContrato.value + "&dataPublicacao="  + document.fincAnexo.dataPublicacao.value, "divbusca");
	
}


function criticaAnexo()
{
	
	critica_inclusao_aditivo(document.fincAnexo);
}

$(document).ready(function(){
	$( "#vigenciaIni4" ).datepicker();
	$( "#vigenciaFim4" ).datepicker();
});


</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
String vcontrato = request.getParameter("nContrato");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("dataPublicacao");

%>
<div id="altera_arquivo">
<fieldset>
	<legend>Inclus&atilde;o de Aditivos</legend>

<form name="fincAnexo" action="/gecoi.3.0/IncluirAditivo" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>"/>
<input type="hidden" name="contrato" id="contrato" value="<%=vcontrato %>"/>
<c:set var="idConteudo" value="<%=vidConteudo %>" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="termo" value="${lista.getTermo(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" />
<c:set var="ordem" value="${lista.getOrdem(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
		<div id="numero">
        	<div id="descricao_arquivo">
        		<p>Termo aditivo nº:<input type="text" name="termo" id="termo" value="${termo }"/></p>
			</div>
            <div id="numero_pregao">
     				<p>N&uacute;mero Contrato: <br /><strong><%=vcontrato%></strong></p>
				</div>
				<div id="numero_processo">
        			<p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso%></strong></p>
				</div>
            </div>
      
        <div id="vigencia_aditivo">
    		<fieldset>
                <legend>Vigência</legend>
				<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni4" id="vigenciaIni4" size="10" maxlength="10" /> a 
                <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim4" id="vigenciaFim4" size="10" maxlength="10"/>
            </fieldset>
        </div>
	  
      <div id="incluir_arquivo">
      	<fieldset>
        	<legend>Incluir Arquivo</legend>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
       	</fieldset>
     </div>
		<div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="parent.atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
        </div>
        
  <input type="hidden" name="ordem" id="ordem" value="${ordem }" />
  <input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
  <input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
  <input type="hidden" name="nContrato" id="nContrato" value="<%=vcontrato %>" />
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
  <input type="hidden" name="numPregao" id="numPregao" value="<%=vnumPregao %>" />
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
