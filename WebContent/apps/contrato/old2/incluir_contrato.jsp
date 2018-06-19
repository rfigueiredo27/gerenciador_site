<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	//parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + "&nPregao=" + document.fincAnexo.numPregao.value, "divbusca");
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


</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
%>
<h1>Inclus&atilde;o de Contratos</h1>
<form name="fincAnexo" action="/gecoi.3.0/IncluirContrato" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidLicitacao%>"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Número do Processo:</td>
        <td>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        </td>
      </tr>
	 <tr><td>Nº do Contrato / Ano do Contrato</td>
        <td>
			<input type="text" name="numContrato" id="numContrato"  maxlength="9"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2"/>
        </td>
      </tr>
      <tr><td>Vigência</td>
        <td >
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni" id="vigenciaIni" size="10" maxlength="10"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim" id="vigenciaFim" size="10" maxlength="10" " />
        </td>
      </tr>
      <tr><td>Descri&ccedil;&atilde;o</td>
        <td>
   			<textarea title="Descri&ccedil;&atilde;o do contrato" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
   			<span id="contadorDescricao" class="alert"></span>
        </td>
      </tr>
      <tr><td>Data de Publica&ccedil;&atilde;o</td>
        <td >
			<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" " />
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
  <input type="hidden" name="numPregao" id="numPregao" value="<%=vnumPregao %>"/>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
