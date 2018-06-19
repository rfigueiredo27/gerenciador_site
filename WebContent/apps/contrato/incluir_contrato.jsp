<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>


<script>
function atualizaTela()
{
	//parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + "&nPregao=" + document.fincAnexo.numPregao.value + "&descricao=" + document.fincAnexo.descricao.value, "divbusca");
}


function criticaAnexo()
{
	critica_inclusao_contrato(document.fincAnexo);
	//document.fincAnexo.submit();
	//startProgress();
	//parent.tb_remove();
}

$(document).ready(function(){
	$( "#vigenciaIni" ).datepicker();
	$( "#vigenciaFim" ).datepicker();
	$( "#dataPublicacao" ).datepicker();
});

function poeZero()
{
	var numero = parseInt(document.fincAnexo.numContrato.value);
	//document.fincAnexo.numContrato.value = String.format("%03d", numero);
	if (numero < 10)
	{
		document.fincAnexo.numContrato.value = "0" + numero;
	}
}


</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
String vdescricaoLicitacao = request.getParameter("descricao");

	Calendar c = Calendar.getInstance();
	String vano = ("" + c.get(Calendar.YEAR)).substring(2);
%>

<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Contratos</legend>
<form name="fincAnexo" action="/gecoi.3.0/IncluirContrato" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidLicitacao%>"/>
<input type="hidden" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricaoLicitacao %>"/>

<div id="numero">
    <div id="descricao_arquivo">
        <p>Descri&ccedil;&atilde;o: <strong><%=vdescricaoLicitacao%></strong></p>
	</div>
    <div id="descricao_arquivo">
      <p>N&uacute;mero do processo: <strong><%=vnumProcesso %></strong></p>
	</div>
</div>
<div id="numero_ata">
       <fieldset>
       	  <legend>N&uacute;mero / Ano</legend>
			<input type="text" name="numContrato" id="numContrato"  maxlength="3" onblur="poeZero();"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2" onfocus="this.value='<%=vano%>'" />
       </fieldset>
</div>
<div id="data_contrato">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10"/>
        	</fieldset>
	    </div>
      <div id="vigencia_anexo">
    		<fieldset>
                <legend>Vigência</legend>
				<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni" id="vigenciaIni" size="10" maxlength="10"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim" id="vigenciaFim" size="10" maxlength="10"/>
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
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
      </div>
  <input type="hidden" name="numPregao" id="numPregao" value="<%=vnumPregao %>"/>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
