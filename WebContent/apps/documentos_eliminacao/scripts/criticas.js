function critica_inclusao(f)
{
	var msg = "";
	if (f.unidade.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo UNIDADE \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.edital.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo EDITAL \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	
	if (f.dataPublicacao.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DATA \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	
	if (f.arquivo1.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO DO EDITAL n\u00e3o foi selecionado.\n";
	}
	
	if (f.arquivo2.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO DA LISTA DE DOCUMENTOS n\u00e3o foi selecionado.\n";
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


	if (f.edital.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo n\u00e3o foi preenchido.\n";
	}

	if (!EhData(f.dataPublicacao2.value))
	{
		msg = msg + "- A DATA n\u00e3o \u00e9 v\u00e1lida.\n";
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
