function critica_inclusao_arquivos(f)
{
	var msg = "";
	if (f.area.value.replace(/^\s*|\s*$/g,"")=="0")
	{
		msg = msg + "- O campo AREA DA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.dataPublicacao.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DATA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.descricao_incluir.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	{
	msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	var erroAnexo = false;
	$("input[id*='anexo']").each(function(index){
		if ( ($( this ).val() == "") && (!erroAnexo) )
		//if ($( this ).val() == "") 
		{
			msg += "- Todos os campos do ARQUIVO ADICIONAL s\u00e3o obrigat\u00f3rios.\n";
			//$( this ).focus();
			erroAnexo = true;
		}
		});
	
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

function critica_inclusao_arquivos2(f)
{
	var msg = "";
	if (f.area.value.replace(/^\s*|\s*$/g,"")=="0")
	{
		msg = msg + "- O campo AREA DA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.dataPublicacao2.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DATA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.descricao_incluir.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	{
	msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	var erroAnexo = false;
	$("input[id*='anexo']").each(function(index){
		if ( ($( this ).val() == "") && (!erroAnexo) )
		//if ($( this ).val() == "") 
		{
			msg += "- Todos os campos do ARQUIVO ADICIONAL s\u00e3o obrigat\u00f3rios.\n";
			//$( this ).focus();
			erroAnexo = true;
		}
		});
	
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



function critica_inclusao_arquivos3(f)
{
	var msg = "";
	if (f.area.value.replace(/^\s*|\s*$/g,"")=="0")
	{
		msg = msg + "- O campo AREA DA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.dataPublicacao3.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DATA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.descricao_incluir.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRICAO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	{
	msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	var erroAnexo = false;
	$("input[id*='anexo']").each(function(index){
		if ( ($( this ).val() == "") && (!erroAnexo) )
		//if ($( this ).val() == "") 
		{
			msg += "- Todos os campos do ARQUIVO ADICIONAL s\u00e3o obrigat\u00f3rios.\n";
			//$( this ).focus();
			erroAnexo = true;
		}
		});
	
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



function critica_inclusao_anexo(f)
{
	var msg = "";
	ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
	if (f.descricao_anexo.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo DESCRI&C\u00c7O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	}
	if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	
	//Se não houver mensagens de erro o submit e acionado no form correspondente
	if (msg.replace(/^\s*|\s*$/g,"")=="")
	{  
		f.submit();
		startProgress5();
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


	if (f.descricao_dados.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O campo n\u00e3o foi preenchido.\n";
	}

	if (!EhData(f.dataPublicacao.value))
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
