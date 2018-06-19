<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script>

function atualizaTela()
{
	document.fincFundo.reset();
}


function criticaFundo()
{
	critica_inclusao_fundo(document.fincFundo);
}

$(document).ready(function(){
});


</script>
<%
// vid_conteudo =  135945;
vsecao = "";
%>

<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens	do Tipo Fundo do Ba&uacute;</legend>
	<form name="fincFundo" action="/gecoi.3.0/apps/parlatorio/processa_incluir_fundo.jsp" method="post" target="rodape" enctype="multipart/form-data">
<div id="edicao_reportagem">
    		<fieldset>
                <legend>Edi&ccedil;&atilde;o do Parlat&oacute;rio</legend>
				<input title="Edi&ccedil;&atilde;o do Parlat&oacute;rio" alt="Edi&ccedil;&atilde;o do Parlat&oacute;rio" type="text" name="edicaoFundo" id="edicaoFundo" />
        	</fieldset>
	    </div>
<div id="secao_reportagem">
	<fieldset>
    	<legend>Se&ccedil;&otilde;es</legend>
       	<select name="secao" id="secao">
			<option value="0">-----------</option>
            <%@include file="secoes.jsp"%>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataFundo" id="dataFundo" size="10" maxlength="10"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloFundo" id="tituloFundo" />
        	</fieldset>
	    </div>
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="" height="100" width="100" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selecione a imagem do banner</legend>
            <input name="banner" type="file" id="banner" onchange="">
        	<!--<div id="campoArquivo"></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>-->
   		  </fieldset>
      </div>
        <div id="editar_arquivo">
      		<fieldset>
        	<legend>Editar Fundo</legend>
            <div id="IncluirHtmlFundo">
        	<textarea name="mytextarea" id="mytextarea" ></textarea>
            </div>
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	<div id="campoArquivo"></div>
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
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaFundo();"  />
      </div>
</form>
</fieldset>
</div>
<div id="teste"></div>
<!--<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> -->
