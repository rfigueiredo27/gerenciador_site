function critica_inclusao_licitacao(f)
{
  var msg = "";

  if (f.numPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N&Uacute;MERO DO PREG&Atilde;O &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.anoPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PREG&Atilde;O &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  else
  {
	  if (f.anoPregao.value.length < 4)
	  	msg = msg + "- O campo ANO DO PREG&Atilde;O deve possuir 4 dígitos.\n";
  }
    
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N&Uacute;MERO DO PROCESSO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  else
  {
	  if (f.anoProcesso.value.length < 4)
	  	msg = msg + "- O campo ANO DO PROCESSO deve possuir 4 dígitos.\n";
  }
  
  if (!EhData(f.dataAbertura.value))
  {
     msg = msg + "- A DATA DE ABERTURA n&atilde;o &eacute; v&aacute;lida.\n";
  }
  
  if (f.dataFechamento.value != "")
  {
	if (!EhData(f.dataFechamento.value))
  	{
	  msg = msg + "- A DATA DE ENCERRAMENTO n&atilde;o &eacute; v&aacute;lida.\n";
  	}
  }
  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI&Ccedil;&Atilde;O DO OBJETO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO não foi selecionado.\n";
  }

  
/*
   if (id==0)
	  msg = msg + "- Você deve adicionar ao menos 1 (um) arquivo para upload.\n";   
   else
   {
      //Verifica se todos os arquivos foram indicados
      for (i=1;i<=id;i++)
      {
         //verifica se a descricao do arquivo i foi fornecida
         if (frames[i-1].document.forms[0].descricao.value.replace(/^\s*|\s*$/g,"")=="")
	     {
		     msg = msg + "- A descrição do arquivo nº " + i + " não foi informada.\n";
   	     }	  

         //verifica se a localização do arquivo i foi fornecida
         if (frames[i-1].document.forms[0].arqanexo.value.replace(/^\s*|\s*$/g,"")=="")
	     {
		     msg = msg + "- A localização do arquivo nº " + i + " não foi informada.\n";
  	     }
	  }
	  
   }
  */
  //Se não houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  f.submit();
	  startProgress();
/*      //se foi um sucesso verifica se há arquivos para enviar
       if (id>0)
	   {   
	      //zera a mensagem na tela se houver
		  document.getElementById("mensagem").className = "";
	      document.getElementById("mensagem").innerHTML = "";
		  
		  //Verifica quantos arquivos existem, acerta o id do conteúdo (que é igual ao do aviso) de cada um e processa o submit dos formulários
          for (i=1;i<=id;i++)
          {
			  frames[i-1].document.anexo.area.value = document.conteudo.area.value;
			  frames[i-1].document.anexo.data_publicacao.value = document.conteudo.data_publicacao.value;
			  frames[i-1].document.anexo.observacao.value = document.conteudo.observacao.value;			  			  

              frames[i-1].document.anexo.submit();
              frames[i-1].document.anexo.reset();		  
			  frames[i-1].startProgress();
          }
	   }
*/
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

  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI&Ccedil;&Atilde;O &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO não foi selecionado.\n";
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

function critica_altera_licitacao(f)
{
  var msg = "";

  if (f.numPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N&Uacute;MERO DO PREG&Atilde;O &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.anoPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PREG&Atilde;O &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI&Ccedil;&Atilde;O DO OBJETO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N&Uacute;MERO DO PROCESSO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO &eacute; de preenchimento obrigat&oacute;rio.\n";
  }
  
  if (!EhData(f.dataAbertura2.value))
  {
     msg = msg + "- A DATA DE ABERTURA n&atilde;o &eacute; v&aacute;lida.\n";
  }
  
  if (f.dataFechamento2.value != "")
  {
	if (!EhData(f.dataFechamento2.value))
  	{
	  msg = msg + "- A DATA DE ENCERRAMENTO n&atilde;o &eacute; v&aacute;lida.\n";
  	}
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
