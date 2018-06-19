
<script>

function atualizaTelaFundo()
{
	document.fincFundo.reset();
	carregaPag('/gecoi.3.0/apps/parlatorio/lista_reportagem_fundo.jsp', 'novo_fundo');
}


function criticaFundo()
{
	critica_inclusao_fundo(document.fincFundo);
}

$(document).ready(function(){
});

<%

String vid_conteudo = request.getParameter("idConteudo");
String vtitulo = new String(request.getParameter("titulo").getBytes("ISO-8859-1"));


%>
</script>
<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens	do Tipo Fundo do Ba&uacute;</legend>
    <h2><%=vtitulo%></h2>
	<form name="fincFundo" action="/gecoi.3.0/apps/parlatorio/processa_incluir_fundo.jsp" method="post" target="rodape" >
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <!--<input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="" height="100" width="100" />-->
				<textarea name="resumoFundo" id="resumoFundo" title="Resumo da Reportagem" onKeyPress="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);" onKeyUp="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);" onKeyDown="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);" style="width:100%;height:50px; resize:none"></textarea>
                </br><span class="alert"><span id="contadorFundo">Ainda restam 214 caracteres.</span></span>
								
							
        	</fieldset>
	    </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaFundo();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaFundo();"  />
      </div>
      <input type="hidden" name="idconteudo" id="idconteudo" value="<%=vid_conteudo%>" />
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
