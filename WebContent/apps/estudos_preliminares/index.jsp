<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script src="/gecoi.3.0/apps/estudos_preliminares/scripts/criticas.js"
	charset="UTF-8"></script>

<script type="text/javascript"
	src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/registro_preco/css/registro_preco.css" />

<script>
$(document).ready(function(){
		//$( document ).tooltip();
	$( "#tabs" ).tabs();
});


 
function listar()
{
	if (document.fbusca.ano.value == "0")
	{
		alert("Escolha um ano para prosseguir.");
	}
	else
	{
		document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
		$.post("/gecoi.3.0/apps/estudos_preliminares/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);zera_contador();});
	}
}



</script>
<div id='tabs'>
	<ul>
		<li><a id="abaIncluir" href='#tabs-1' onclick="" tabindex="1">Estudos preliminares de TI</a></li>
		
	</ul>
	<div id='tabs-1'>
		<%@include file="cadastro_estudo_preliminar.jsp"%>
	</div>
	
</div>
