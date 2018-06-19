<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script>

function atualizaTela()
{
	document.fincparlatorio.reset();
	limpaProgress();
}


function criticaParlatorio()
{
	critica_inclusao_parlatorio(document.fincparlatorio);
}

$(document).ready(function(){
});

</script>

    <form name="fincparlatorio" action="/gecoi.3.0/apps/parlatorio/processa_incluir_parlatorio.jsp" method="post" target="rodape" enctype="multipart/form-data">
        <div id="edicao_pdf">
      		<fieldset>
        	<legend>Edi&ccedil;&atilde;o</legend>
    		<input type="text" name="edicao" id="edicao" value="" onkeyup="SoNumero(event, this)" />
            </fieldset>
        </div>
        <div id="data_publicacao">
      		<fieldset>
        	<legend>Data da publica&ccedil;&atilde;o</legend>
    		<input title="Data da publica&ccedil;&atilde;o" alt="Data da publica&ccedil;&atilde;o" type="text" name="dataParlatorio" id="dataParlatorio" value="Publica&ccedil;&atilde;o" onfocus="this.value='<%=vhoje%>'" size="10" maxlength="10" />
            </fieldset>
        </div>
        <div id="caminho_flipbook">
      		<fieldset>
        	<legend>Caminho do Flipbook</legend>
            <input type="text" name="caminho" id="caminho" value=""/>
            </fieldset>
        </div>
        <div id="arquivo_pdf">
      		<fieldset>
        	<legend>Arquivo PDF</legend>
            <input name="arquivoPdf" type="file" id="arquivoPdf" onchange="" >
            </fieldset>
        </div>
        <div id="imagem_capa">
      		<fieldset>
        	<legend>Imagem da Capa</legend>
            <input name="arquivoCapa" type="file" id="arquivoCapa" onchange="" >
            </fieldset>
        </div>
        	<div id="campoArquivo"></div>
				<div id="progressBar" style="display: none;">
					<div id="theMeter">
            			<div id="progressBarText"></div>
                		<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
      <div id="botao">
            
        		<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         		<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaParlatorio();"  />    
      </div>
    </form>
