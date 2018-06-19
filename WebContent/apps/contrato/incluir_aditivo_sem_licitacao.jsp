<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   
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
<input type="hidden" name="termo" id="termo" value="${termo }"/>
<c:set var="ordem" value="${lista.getOrdem(idConteudo, sessionScope['login'], sessionScope['senha'])}" />


<c:set var="idConteudo" value="<%=vidConteudo %>" />
<c:set var="ordem" value="${lista.getOrdem(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<div id="numero">
	<div id="descricao_arquivo">
    	<p>Termo aditivo nº:<strong>${termo }</strong></p>
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
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni6" id="vigenciaIni6" size="10" maxlength="10"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim6" id="vigenciaFim6" size="10" maxlength="10"  />
        </fieldset>
      </div>
      <div id="incluir_arquivo_sem_licitacao">
      	<fieldset>
        <legend>Incluir Arquivo</legend>
        	<div id="campoArquivo2"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar2" style="display: none;">
				<div id="theMeter2">
            		<div id="progressBarText2"></div>
                	<div id="progressBarBox2">
                		<div id="progressBarBoxContent2"></div>
               		</div>
            	</div>
         	</div>
       	</fieldset>
     </div>
		<div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
        </div>
  <input type="hidden" name="ordem" id="ordem" value="${ordem }" />
  <input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
  <input type="hidden" name="nContrato" id="nContrato" value="<%=vcontrato %>" />
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
  <input type="hidden" name="idArea" id="idArea" value="<%=vidArea %>" />
</form>
</fieldset>
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
