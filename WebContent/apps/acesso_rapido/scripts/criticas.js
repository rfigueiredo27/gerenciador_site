function critica_inclusao(f)
{
	var msg = "";
	if (f.descricao1.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.link.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo LINK \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.hint.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo HINT \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	
	if (f.arquivo1.value.replace(/^\s*|\s*$/g,"")=="")
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

function critica_altera_arquivos(f)
{
	var msg = "";


	if (f.descricao1.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.link.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo LINK \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.hint.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo HINT \u00e9 de preenchimento obrigat\u00f3rio.\n";
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
	/*  if (ext!=".pdf")
  {
     msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/

	//Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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

$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
});
