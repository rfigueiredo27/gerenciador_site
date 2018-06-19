function critica_inclusao_licitacao(f)
{
  var msg = "";
  ext = (f.arquivo.value.substring(f.arquivo.value.lastIndexOf("."))).toLowerCase();

  if (f.numPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00daMERO DO PREG\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PREG\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  else
  {
	  if (f.anoPregao.value.length < 4)
	  	msg = msg + "- O campo ANO DO PREG\u00c3O deve possuir 4 d\u00edgitos.\n";
  }
    
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00daMERO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  else
  {
	  if (f.anoProcesso.value.length < 4)
	  	msg = msg + "- O campo ANO DO PROCESSO deve possuir 4 d\u00edgitos.\n";
  }
 
  if (!EhData(f.dataAbertura.value))
  {
     msg = msg + "- A DATA DE ABERTURA n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  if ((f.dataPublicacao.value=="Publica\u00e7\u00e3o") || (f.dataPublicacao.value==""))
  {
	  f.dataPublicacao.value="";
  }
  else 
  {
  	if (!EhData(f.dataPublicacao.value))
  	{
     	msg = msg + "- xxxA DATA DE Publica\u00e7\u00e3o n\u00e3o \u00e9 v\u00e1lida.\n";
	}
  }
  
/*  if (f.dataFechamento.value != "")
  {
	if (!EhData(f.dataFechamento.value))
  	{
	  msg = msg + "- A DATA DE ENCERRAMENTO n\u00e3o \u00e9 v\u00e1lida.\n";
  	}
  }*/
  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00c3O DO OBJETO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
  }
/*  if (ext!=".pdf")
  {
     msg = msg + "- O ARQUIVO deve ser PDF!.\n";
  }*/

  
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
  ext = (f.anexo.value.substring(f.anexo.value.lastIndexOf("."))).toLowerCase();
  if (f.descricao_anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI&C\u00c7O \u00e9 de preenchimento obrigat\u00f3rio.\n";
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

function critica_altera_licitacao(f)
{
  var msg = "";

  if (f.numPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00daMERO DO PREG\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoPregao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PREG\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.descricao_dados.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI\u00c7\u00c3O DO OBJETO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N\u00daMERO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO \u00e9 de preenchimento obrigat\u00f3rio.\n";
  }
  
  if (!EhData(f.dataAbertura2.value))
  {
     msg = msg + "- A DATA DE ABERTURA n\u00e3o \u00e9 v\u00e1lida.\n";
  }
  
 /* if (f.dataFechamento2.value != "")
  {
	if (!EhData(f.dataFechamento2.value))
  	{
	  msg = msg + "- A DATA DE ENCERRAMENTO n\u00e3o \u00e9 v\u00e1lida.\n";
  	}
  }*/
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
	  startProgress();
  }
  else
  {
     alert("Ocorreram os seguintes erros:\n\n" + msg);
	 return false;
  }
  
}
