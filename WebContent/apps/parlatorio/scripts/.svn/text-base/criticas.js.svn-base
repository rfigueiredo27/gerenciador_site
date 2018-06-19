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
  if ($('#IncluirHtmlReportagem').summernote('isEmpty')) 
  {
   msg = msg + "- O TEXTO está Vazio!\n";
   //alert('contents is empty');
  }
  /*if (ext!=".pdf")
  {
  msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  
	    /*$("#vtexto").val($('#IncluirHtmlReportagem').summernote('code'));
		/*alert($("#vtexto").val().substring($("#vtexto").val().indexOf("Teste")+6,$("#vtexto").val().indexOf("Teste")+7));
		alert($("#vtexto").val().substring($("#vtexto").val().indexOf("Teste")+7,$("#vtexto").val().indexOf("Teste")+8));
		alert($("#vtexto").val().substring($("#vtexto").val().indexOf("Teste")+8,$("#vtexto").val().indexOf("Teste")+9));
		/*var posicaoImg = $("#vtexto").val().indexOf("<img");
		alert(posicaoImg);
		var fimPosicaoImg = $("#vtexto").val().indexOf(">",posicaoImg);
		alert(fimPosicaoImg);
		var letra = String.fromCharCode(8220);
		alert(letra);
		alert($("#vtexto").val().indexOf(letra));*/
		
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
	  /*for (i = 0; i < $('#IncluirHtmlReportagem').summernote('code').length; i++)
	  {
		  vletra = $('#IncluirHtmlReportagem').summernote('code').substr(i,1);
		  if ( (vletra.charCodeAt(0) == 8220) || (vletra.charCodeAt(0) == 8221) ) // abre e fecha aspas do word
		  		vletra = "\"";
		  if ( (vletra.charCodeAt(0) == 8216) || (vletra.charCodeAt(0) == 8217) ) // abre e fecha plic do word
		  		vletra = "\'";
			
		  $("#vtexto").val($("#vtexto").val() + vletra);
	  }*/
	  f.submit();
	  startProgress5();
	  //startProgress6();
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
  if ($('#AlteraHtmlReportagem').summernote('isEmpty')) 
  {
   msg = msg + "- O TEXTO está Vazio!\n";
   //alert('contents is empty');
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
	  //$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : f.mytextarea.value}, function(){} );
		$("#vtexto_altera").val($('#AlteraHtmlReportagem').summernote('code'));
	  //alert($("#vtexto_altera").val().indexOf(String.fromCharCode(8220)));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8220))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8220),"&quot;"));	
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8221))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8221),"&quot;"));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8216))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8216),"'"));
		while($("#vtexto_altera").val().indexOf(String.fromCharCode(8217))>0)
			$("#vtexto_altera").val($("#vtexto_altera").val().replace(String.fromCharCode(8217),"'"));
	
	   // $("#vtexto_altera").val($('#AlteraHtmlReportagem').summernote('code'));
	  /*for (i = 0; i < $('#AlteraHtmlReportagem').summernote('code').length; i++)
	  {
		  vletra = $('#AlteraHtmlReportagem').summernote('code').substr(i,1);
		  if ( (vletra.charCodeAt(0) == 8220) || (vletra.charCodeAt(0) == 8221) ) // abre e fecha aspas do word
		  		vletra = "\"";
		  if ( (vletra.charCodeAt(0) == 8216) || (vletra.charCodeAt(0) == 8217) ) // abre e fecha plic do word
		  		vletra = "\'";
			
		  $("#vtexto_altera").val($("#vtexto_altera").val() + vletra);
	  }*/
	  f.submit();
	  startProgress6();
	  //startProgress6();
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
