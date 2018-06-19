<script>
$(document).ready(function(){
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
});


function criticaAnexo()
{
	if (document.fdescAnexo.descricao_altera_anexo.value == "")
		alert("É necessário preencher a descrição.");
	else
		$.post("/gecoi.3.0/apps/gecoi_arquivos/processa_alteracao_descricao_anexo.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, idArquivo : document.fdescAnexo.idarquivo.value, descricao : document.fdescAnexo.descricao_altera_anexo.value},
				function(){
					//$.post("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value ,"divbusca");
				});
}
</script>
<%

String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");

%>

<div id="altera_anexo">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do anexo</legend>
<div id="numero">
<form name="fdescAnexo" action="/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>



<div id="descricao_anexo">
        	<fieldset>
				<legend>Descrição</legend>
            	<input type="text" name="descricao" id="descricao_altera_anexo" value="<%=vdescricao %>" />
            </fieldset>
</div>	
<div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=<%=vidConteudo%>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
 </div>        
</form>
</fieldset>
</div>
 

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
