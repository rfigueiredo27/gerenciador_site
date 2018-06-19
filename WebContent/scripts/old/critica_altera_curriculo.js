function criticaCurriculo(f)
{
	  var msg = "";

	  if ((f.nomeArquivo.value.replace(/^\s*|\s*$/g,"")!="") && (f.x1.value == "-"))
	  {
		  msg = msg + "- É necessário marcar a área da foto";
	  }
	  //Se não houver mensagens de erro o submit e acionado no form correspondente
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