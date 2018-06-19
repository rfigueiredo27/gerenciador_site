function atualizaTela()
{
	//if (pnumAta != '0')
		//alert("Foi gravada a ata de número " + pnumAta);
	carregaPag("/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + "&nPregao=" + document.fincAnexo.numPregao.value + "&edital=" + document.fincAnexo.edital.value, "divbusca");
}


function criticaAnexo(ar)
{
	critica_inclusao_registro(document.fincAnexo,ar);
		
}

$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
});