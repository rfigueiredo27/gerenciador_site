function critica_inclusao_registro(f,ar)
{
  var msg = "";
  ext = (ar.substring(ar.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  
  if (f.dataVigenciaInicial.value != "")
  {
	if (!EhData(f.dataVigenciaInicial.value))
  	{
	  msg = msg + "- A DATA DE VIG\u00caNCIA; INICIAL n&atilde;o &eacute; v&aacute;lida.\n";
  	}
  }
  if (f.dataVigenciaFinal.value != "")
  {
	if (!EhData(f.dataVigenciaFinal.value))
  	{
	  msg = msg + "- A DATA DE VIG&Ecirc;NCIA; FINAL n&atilde;o &eacute; v&aacute;lida.\n";
  	}
  }
  
  if (f.fornecedor.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo FORNECEDOR \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
  
   if (ext!=".pdf")
  {
     msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }
  
   
  
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


function critica_altera_registro(f)
{
	  var msg = "";

	  if (!EhData(f.dataPublicacao2.value))
	  {
	     msg = msg + "- A DATA DE PUBLICA&Ccedil;&Atilde;O n&atilde;o &eacute; v&aacute;lida.\n";
	  }
	  
	  
	  if (f.dataVigenciaInicial2.value != "")
	  {
		if (!EhData(f.dataVigenciaInicial2.value))
	  	{
		  msg = msg + "- A DATA DE VIG&Ecirc;NCIA; INICIAL n&atilde;o &eacute; v&aacute;lida.\n";
	  	}
	  }
	  if (f.dataVigenciaFinal2.value != "")
	  {
		if (!EhData(f.dataVigenciaFinal2.value))
	  	{
		  msg = msg + "- A DATA DE VIG&Ecirc;NCIA; FINAL n&atilde;o &eacute; v&aacute;lida.\n";
	  	}
	  }
	  
	  if (f.fornecedor.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo FORNECEDOR é de preenchimento obrigatório.\n";
	  }
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  return true;
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}
