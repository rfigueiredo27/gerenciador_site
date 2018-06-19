function critica_inclusao_contrato(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();

  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00daMERO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (!EhData(f.vigenciaIni.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  if (!EhData(f.vigenciaFim.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

  
  //verifica se o campo data da publica\u00c7\u00e3o \u00e9 v\u00e1lido
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
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


function critica_altera_aditivo(f)
{
  var msg = "";

  if (f.vigenciaIni3.value.replace(/^\s*|\s*$/g,"")!="")
  {
	if (!EhData(f.vigenciaIni3.value))
  	{
	  msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  	}
  }
  if (f.vigenciaFim3.value.replace(/^\s*|\s*$/g,"")!="")
  {
	  if (!EhData(f.vigenciaFim3.value))
	  {
		  msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
	  }
  }
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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

function critica_altera_outros_termos(f)
{
  var msg = "";

  if ((f.termo.value == "0"))
  {
     msg = msg + "- A DESCRI\u00c7\u00c3O DO TERMO n\u00e3o foi selecionada.\n";
  }

  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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


function critica_altera_contrato_sem_licitacao(f)
{
  var msg = "";

  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (!EhData(f.vigenciaIni5.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  if (!EhData(f.vigenciaFim5.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

/*  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00e3O DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  */
  
  //verifica se o campo data da publica\u00c7\u00e3o \u00e9 v\u00e1lido
  if (!EhData(f.dataPublicacao5.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00e3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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


function critica_altera_contrato(f)
{
  var msg = "";

  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (!EhData(f.vigenciaIni2.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (!EhData(f.vigenciaFim2.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
 /* if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00e3O DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }*/
  
  //verifica se o campo data da publica\u00c7\u00e3o \u00e9 v\u00e1lido
  if (!EhData(f.dataPublicacao2.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00e3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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


function critica_inclusao_aditivo(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
    
  if (f.vigenciaIni4.value.replace(/^\s*|\s*$/g,"")!="")
  {
	  if (!EhData(f.vigenciaIni4.value))
	  {
		  msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
	  }
  }

  if (f.vigenciaFim4.value.replace(/^\s*|\s*$/g,"")!="")
  {
	  if (!EhData(f.vigenciaFim4.value))
	  {
		  msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
	  }
  }

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

function critica_inclusao_outros_termos(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
    
  if ((f.descricao.value == "0"))
  {
     msg = msg + "- A DESCRI\u00c7\u00e3O DO TERMO n\u00e3o foi selecionada.\n";
  }

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




function critica_inclusao_contrato_sem_licitacao(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();

  if (f.tipo.value == "-")
  {
	  msg = msg + "- o campo TIPO DE CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (!EhData(f.vigenciaIni4.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  if (!EhData(f.vigenciaFim4.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00c3O DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  //verifica se o campo data da publica\u00c7\u00e3o \u00e9 v\u00e1lido
  if (!EhData(f.dataPublicacao4.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00c3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
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


function critica_alteracao_contrato_sem_licitacao(f)
{
  var msg = "";

  if (f.tipo.value == "-")
  {
	  msg = msg + "- o campo TIPO DE CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00d9MERO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (!EhData(f.vigenciaIni4.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  if (!EhData(f.vigenciaFim4.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00e3O DO CONTRATO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  //verifica se o campo data da publica\u00c7\u00e3o \u00e9 v\u00e1lido
  if (!EhData(f.dataPublicacao4.value))
  {
     msg = msg + "- A DATA DE PUBLICA\u00c7\u00e3O n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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

function critica_inclusao_aditivo_sem_licitacao(f)
{
  var msg = "";
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
 
  if (!EhData(f.vigenciaIni6.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

  if (!EhData(f.vigenciaFim6.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }

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
	  startProgress2();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_altera_aditivo_sem_licitacao(f)
{
  var msg = "";

  if (!EhData(f.vigenciaIni7.value))
  {
     msg = msg + "- A VIG\u00caNCIA INICIAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if (!EhData(f.vigenciaFim7.value))
  {
     msg = msg + "- A VIG\u00caNCIA FINAL n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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

function critica_inclusao_outros_termos_sem_licitacao(f)
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
	  startProgress2();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_altera_outros_termos_sem_licitacao(f)
{
  var msg = "";

  if ((f.termo.value == "0"))
  {
     msg = msg + "- A DESCRI\u00c7\u00e3O DO TERMO n\u00e3o foi selecionada.\n";
  }
  //Se n\u00e3o houver mensagens de erro o submit e acionado no form correspondente
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
	  startProgress2();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}

function critica_inclusao_rescisao(f)
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

function critica_inclusao_rescisao_sem_licitacao(f)
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