
   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
   
<script>

function criticaAnexo()
{
	if (document.fincanexo.descricaoAnexo.value == "")
		alert("� necess�rio preencher a descri��o.");
	else
		document.fincanexo.submit();
		/*$.post("/gecoi.3.0/apps/destaques_intranet/processa_alteracao.jsp", {idConteudo: document.fdescanexo.idconteudo.value, idArquivo : document.fdescanexo.idarquivo.value, descricao: document.fdescanexo.descricaoAnexo.value}, 
				function(){
					top.listar();
					$.post("/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=" + document.fdescanexo.idconteudo.value, function(){});
					//document.location.href = "gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=" + document.fdescanexo.idconteudo.value;
				});*/
}
</script>
<%
String vidConteudo = request.getParameter("idConteudo");

%>

<form name="fincanexo" action="/gecoi.3.0/IncluirAnexo" method="post" enctype="multipart/form-data"> 
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	<input type="text" name="descricaoAnexo" id="descricaoAnexo" value="" />
        </td>
      </tr>
      <tr>
        <td>
        	<input type="file" name="anexo" id="anexo" />
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="history.back();" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
