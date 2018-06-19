<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
$(document).ready(function(){
		//$( document ).tooltip();
	$( "#tabs" ).tabs();
});


 
function listar()
{
	if (document.fbusca.inscricao.value == "0")
	{
		alert("Escolha uma inscri&ccedil;&atilde; para prosseguir.");
	}
	else
	{
		document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
		$.post("/gecoi.3.0/apps/inscricoes_cre/lista_inscricao.jsp", { vinscricao: document.fbusca.inscricao.value }, function(resposta) {$("#divbusca").html(resposta);zera_contador();});
	}
}



</script>
<div id='tabs'>
	<ul>
		<li><a id="abaListar" href='#tabs-1' onclick="" tabindex="1">Inscri&ccedil;&otilde;es Realizadas</a></li>
		
	</ul>
	<div id='tabs-1'>
		<%@include file="consulta_inscricao.jsp"%>
	</div>
	
</div>
