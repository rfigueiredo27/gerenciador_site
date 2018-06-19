
<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");

%>
<script>

function alterar()
{
	
	if (critica_altera_avisos(document.favisos))
	{
	
		$.post("/gecoi.3.0/apps/gecoi_avisos/processa_alteracao.jsp", {idConteudo: document.favisos.idconteudo.value, 
										  idArquivo : document.favisos.idarquivo.value, 
										  descricao: document.favisos.descricao_dados.value 
										  }, function(){listar();});
	}
}
</script>

<div id="altera_dados">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Aviso</legend>
<form name="favisos" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>

      <div id="altera_objeto">
         <fieldset>
       		<legend>Título do Aviso</legend>
   			<textarea title="Titulo do Aviso" name="descricao_dados" id="descricao_dados" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);"><%=vdescricao %></textarea>
			<span id="contadorDescricao" class="alert"></span>
        </fieldset>
     </div>
     <div id="botao">
     	<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
        <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
     </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
