<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/intimacao_pje/scripts/criticas.js" charset="UTF-8"></script>
<script src="/gecoi.3.0/apps/intimacao_pje/scripts/jquery.maskedinput.js" charset="UTF-8"></script>
<script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> 
<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/intimacao_pje/css/gecoi.css" />

<!-- CKEditor -->
<script src="/gecoi.3.0/scripts/ckeditor/ckeditor.js"></script>

<script>
	$(document).ready(function() {
		//$( document ).tooltip();  
		$("#tabs").tabs();
		$("#abaIncluir").focus();
		$("#data_envio").datetimepicker({
			controlType: 'select',
			timeFormat: 'HH:mm',
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true																	
		});
	});
	
	function listar(f) {
		var msg = "";
		
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/intimacao_pje/manutencao.jsp", {
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
		<li><a href='#tabs-1' onclick="" title="Envio de Email">Envio de E-mail</a></li>
		<li><a href='#tabs-2' onclick="" title="Lista de Envios">Lista de Envios</a></li>
	</ul>
	
	<div id="tabs-1" style="min-height: 500px">
		<%@include file="enviar_email.jsp"%>
	</div>
	
	<div id="tabs-2" style="min-height: 500px">
		<%@include file="listar_envios.jsp"%>
	</div>
</div>