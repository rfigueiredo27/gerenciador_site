// JavaScript Document
function critica_inclusao_legislacao(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.tipoLegislacao.value=="0")
  {
     msg = msg + "- O campo LEGISLA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataLegislacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if ( ( (f.tipoLegislacao.value=="47") || (f.tipoLegislacao.value=="48") || (f.tipoLegislacao.value=="53") ) && (f.tipoNorma.value=="0") )
  {
	  msg = msg + "- O campo NORMA \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if ( (f.num_norma.value.replace(/^\s*|\s*$/g,"")=="") || (f.ano_norma.value.replace(/^\s*|\s*$/g,"")=="")  )
  {
     msg = msg + "- O campo N\u00daMERO DA NORMA \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.assuntoLegislacao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ASSUNTO \u00e9 de preenchimento obrigat\u00f3rio.\n";
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


function critica_alteracao_legislacao(f)
{
  var msg = "";
  //ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.tipoAlteraLegislacao.value=="0")
  {
     msg = msg + "- O campo LEGISLA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.dataAlteraLegislacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if ( ( (f.tipoAlteraLegislacao.value=="47") || (f.tipoAlteraLegislacao.value=="48") || (f.tipoAlteraLegislacao.value=="53") ) && (f.tipoAlteraNorma.value=="0") )
  {
	  msg = msg + "- O campo NORMA \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if ( (f.numAlteraNorma.value.replace(/^\s*|\s*$/g,"")=="") || (f.anoAlteraNorma.value.replace(/^\s*|\s*$/g,"")=="")  )
  {
     msg = msg + "- O campo N\u00daMERO DA NORMA \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.assuntoAlteraLegislacao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ASSUNTO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
 if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  f.submit();
	  zera_contador();
	  //startProgress();
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
	  startProgress2();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}
