function criticaDestaque(f)
{
	  var msg = "";

	  //verifica se campo nome est� vazio
	  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo Descri��o � de preenchimento obrigat�rio.\n";
	  }
	  //verifica se campo foto est� vazio
	  if (f.arquivo.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo Banner � de preenchimento obrigat�rio.\n";
	  }
	  //Se n�o houver mensagens de erro o submit e acionado no form correspondente
	  if (msg.replace(/^\s*|\s*$/g,"")=="")
	  {
		  //document.fcurriculo.submit();
		  f.submit();
		  //executar();
	  }
	  else
	  {
		  alert("Ocorreram os seguintes erros:\n\n" + msg);
		  return false;
	  }

}