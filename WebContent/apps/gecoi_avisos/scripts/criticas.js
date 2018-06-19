function critica_inclusao_aviso(f)
{
  var msg = "";
  ext = (f.arquivo.value.substring(f.arquivo.value.lastIndexOf("."))).toLowerCase();
  
  
  if(f.total_anexos.value.replace(/^\s*|\s*$/g,"")=="0"){
  
	  if (f.destino.value.replace(/^\s*|\s*$/g,"")=="0")
	  {
	     msg = msg + "- O campo DESTINO DA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	  }
	  if (f.descricao_incluir.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo TITULO DO AVISO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	  }
	  if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	  }
  
  }
  
  else
  {
	  if (f.destino.value.replace(/^\s*|\s*$/g,"")=="0")
	  {
	     msg = msg + "- O campo DESTINO DA PUBLICA\u00c7\u00c3O \u00e9 de preenchimento obrigat\u00f3rio.\n";
	  }
	  if (f.descricao_incluir.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo TITULO DO AVISO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	  }
	  if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	  }
  
	  if((f.descricao_anexo.value.replace(/^\s*|\s*$/g,"")!="") && (f.anexo.value.replace(/^\s*|\s*$/g,"")==""))
	  {
		 msg = msg + "- O ANEXO n\u00e3o foi selecionado.\n";
	  }
	  if((f.descricao_anexo.value.replace(/^\s*|\s*$/g,"")=="") && (f.anexo.value.replace(/^\s*|\s*$/g,"")!=""))
	  {
		  msg = msg + "- O campo DESCRI\u00c7\u00c3O DO ANEXO \u00e9 de preenchimento obrigat\u00f3rio.\n";
	  }
	  

  }
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

function critica_altera_avisos(f)
{
  var msg = "";

    
  if (f.descricao_dados.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo n\u00e3o foi preenchido.\n";
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
