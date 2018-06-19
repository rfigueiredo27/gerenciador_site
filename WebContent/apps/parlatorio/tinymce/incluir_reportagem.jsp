<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>-->
<link href="/gecoi.3.0/scripts/summernote/summernote.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/summernote/summernote.js"></script>

  <script>
function atualizaTelaReportagem()
{
	document.fincReportagem.reset();
	limpaProgress2();
}


function criticaReportagem()
{
	critica_inclusao_reportagem(document.fincReportagem);
}

$(document).ready(function(){
	$('#summernote').summernote({
		height: 400,
		disableResize: true,
		placeholder: "Escreva aqui...",
		//airMode: true,
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    ['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
			['insert', ['link', 'picture', 'video']],
		    ['imagesize', ['imageSize100', 'imageSize50', 'imageSize25']],
		    //['float', ['floatLeft', 'floatRight', 'floatNone']],
		    ['remove', ['removeMedia']],
			['table', ['table']]
		]
  	});
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
                <legend>Edi&ccedil;&atilde;o</legend>
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
<div id="data_reportagem">
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
            <div id="IncluirHtmlReportagem">Digite a reportagem</div>
            <textarea name="vtexto" id="vtexto" ></textarea>
   			 
        	<!--<div id="IncluirHtmlReportagem">
            <textarea name="mytextarea" id="mytextarea" ></textarea>
            </div>-->
   		  </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaReportagem();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaReportagem();"  />
      </div>
</form>
</fieldset>
</div>

<!--<div id="summernote">Digite a reportagem</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> -->
