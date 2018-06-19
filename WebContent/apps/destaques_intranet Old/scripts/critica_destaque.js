function criticaDestaque(f)
{
	  var msg = "";

	  //verifica se campo nome está vazio
	  if (f.descricao.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo Descrição é de preenchimento obrigatório.\n";
	  }
	  //verifica se campo foto está vazio
	  if (f.nomeArquivo.value.replace(/^\s*|\s*$/g,"")=="")
	  {
	     msg = msg + "- O campo Banner é de preenchimento obrigatório.\n";
	  }
	  if ((f.nomeArquivo.value.replace(/^\s*|\s*$/g,"")!="") && (f.x1.value == "-"))
	  {
		  msg = msg + "- É necessário marcar a área do banner";
	  }
	  //Se não houver mensagens de erro o submit e acionado no form correspondente
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