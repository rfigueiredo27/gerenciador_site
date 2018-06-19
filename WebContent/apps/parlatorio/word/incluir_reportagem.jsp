  <script>
function atualizaTelaReportagem()
{
	document.fincReportagem.reset();
	limpaProgress2();
}


function criticaReportagem()
{
	var vteste = document.getElementById('mytextarea');
	alert(vteste.value);
	critica_inclusao_reportagem(document.fincReportagem);
}

$(document).ready(function(){
});


</script>
<%
vsecao = "";
%>

<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens</legend>
<form name="fincReportagem" action="/gecoi.3.0/apps/parlatorio/processa_incluir_reportagem.jsp" method="post" target="rodape" enctype="multipart/form-data">
<div id="edicao_reportagem">
    		<fieldset>
                <legend>Edi&ccedil;&atilde;o do Parlat&oacute;rio</legend>
				<input title="Edi&ccedil;&atilde;o do Parlat&oacute;rio" alt="Edi&ccedil;&atilde;o do Parlat&oacute;rio" type="text" name="edicaoReportagem" id="edicaoReportagem" />
        	</fieldset>
	    </div>
<div id="secao_reportagem">
	<fieldset>
    	<legend>Se&ccedil;&otilde;es</legend>
       	<select name="secaoReportagem" id="secaoReportagem">
			<option value="0">-----------</option>
            <%@include file="secoes.jsp"%>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataReportagem" id="dataReportagem" size="10" maxlength="10"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloReportagem" id="tituloReportagem" />
        	</fieldset>
	    </div>
<div id="subtitulo_reportagem">
    		<fieldset>
                <legend>Subt&iacute;tulo</legend>
				<input title="Subt&iacute;tulo da Reportagem" alt="Subt&iacute;tulo da Reportagem" type="text" name="subtituloReportagem" id="subtituloReportagem" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selecione a imagem da TV</legend>
            <input name="tv" type="file" id="tv" onchange="">
        	<div id="campoArquivo2"></div>
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
        <div id="editar_arquivo">
      		<fieldset>
        	<legend>Editar Reportagem</legend>
        	<div id="IncluirHtmlReportagem">
            <textarea name="mytextarea" id="mytextarea" ></textarea>
            </div>
            <input name="image" type="file" id="upload" class="hidden" onchange="">
   		  </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaReportagem();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaReportagem();"  />
      </div>
</form>
</fieldset>
</div>
<div id="teste"></div>
<!--<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> -->
