function critica_inclusao_contrato(f)
{
  var msg = "";

  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (!EhData(f.vigenciaIni.value))
  {
     msg = msg + "- A VIG�NCIA INICIAL n�o � v�lida.\n";
  }
  
  if (!EhData(f.vigenciaFim.value))
  {
     msg = msg + "- A VIG�NCIA FINAL n�o � v�lida.\n";
  }

  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI��O DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  //verifica se o campo data da publica��o � v�lido
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA��O n�o � v�lida.\n";
  }
  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n�o foi selecionado.\n";
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


function critica_altera_aditivo(f)
{
  var msg = "";

  if (!EhData(f.vigenciaIni3.value))
  {
     msg = msg + "- A VIG�NCIA INICIAL n�o � v�lida.\n";
  }
  if (!EhData(f.vigenciaFim3.value))
  {
     msg = msg + "- A VIG�NCIA FINAL n�o � v�lida.\n";
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


function critica_altera_contrato_sem_licitacao(f)
{
  var msg = "";

  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO PROCESSO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (!EhData(f.vigenciaIni.value))
  {
     msg = msg + "- A VIG�NCIA INICIAL n�o � v�lida.\n";
  }
  
  if (!EhData(f.vigenciaFim.value))
  {
     msg = msg + "- A VIG�NCIA FINAL n�o � v�lida.\n";
  }

  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI��O DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  //verifica se o campo data da publica��o � v�lido
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA��O n�o � v�lida.\n";
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


function critica_altera_contrato(f)
{
  var msg = "";

  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  if (!EhData(f.vigenciaIni2.value))
  {
     msg = msg + "- A VIG�NCIA INICIAL n�o � v�lida.\n";
  }
  if (!EhData(f.vigenciaFim2.value))
  {
     msg = msg + "- A VIG�NCIA FINAL n�o � v�lida.\n";
  }
  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI��O DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  //verifica se o campo data da publica��o � v�lido
  if (!EhData(f.dataPublicacao2.value))
  {
     msg = msg + "- A DATA DE PUBLICA��O n�o � v�lida.\n";
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


function critica_inclusao_aditivo(f)
{
  var msg = "";

    
  if (!EhData(f.vigenciaIni4.value))
  {
     msg = msg + "- A VIG�NCIA INICIAL n�o � v�lida.\n";
  }

  if (!EhData(f.vigenciaFim4.value))
  {
     msg = msg + "- A VIG�NCIA FINAL n�o � v�lida.\n";
  }

  if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O ARQUIVO n�o foi selecionado.\n";
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


function critica_inclusao_contrato_sem_licitacao(f)
{
  var msg = "";

  if (f.numProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO PROCESSO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anoProcesso.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO PROCESSO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.numContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo N�MERO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (f.anoContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo ANO DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  if (!EhData(f.vigenciaIni.value))
  {
     msg = msg + "- A VIG�NCIA n�o � v�lida.\n";
  }
  
  if (!EhData(f.vigenciaFim.value))
  {
     msg = msg + "- A VIG�NCIA n�o � v�lida.\n";
  }

  if (f.descContrato.value.replace(/^\s*|\s*$/g,"")=="")
  {
     msg = msg + "- O campo DESCRI��O DO CONTRATO � de preenchimento obrigat�rio.\n";
  }
  
  //verifica se o campo data da publica��o � v�lido
  if (!EhData(f.dataPublicacao.value))
  {
     msg = msg + "- A DATA DE PUBLICA��O n�o � v�lida.\n";
  }
  
/*
   if (id==0)
	  msg = msg + "- Voc� deve adicionar ao menos 1 (um) arquivo para upload.\n";   
   else
   {
      //Verifica se todos os arquivos foram indicados
      for (i=1;i<=id;i++)
      {
         //verifica se a descricao do arquivo i foi fornecida
         if (frames[i-1].document.forms[0].descricao.value.replace(/^\s*|\s*$/g,"")=="")
	     {
		     msg = msg + "- A descri��o do arquivo n� " + i + " n�o foi informada.\n";
   	     }	  

         //verifica se a localiza��o do arquivo i foi fornecida
         if (frames[i-1].document.forms[0].arqanexo.value.replace(/^\s*|\s*$/g,"")=="")
	     {
		     msg = msg + "- A localiza��o do arquivo n� " + i + " n�o foi informada.\n";
  	     }
	  }
	  
   }
  */
  //Se n�o houver mensagens de erro o submit e acionado no form correspondente
  if (msg.replace(/^\s*|\s*$/g,"")=="")
  {  
	  f.submit();
	  startProgress();
/*      //se foi um sucesso verifica se h� arquivos para enviar
       if (id>0)
	   {   
	      //zera a mensagem na tela se houver
		  document.getElementById("mensagem").className = "";
	      document.getElementById("mensagem").innerHTML = "";
		  
		  //Verifica quantos arquivos existem, acerta o id do conte�do (que � igual ao do aviso) de cada um e processa o submit dos formul�rios
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
