   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
<%
String vidConteudo = request.getParameter("id");
String vdescricao = request.getParameter("descricao");
%>
<script>
function alteraDescricao()
{
	
	if (document.fdescricao.descricao.value == "")
		alert("É necessário preencher o nome.");
	else
		$.post("processa_alteracao_curriculo.jsp", {idConteudo : document.fdescricao.idconteudo.value, descricao: document.fdescricao.descricao.value}, function(){top.listar();parent.tb_remove();});
}
</script>
<form name="fdescricao" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Nome</td></tr>
      <tr>
        <td align="center">
			<input type="text" name="descricao" id="descricao" value="<%=vdescricao%>"/>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Grava alterações" onclick="alteraDescricao();" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
