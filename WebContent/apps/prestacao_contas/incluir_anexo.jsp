
<script>
function atualizaTela()
{
	//parent.tb_remove();
	parent.carregaPag("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=" + document.fincAnexo.idconteudo.value +"&ano="+ document.fincAnexo.ano.value+"&edital="+document.fincAnexo.edital.value, "resultado");
}

	
function critica_inclusao_anexo(f)
	{
		var msg = "";
		ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
		if (f.descricao_anexo.value.replace(/^\s*|\s*$/g,"")=="")
		{
			msg = msg + "- O campo DESCRI&C\u00c7O \u00e9 de preenchimento obrigat\u00f3rio.\n";
		}
		if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
		{
			msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
		}
		
		//Se não houver mensagens de erro o submit e acionado no form correspondente
		if (msg.replace(/^\s*|\s*$/g,"")=="")
		{  
			f.submit();
		}
		else
		{
			alert("Ocorreram os seguintes erros:\n\n" + msg);
			return false;
		}

	}	


</script>
<%
String vidConteudo = request.getParameter("idConteudo");
String vano  = request.getParameter("ano");
String vedital = request.getParameter("edital");

%>

<div id="altera_anexo">
	<fieldset>
		<legend>Inclus&atilde;o de anexos</legend>
<form name="fincAnexo" action="/gecoi.3.0/IncluirAnexoGenerico" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="app" id="app" value="/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=<%=vidConteudo %>&ano=<%=vano %>&edital=<%=vedital%>"/>

	<div id="descricao_anexo">
    	<fieldset>
		<legend>Tipo de Arquivo</legend>
        	<select name="descricao" id="descricao_anexo">
        		<option value="Balanço - Edital: <%=vedital%>">Balanço</option>
        		<option value="Demonstrativo - Edital: <%=vedital%>">Demonstrativo</option>
        	</select>
        	<center><input type="file" name="anexo" id="anexo" /></center>
        </fieldset>
    </div>
      
     <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=<%=vidConteudo%>&ano=<%=vano %>&edital=<%=vedital%>','resultado');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="critica_inclusao_anexo(this.form);"  />
      </div>
     <input type="hidden" name="ano" id="ano" value="<%=vano%>"/>
     <input type="hidden" name="edital" id="edital" value="<%=vedital%>"/>      
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
