
<script>

function atualizaTelaFundo()
{
	document.fincFundo.reset();
	carregaPag('/gecoi.3.0/apps/parlatorio/lista_reportagem.jsp?operacao=fundo', 'novo_fundo');
}


function criticaFundo()
{
	critica_inclusao_fundo(document.fincFundo);
}

$(document).ready(function(){
});

<%
String vid_conteudo = request.getParameter("idConteudo");
%>
</script>
<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens	do Tipo Fundo do Ba&uacute;</legend>
	<form name="fincFundo" action="/gecoi.3.0/apps/parlatorio/processa_incluir_fundo.jsp" method="post" target="rodape" >
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <!--<input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="" height="100" width="100" />-->
				<textarea name="resumoFundo" id="resumoFundo" title="Resumo da Reportagem" onKeyPress="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);" onKeyUp="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);" onKeyDown="javascript:resta(this.form.resumoFundo, 'contadorFundo', 214);"></textarea>
                </br><span class="alert">Ainda restam <span id="contadorFundo">214</span>caracteres.</span>
								
							
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
