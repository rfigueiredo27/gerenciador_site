<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/acesso_rapido/scripts/criticas.js" charset="UTF-8"></script>
<script src="/gecoi.3.0/apps/acesso_rapido/scripts/referencia.js" charset="UTF-8"></script>
<script src="/gecoi.3.0/apps/acesso_rapido/scripts/jquery.maskedinput.js" charset="UTF-8"></script>

<!-- <script src="/gecoi.3.0/apps/acesso_rapido/scripts/icheck.js"></script> -->
<!-- <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> -->
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/acesso_rapido/css/altera_dados.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/tabela_gecoi.css" />
<link href="/gecoi.3.0/apps/acesso_rapido/css/grey.css" rel="stylesheet">
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/acesso_rapido/css/gecoi.css" />

<script>
	$(document).ready(function() {
		//$( document ).tooltip();  
		$("#tabs").tabs();
		$("#abaIncluir").focus();
		$("input#edital").mask("9999/9999");
		$( "#dataPublicacao2" ).datepicker();
	});
	
	function listar(f) {
		var msg = "";
		
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/acesso_rapido/manutencao.jsp", {
			}, function(resposta) {
				$("#divbusca").html(resposta);
				zera_contador();
			});
		} else
			alert("Ocorreram os seguintes erros:\n\n" + msg);
	}
</script>

<div id='tabs'>
	<ul>
		<li><a href='#tabs-1' onclick="" title="Inclusao">Inclusão</a></li>
		<li><a href='#tabs-2' onclick="" title="Manutenção">Manutenção</a></li>
	</ul>
	
	<div id="tabs-1" style="min-height: 500px">
		<%@include file="incluir.jsp"%>
	</div>
	
	<div id="tabs-2" style="min-height: 500px">
		<%@include file="manutencao.jsp"%>
	</div>
</div>