// JavaScript Document
function critica_inclusao(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.ambienteReportagem.value=="0")
  {
     msg = msg + "- O campo AMBIENTE \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
/*  if (f.mytextarea.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo REPORTAGEM \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }*/
  /*
  if (f.tv.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- A IMAGEM DA TV n\u00e3o foi selecionada.\n";
  }
 */
	 
 if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  //$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
	    $("#vtexto").val($('#IncluirHtmlReportagem').summernote('code'));
		while($("#vtexto").val().indexOf(String.fromCharCode(8220))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8220),"&quot;"));	
		while($("#vtexto").val().indexOf(String.fromCharCode(8221))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8221),"&quot;"));
		while($("#vtexto").val().indexOf(String.fromCharCode(8216))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8216),"'"));
		while($("#vtexto").val().indexOf(String.fromCharCode(8217))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8217),"'"));
		while($("#vtexto").val().indexOf("script")>0)
			$("#vtexto").val($("#vtexto").val().replace("script",""));	
	  f.submit();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}


function critica_alteracao(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.ambienteAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="0")
  {
     msg = msg + "- O campo AMBIENTE \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataAlteraReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
   //alert('contents is empty');
  //Se não houver mensagens de erro o submit e acionado no form correspondente
   if (msg.replace(/^\s*|\s*$/g,"")=="")
  { 
	  f.submit();
	  startProgress2();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}


