   <script type="text/javascript" src="/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
   
<script>

tinyMCE.init({
	// General options
	mode : 'textareas',
	theme : "advanced",
	plugins : "lists,advlink,inlinepopups,print,paste,fullscreen,searchreplace,style,nonbreaking,table",
	convert_urls: false,
	// Theme options
	theme_advanced_buttons1 : "bold,italic,underline,strikethrough,charmap,pastetext,removeformat,|,outdent,indent,bullist,link,unlink,tablecontrols,|,undo,redo,|,print,code,|,formatselect",
	theme_advanced_buttons2 : false,
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",

	// Example content CSS (should be your site CSS)
	content_css : "/gecoi.3.0/css/tinymce.css",

    // Style formats
	style_formats : [
		{title : 'Subtítulo', block : 'h2'},
		{title : 'Alerta',  inline : 'span', classes : 'alerta'}
	]

});

function atualizaTela()
{
	//$('#TB_window').fadeOut();
	//$('#TB_window').fadeOut();
	top.listar();
	parent.tb_remove();
}


</script>
<%
String vidConteudo = request.getParameter("id");
String vdescricao = request.getParameter("descricao");
String vidArquivoTexto = request.getParameter("idArquivoTexto");
String vnomeArquivo = request.getParameter("nome");
%>
<form name="farquivo" action="/gecoi.3.0/AlteraCurriculoTexto" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>           
<input type="hidden" name="idarquivoTexto" id="idarquivoTexto" value="<%=vidArquivoTexto%>"/>
<input type="hidden" name="nomeArquivo" id="nomeArquivo" value="<%=vnomeArquivo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
            <textarea id="texto" name="texto" style="width:100%; height:405px;" wrap="virtual" value="" >
            	<%@include file="le_arquivo_txt.jsp"%>                
  	        </textarea>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="submit" name="save" value="Grava alterações" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
