   
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	//parent.tb_remove();
	parent.carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fincAnexo.idconteudo.value , "divbusca");
}

function criticaAnexo()
{	
	critica_inclusao_anexo(document.fincAnexo);
	//document.fincAnexo.submit();
	//startProgress();
	//parent.tb_remove();
	//carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fincAnexo.idconteudo.value + "&nProcesso=" + document.fincAnexo.nProcesso.value + "&nPregao=" + document.fincAnexo.nPregao.value,"divbusca");
}

</script>
<%
String vidConteudo = request.getParameter("idConteudo");

%>

<div id="altera_anexo">
	<fieldset>
		<legend>Inclus&atilde;o de anexos</legend>
<form name="fincAnexo" action="/gecoi.3.0/IncluirAnexoGenerico" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="app" id="app" value="/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=<%=vidConteudo %>"/>

	<div id="descricao_anexo">
    	<fieldset>
		<legend>Descrição</legend>
        	<input type="text" name="descricao" id="descricao_anexo" value=""  />
        </fieldset>
    </div>
      <div id="campoArquivo5"><input type="file" name="anexo" id="anexo" /></div>
	  <div id="progressBar5" style="display: none;">
	  	<div id="theMeter5">
        	<div id="progressBarText5"></div>
            <div id="progressBarBox5">
            	<div id="progressBarBoxContent5"></div>
            </div>
            </div>
        </div>
	
     <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=<%=vidConteudo%>','divbusca');" />
           
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
      </div>
     
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
