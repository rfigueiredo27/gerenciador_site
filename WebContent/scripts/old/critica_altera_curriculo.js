function criticaCurriculo(f)
{
	  var msg = "";

	  if ((f.nomeArquivo.value.replace(/^\s*|\s*$/g,"")!="") && (f.x1.value == "-"))
	  {
		  msg = msg + "- � necess�rio marcar a �rea da foto";
	  }
	  //Se n�o houver mensagens de erro o submit e acionado no form correspondente
	  if (msg.replace(/^\s*|\s*$/g,"")=="")
	  {
		  //document.fcurriculo.submit();
		  f.submit();
	  }
	  else
	  {
		  alert("Ocorreram os seguintes erros:\n\n" + msg);
		  return false;
	  }

}