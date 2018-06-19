function critica_inclusao_registro(f,ar)
{
  var msg = "";
  ext = (ar.substring(ar.lastIndexOf("."))).toLowerCase();
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (f.descricao.value == "")
  {
	  msg = msg + "- A DESCRI\u00c7\u00c3O deve ser preenchida.\n";
  }
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
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

	  if (f.descricao.value == "")
	  {
		  msg = msg + "- A DESCRI\u00c7\u00c3O deve ser preenchida.\n";
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

function critica_altera_substituicao_arquivo(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
    
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
  
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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
