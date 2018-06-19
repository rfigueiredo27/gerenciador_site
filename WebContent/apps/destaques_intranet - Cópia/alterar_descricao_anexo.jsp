   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
   
<script>

function criticaAnexo()
{
	if (document.fdescanexo.descricaoAnexo.value == "")
		alert("É necessário preencher a descrição.");
	else
		$.post("/gecoi.3.0/apps/destaques_intranet/processa_alteracao.jsp", {idConteudo: document.fdescanexo.idconteudo.value, idArquivo : document.fdescanexo.idarquivo.value, descricao: document.fdescanexo.descricaoAnexo.value}, 
				function(){
					//top.listar();
					$.post("/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=" + document.fdescanexo.idconteudo.value, function(){document.fdescanexo.submit()});
					//document.location.href = "gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=" + document.fdescanexo.idconteudo.value;
				});
}
</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");

%>

<form name="fdescanexo" action="/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=<%=vidConteudo%>" method="post" enctype="multipart/form-data"> 
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        <input type="text" name="descricaoAnexo" id="descricaoAnexo" value="<%=vdescricao%>" />
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
