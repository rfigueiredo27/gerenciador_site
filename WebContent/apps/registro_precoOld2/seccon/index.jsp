<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script src="/gecoi.3.0/apps/registro_preco/scripts/criticas.js" charset="UTF-8"></script>

   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
    <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/registro_preco/css/registro_preco.css" />
   
<script>
$(document).ready(function(){
		//$( document ).tooltip();
	$( "#tabs" ).tabs();
});


 
function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/registro_preco/seccon/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);zera_contador();});
}


function listarAta()
{
	document.getElementById("divbuscaAta").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/registro_preco/seccon/lista_ata.jsp", { vtexto: document.fbuscaAta.texto_ata.value, vano: document.fbuscaAta.ano_ata.value }, function(resposta) {$("#divbuscaAta").html(resposta);zera_contador();});
}


</script>
<div id='tabs' >
	<ul>
		<li ><a id="abaIncluir" href='#tabs-1' onclick="" tabindex="1" >Cadastro de Atas de Registro de Pre&ccedil;os</a></li>
		<li ><a href='#tabs-2' onclick="">Troca de Refer&ecirc;ncia</a></li>
		<li ><a href='#tabs-3' onclick="">Controle de Ata</a></li>
	</ul>
	<div id='tabs-1'>
   		<%@include file="cadastro_ata.jsp"%>
	</div>
	<div id='tabs-2'>
   		<%@include file="troca_referencia.jsp"%>
	</div>
	<div id='tabs-3'>
   		<%@include file="/apps/registro_preco/controle_ata.jsp"%>
	</div>
</div>
  