<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>

<script src="/gecoi.3.0/apps/contrato/scripts/criticas.js" charset="UTF-8"> </script>
<script src="/gecoi.3.0/apps/contrato/scripts/icheck.js"></script>

<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/contrato/css/contrato.css" />
<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/contrato/css/contrato_sem_licitacao.css" />
<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/contrato/css/grey.css" />

<script>
$(document).ready(function(){
		//$( document ).tooltip();  
		$( "#tabs" ).tabs();
		$( "#tabs2" ).tabs();
		$( "#vigenciaIni4" ).datepicker();
		$( "#vigenciaFim4" ).datepicker();
		$( "#dataPublicacao4" ).datepicker();
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
		$.post("/gecoi.3.0/apps/contrato/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);$( "#tabsx" ).tabs();zera_contador();});
	}
}

function listarContrato()
{
	if (document.fbuscaContrato.ano_contrato.value == "0")
	{
		alert("Escolha um ano para prosseguir.");
	}
	else
	{
		document.getElementById("divbuscaContrato").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
		$.post("/gecoi.3.0/apps/contrato/lista_contrato_referencia.jsp", { vtexto: document.fbuscaContrato.texto_contrato.value, vano: document.fbuscaContrato.ano_contrato.value }, function(resposta) {$("#divbuscaContrato").html(resposta);zera_contador();});
	}
}

function listarContratoSemLicitacao()
{
	if (document.fbusca2.ano.value == "0")
	{
		alert("Escolha um ano para prosseguir.");
	}
	else
	{
		if (document.fbusca2.tipo[0].checked)
			ptipo = "todos";
		else
			if (document.fbusca2.tipo[1].checked)
				ptipo = "adesao";
			if (document.fbusca2.tipo[2].checked)
				ptipo = "direta";
		document.getElementById("divbusca2").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
		$.post("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp", { texto: document.fbusca2.texto.value, ano: document.fbusca2.ano.value, tipo: ptipo }, function(resposta) {$("#divbusca2").html(resposta);$( "#tabsx" ).tabs();zera_contador();});
	}
}

function criticaInclusaoSemLicitacao()
{
	critica_inclusao_contrato_sem_licitacao(document.finclusao);
	zera_contador();
}

function atualizaTela()
{
	limpaProgress();	
	document.getElementById("contadorDescricao").innerHTML = "";
	document.getElementById("contadorObservacao").innerHTML = "";
	document.finclusao.reset();
	zera_contador();
}

</script>
<script>
$(document).ready(function(){
  $('input').iCheck({
    checkboxClass: 'icheckbox_flat-grey',
    radioClass: 'iradio_flat-grey'
	
  });
});
</script>
<div id='tabs'>
	<ul>
		<li tabindex='1'><a href='#tabs-1' onclick="" >Contratos gerados por licita&ccedil;&atilde;o</a></li>
		<li tabindex='2'><a href='#tabs-2' onclick="">Contratos gerados sem licita&ccedil;&atilde;o</a></li> 
		<li tabindex='3'><a href='#tabs-3' onclick="">Troca de Refer&ecirc;ncia</a></li>
	</ul>
	<div id='tabs-1'>
		<%@include file="contratos_por_licitacao.jsp"%>
	</div>
	<div id='tabs-2'>
		<%@include file="contratos_sem_licitacao.jsp"%>
	</div>
	<div id='tabs-3'>
    	<%@include file="troca_referencia.jsp"%>
	</div>
  	
</div>
