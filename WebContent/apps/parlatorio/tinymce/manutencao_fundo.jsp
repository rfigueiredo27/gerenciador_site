
<script>

function atualizaTelaFundo()
{
	document.faltFundo.reset();
	carregaPag('/gecoi.3.0/apps/parlatorio/lista_fundo.jsp', 'listaFundo');
}


function criticaFundo()
{
	critica_alteracao_fundo(document.faltFundo);
}

$(document).ready(function(){
});

<%
String vid_conteudo = request.getParameter("idConteudo");
String[] vresumo = request.getParameter("resumo").split("@@");
%>
</script>
<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens	do Tipo Fundo do Ba&uacute;</legend>
	<form name="faltFundo" action="/gecoi.3.0/apps/parlatorio/processa_alterar_fundo.jsp" method="post" target="rodapeAlteraFundo" >
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <!--<input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="" height="100" width="100" />-->
				<textarea name="resumoAlteraFundo" id="resumoAlteraFundo" title="Resumo da Reportagem" onKeyPress="javascript:resta(this.form.resumoAlteraFundo, 'contadorFundo', 214);" style="width:100%;height:50px; resize:none"><%=vresumo[1]%></textarea>
                </br><span class="alert"><span id="contadorFundo">Ainda restam 214 caracteres.</span></span>
								
							
        	</fieldset>
	    </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaFundo();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaFundo();"  />
      </div>
      <input type="hidden" name="idconteudo" id="idconteudo" value="<%=vid_conteudo%>" />
      <input type="hidden" name="dataResumo" id="dataResumo" value="<%=vresumo[0]%>" />
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodapeAlteraFundo" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
