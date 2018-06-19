function critica_inclusao_registro(f)
{
  var msg = "";

  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA&Ccedil;&Atilde;O n&atilde;o &eacute; v&aacute;lida.\n";
  }
  
  
  if (f.dataVigenciaInicial.value != "")
  {
	if (!EhData(f.dataVigenciaInicial.value))
  	{
	  msg = msg + "- A DATA DE VIG&Ecirc;NCIA; INICIAL n&atilde;o &eacute; v&aacute;lida.\n";
  	}
  }
  if (f.dataVigenciaFinal.value != "")
  {
	if (!EhData(f.dataVigenciaFinal.value))
  	{
	  msg = msg + "- A DATA DE VIG&Ecirc;NCIA; FINAL n&atilde;o &eacute; v&aacute;lida.\n";
  	}
  }
  
  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI��O � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n�o foi selecionado.\n";
  }
  
  //Se n�o houver mensagens de erro o submit e acionado no form correspondente
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
	  
	  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo DESCRI��O � de preenchimento obrigat�rio.\n";
	  }
  //Se n�o houver mensagens de erro o submit e acionado no form correspondente
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
