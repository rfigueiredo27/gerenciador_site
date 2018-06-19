<script>

function criticaAnexo()
{
	//if (document.fdescAnexo.descricaoAditivo.value == "")
	//	alert("É necessário preencher a descrição.");
	//else
		$.post("/gecoi.3.0/apps/licitacao/processa_alteracao_descricao_anexo.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, idArquivo : document.fdescAnexo.idarquivo.value, descricao : document.fdescAnexo.descricao.value},
				function(){
					//$.post("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value + "&nProcesso=" + document.fdescAnexo.nProcesso.value + "&nPregao=" + document.fdescAnexo.nPregao.value,"divbusca");
				});
}
</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");

%>

<div id="altera_anexo">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do anexo</legend>
<div id="numero">
<form name="fdescAnexo" action="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>

<div id="numero">
	<div id="numero_processo">
    	
    	<p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
    <div id="numero_pregao">
   
    	<p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>
<div id="descricao_anexo">
        	<fieldset>
				<legend>Descrição</legend>
            	<input type="text" name="descricao" id="descricao" value="<%=vdescricao %>" />
            </fieldset>
</div>	
<div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo%>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
 </div>        
</form>
</fieldset>
</div>
 

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
