function critica_inclusao_registro(f,ar)
{
	var msg = "";
	ext = (ar.substring(ar.lastIndexOf("."))).toLowerCase();

	if (f.num_ata.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O N\u00daMERO DA ATA \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}

	if (!EhData(f.dataPublicacao.value))
	{
		msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
	}

	if (!EhData(f.dataVigenciaInicial.value))
	{
		msg = msg + "- A DATA DE VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
	}

	if (!EhData(f.dataVigenciaFinal.value))
	{
		msg = msg + "- A DATA DE VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
	}

	if (f.fornecedor.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo FORNECEDOR \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}

	if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRI\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}

	if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}

	if (ext!=".pdf")
	{
		msg = msg + "- O ARQUIVO deve ser PDF!.\n";
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
			msg = msg + "- A DATA DE VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
		}
	}
	if (f.dataVigenciaFinal2.value != "")
	{
		if (!EhData(f.dataVigenciaFinal2.value))
		{
			msg = msg + "- A DATA DE VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
		}
	}

	if (f.fornecedor.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo FORNECEDOR � de preenchimento obrigat�rio.\n";
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

function critica_altera_substituicao_arquivo(f)
{
	var msg = "";
	ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();

	if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	if (ext!=".pdf")
	{
		msg = msg + "- O ARQUIVO deve ser PDF!.\n";
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
