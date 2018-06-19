// JavaScript Document
function critica_alteracao_reportagem(f)
{
  var msg = "";
  
  if (!EhData(f.data_inicio.value))
  {
     msg = msg + "- A DATA INICIO n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (!EhData(f.data_fim.value))
  {
     msg = msg + "- A DATA FIM n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if ($('#AlteraHtmlReportagem').summernote('isEmpty')) 
  {
   	msg = msg + "- O TEXTO está Vazio!\n";
  }
   //alert('contents is empty');
  //Se não houver mensagens de erro o submit e acionado no form correspondente
   if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  //$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
		$("#vtexto_altera").val($('#AlteraHtmlReportagem').summernote('code'));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8220))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8220),"&quot;"));	
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8221))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8221),"&quot;"));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8216))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8216),"'"));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8217))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8217),"'"));
		while($("#vtexto_altera").val().indexOf("script")>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace("script",""));	
	
	  f.submit();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}


