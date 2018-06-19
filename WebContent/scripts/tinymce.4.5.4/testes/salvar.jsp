<%@ page language="java" import="java.io.*,java.sql.*,java.util.*"%>
<%@include file="/gecoi.3.0/apps/global/conexao_pool_gecoi_v2.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>GECOI - Edição Arquivo</title>
<link rel="stylesheet" type="text/css" href="../css/anexos.css" />
<style type="text/css">
body{
	margin:0;
	padding:0;
}

form{
	margin-top:0;
	padding-top:0;

}

table{
	margin-top:0;
	padding-top:0;

}

</style>
<!--<script type="text/javascript" src="/gecoi/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>-->
<script src="/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script>

<script type="text/javascript">
  tinymce.init({ 
  selector:'textarea' ,
  plugins: [
    'advlist autolink lists link image charmap print preview anchor',
    'searchreplace visualblocks code fullscreen',
    'insertdatetime media table contextmenu paste code'
  ]
    });
    

/*	tinyMCE.init({
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
		content_css : "/gecoi/css/tinymce.css",

        // Style formats
		style_formats : [
			{title : 'Subtítulo', block : 'h2'},
			{title : 'Alerta',  inline : 'span', classes : 'alerta'}
		]
		


	});
*/
	
    function valida_arquivo(f)
    {
       document.getElementById("mensagem_caixa").innerHTML = "";
       f.submit();
    }

</script>

</head>

<body>
<%
//criação de variáveis
String vsql       = "";  //instrução da consulta ao banco
String vidarquivo = "";  //id do arquivo
String vpasta     = ""; //caminho onde será gravado o arquivo

//Recebe os parâmetros do formulário
vidarquivo  = request.getParameter("idarquivo");
%>

<form name="arquivo" action="processar.jsp" method="post" target="rodape">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
            <textarea id="texto" name="texto" style="width:100%; height:405px;" wrap="virtual">
                <%@include file="le_arquivo_txt.jsp"%>
  	        </textarea>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Grava alterações" onclick="valida_arquivo(this.form);"/>
           <input type="hidden" name="idarquivo" value="<%=vidarquivo%>"/>
           <input type="hidden" name="pasta" value="<%=vpasta%>"/>&nbsp;&nbsp;&nbsp;        
        </td>
      </tr>
  </table>
</form>
<div id="mensagem_caixa"></div> 
<!--Usado para processar o arquivo-->
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
</body>
</html>