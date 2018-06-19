
<%@page import="java.text.SimpleDateFormat"%>

<%

String data_atual = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(System.currentTimeMillis());

%>

<!-- essa CSS é necessária para anular a configuração do bootstrap -->
<style>
legend
{
	margin-bottom:0px;
	border-bottom: none;
	width: auto;
}
</style>

  <script>
function escolhe_edicao_incluir(pescolha)
{
	if (pescolha == "U")
	{
		$("#incluir_html").show();
		$("#incluir_editar_arquivo").hide();
	}
	else
	{
		$("#incluir_editar_arquivo").show();
		$("#incluir_html").hide();
	}
}

function atualizaTelaReportagem()
{
	document.fincReportagem.reset();
	$('#IncluirHtmlReportagem').summernote('reset');
	top.inicia_editor('IncluirHtmlReportagem');
}


function criticaReportagem()
{
	critica_inclusao_reportagem(document.fincReportagem);
	zera_contador();
}

</script>

<form name="fincReportagem" action="/gecoi.3.0/apps/noticias_interno/processa_incluir_reportagem.jsp" method="post" target="rodape" enctype="multipart/form-data">
<div id="secao_reportagem">
	<fieldset>
    	<legend>Ambiente da Publica&ccedil;&atilde;o</legend>
       	<select name="ambienteReportagem" id="ambienteReportagem" >
			<option value="0">-----------</option>
            <option value="2661">Internet e Intranet</option>
            <option value="42">Internet</option>
            <option value="22">Intranet</option>
 		</select>
	</fieldset>
</div>

<div id="data_reportagem">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataR" id="dataReportagem" size="10" maxlength="10" value="<%=data_atual%>"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloReportagem" id="tituloReportagem" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selecione a imagem da TV (opcional)</legend>
        <!-- campo 4 -->
            <input name="tv" type="file" id="tv" onchange="">
   		  </fieldset>
      </div>
      <div class="tipo_arquivo">
      	<fieldset>
        	<legend>Como deseja publicar a reportagem? </legend>
            <label><input type="radio" value="editar" id="tipoArquivo" name="tipoArquivo" checked="checked" onclick="escolhe_edicao_incluir('E');" />Editar a reportagem</label>&nbsp;&nbsp;&nbsp;
            <label><input type="radio" value="upload" id="tipoArquivo" name="tipoArquivo" onclick="escolhe_edicao_incluir('U');" />Upload de um arquivo HTML</label>

        <div id="incluir_html" class="incluir_html invisivel">
      		<input name="html" type="file" id="html" onchange="">
      </div>
        <div class="editar_arquivo " id="incluir_editar_arquivo" style="text-align:justify">
            <div id="IncluirHtmlReportagem"></div>
            <textarea name="vtexto" id="vtexto" style="display:none"></textarea>
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
            </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaReportagem();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaReportagem();"  />
      </div>
</form>


<!--<div id="summernote">Digite a reportagem</div> -->
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="500" width="500"></iframe>
