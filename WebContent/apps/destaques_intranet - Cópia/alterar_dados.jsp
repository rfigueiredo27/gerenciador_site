   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vpublicado = request.getParameter("publicado");
String vlink = request.getParameter("link");
String vdataIni = request.getParameter("dataIni");
String vdataFim = request.getParameter("dataFim");
%>
<script>
$(document).ready(function(){
	$("#dataIni").datepicker();
	$("#dataFim").datepicker();
});

function alterar()
{
	// apago o link com espacos em branco porque na hora de gravar a procedure não faz alteracao no campo observacao (onde será gravado o link) quando esse é nulo
	if (document.fdestaque.link.value == "")
		document.fdestaque.link.value = "   ";
	if (document.fdestaque.descricao.value == "")
		alert("É necessário preencher o nome.");
	else
		$.post("processa_alteracao.jsp", {idConteudo: document.fdestaque.idconteudo.value, idArquivo : document.fdestaque.idarquivo.value, descricao: document.fdestaque.descricao.value, publicadoAtual: document.fdestaque.publicadoAtual.value, publicadoNovo: document.fdestaque.publicadoNovo.value, link: document.fdestaque.link.value, dataIni: document.fdestaque.dataIni.value, dataFim: document.fdestaque.dataFim.value}, function(){top.listar();parent.tb_remove();});
}
</script>
<form name="fdestaque" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="publicadoAtual" id="publicadoAtual" value="<%=vpublicado%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Ordem</td>
        <td>
			<input type="text" name="publicadoNovo" id="publicadoNovo" value="<%=vpublicado%>" maxlength="1"/>
        </td>
      </tr>
      <tr><td>Nome</td>
        <td >
			<input type="text" name="descricao" id="descricao" value="<%=vdescricao%>"/>
        </td>
      </tr>
      <tr><td>Link</td>
        <td>
			<input type="text" name="link" id="link" value="<%=vlink%>" onfocus="document.fdestaque.link.value = document.fdestaque.link.value.trim();"/>
        </td>
      </tr>
      <tr><td>Data in&iacute;cio de exibi&ccedil;&atilde;o</td>
        <td >
			<input type="text" name="dataIni" id="dataIni" value="<%=vdataIni%>"/>
        </td>
      </tr>
      <tr><td>Data fim de exibi&ccedil;&atilde;o</td>
        <td >
			<input type="text" name="dataFim" id="dataFim" value="<%=vdataFim%>"/>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
