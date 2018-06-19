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
		$.post("/gecoi.3.0/apps/prestacao_contas/processa_alteracao_descricao_anexo.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, idArquivo : document.fdescAnexo.idarquivo.value, descricao : document.fdescAnexo.descricao_altera_anexo.value},
				function(){
					//$.post("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=" + document.fdescAnexo.idconteudo.value + "&ano=" + document.fdescAnexo.ano.value + "&edital=" + document.fdescAnexo.edital.value,"resultado");
				});
}
</script>
<%

String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vano  = request.getParameter("ano");
String vedital  = request.getParameter("edital");
%>

<div id="altera_dados_anexo">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Arquivo</legend>

<form name="fdescAnexo" action="/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?id=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="ano" id="ano" value="<%=vano%>"/>
<input type="hidden" name="edital" id="edital" value="<%=vedital%>"/>

<div id="descricao_anexo">
    <fieldset style="height: 80px;">
		<legend>Descrição</legend>
<%--        	<input type="text" name="descricao" id="descricao_altera_anexo" value="<%=vdescricao %>" /> --%>
       	<select name="descricao" id="descricao_altera_anexo">
        		<option value="Balanço - Edital: <%=vedital%>">Balanço</option>
        		<option value="Demonstrativo - Edital: <%=vedital%>">Demonstrativo</option>
        </select>
    </fieldset>
</div>
      
</form>
</fieldset>

<br><br>	
<div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=<%=vidConteudo%>&ano=<%=vano %>&edital=<%=vedital %>','resultado');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
 </div>  

</div>
 

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
