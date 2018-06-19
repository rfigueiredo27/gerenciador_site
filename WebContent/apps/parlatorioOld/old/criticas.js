// JavaScript Document
function critica_inclusao_reportagem(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  /*if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
  if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  $.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
	  f.submit();
	  startProgress();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_inclusao_item(f)
{
  var msg = "";
  //ext = (f.arquivo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataItemTv.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.descricaoItemTv.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI&C\u00c7O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.ordem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ORDEM \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  /*if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
  if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  f.submit();
	  //startProgress();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_alteracao_reportagem(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataAlteraReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  /*if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
  if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  $.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
	  f.submit();
	  startProgress();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

