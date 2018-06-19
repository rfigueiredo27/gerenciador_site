// JavaScript Document
function critica_inclusao_reportagem(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.edicaoReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo EDICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.secaoReportagem.value=="0")
  {
     msg = msg + "- O campo SECAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.subtituloReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo SUBTITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
/*  if (f.mytextarea.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo REPORTAGEM \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }*/
  if (f.tv.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- A IMAGEM DA TV n\u00e3o foi selecionada.\n";
  }
  /*if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  $.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
	  f.submit();
	  startProgress2();
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
  if (f.edicaoReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo EDICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.secaoAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="0")
  {
     msg = msg + "- O campo SECAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataAlteraReportagem.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.tituloAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo TITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.subtituloAlteraReportagem.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo SUBTITULO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
/*  if (f.mytextarea.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo REPORTAGEM \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }*/
/*  if (f.tv.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- A IMAGEM DA TV n\u00e3o foi selecionada.\n";
  }
  if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  $.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.alteraReportagem.value}, function(){} );
	  f.submit();
	  startProgress5();
	  startProgress6();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}


function critica_inclusao_fundo(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.resumoFundo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo RESUMO \u00e9 de preenchimento obrigat\u00f3rio.\n";
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
	  f.submit();
	  //startProgress3();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_alteracao_fundo(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.resumoAlteraFundo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo RESUMO \u00e9 de preenchimento obrigat\u00f3rio.\n";
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
	  f.submit();
	  //startProgress3();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_inclusao_parlatorio(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataParlatorio.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.edicao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo EDI&C\u00c7O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.arquivoPdf.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO PDF \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.arquivoCapa.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- A IMAGEM DA CAPA \u00e9 de preenchimento obrigat\u00f3ria.\n";
  }
/*  if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  f.submit();
	  startProgress();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_alteracao_parlatorio(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataAlteraParlatorio.value))
  {
     msg = msg + "- A DATA DE PUBLICA&C\u00c7O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.edicao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo EDICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
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
	  f.submit();
	  startProgress4();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}
