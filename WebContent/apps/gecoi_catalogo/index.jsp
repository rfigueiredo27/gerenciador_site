<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/gecoi_catalogo/scripts/criticas.js" charset="UTF-8"></script>
<script src="/gecoi.3.0/apps/gecoi_catalogo/scripts/referencia.js" charset="UTF-8"></script>

<!-- <script src="/gecoi.3.0/apps/gecoi_catalogo/scripts/icheck.js"></script> -->
<!-- <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> -->
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="/gecoi.3.0/scripts/summernote/summernote.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/summernote/summernote.js"></script>
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_catalogo/css/altera_dados.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/tabela_gecoi.css" />
<link href="/gecoi.3.0/apps/gecoi_catalogo/css/grey.css" rel="stylesheet">
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_catalogo/css/gecoi.css" />

<script>
	$(document).ready(function() {
		//$( document ).tooltip();  
		$("#tabs").tabs();
		$("#abaIncluir").focus();
	});

	function listar(f) {
		var msg = "";
 		if (document.fbusca.grupo.value == "-5") {
 			msg = msg + "Escolha uma Grupo para prosseguir.\n";

 		}
 		if (document.fbusca.catalogo.value == "0") {
 			msg = msg + "Escolha um Catálogo para prosseguir.\n";

 		}
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/gecoi_catalogo/lista_catalogo.jsp", {
				grupo : document.fbusca.grupo.value,
				catalogo : document.fbusca.catalogo.value,
				tipo : document.fbusca.tipo.value,
				area : document.fbusca.area.value,
				ano : document.fbusca.ano.value
				
			}, function(resposta) {
				$("#divbusca").html(resposta);
				zera_contador();
			});
		} else
			alert("Ocorreram os seguintes erros:\n\n" + msg);
	}
	
	function incluir(f) {
		var msg = "";
 		if (document.fbusca.grupo.value == "-5") {
 			msg = msg + "Escolha uma Grupo para prosseguir.\n";

 		}
 		if (document.fbusca.catalogo.value == "0") {
 			msg = msg + "Escolha um Catálogo para prosseguir.\n";

 		}
 		
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/gecoi_catalogo/manutencao_incluir_referencia.jsp", {
				grupo : document.fbusca.grupo.value,
				catalogo : document.fbusca.catalogo.value,
				tipo : document.fbusca.tipo.value,
				area : document.fbusca.area.value,
				ano : document.fbusca.ano.value
				
			}, function(resposta) {
				$("#divbusca").html(resposta);
				zera_contador();
			});
		} else
			alert("Ocorreram os seguintes erros:\n\n" + msg);
	}

	function atualiza_catalogo(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/lista_catalogo_combo.jsp", {
			grupo : f.grupo.options[f.grupo.selectedIndex].value
		}, function(resposta) {
			$("#divCatalogo").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_catalogo_incluir(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/inclusao_carrega_catalogo_combo.jsp", {
			grupo2 : f.grupo2.options[f.grupo2.selectedIndex].value
		}, function(resposta) {
			$("#divCatalogo_Incluir").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_tipo(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/lista_tipo_combo.jsp", {
			grupo : f.grupo.options[f.grupo.selectedIndex].value,
			catalogo : f.catalogo.options[f.catalogo.selectedIndex].value
		}, function(resposta) {
			$("#divTipo").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_unidade_incluir(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/inclusao_carrega_combo_unidades.jsp", {
			tipo : f.tipo2.options[f.tipo2.selectedIndex].value
		}, function(resposta) {
			$("#divTipo_incluir").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_area(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/lista_area_combo.jsp", {
			grupo : f.grupo.options[f.grupo.selectedIndex].value,
			catalogo : f.catalogo.options[f.catalogo.selectedIndex].value,
			tipo : f.tipo.options[f.tipo.selectedIndex].value
		}, function(resposta) {
			$("#divArea").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_area_inclusao(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/inclusao_carrega_combo_areas.jsp", {
			unidade : f.unidade2.options[f.unidade2.selectedIndex].value,
			tipo : f.tipo2.options[f.tipo2.selectedIndex].value
		}, function(resposta) {
			$("#divArea_incluir").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_ano(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/lista_ano_combo.jsp", {
			grupo : f.grupo.options[f.grupo.selectedIndex].value,
			catalogo : f.catalogo.options[f.catalogo.selectedIndex].value,
			tipo : f.tipo.options[f.tipo.selectedIndex].value,
			area : f.area.options[f.area.selectedIndex].value
		}, function(resposta) {
			$("#divAno").html(resposta);
			zera_contador();
		});
	}
	
	function atualiza_ano_inclusao(f) {
		$.post("/gecoi.3.0/apps/gecoi_catalogo/inclusao_carrega_combo_ano.jsp", {
			grupo : f.unidade2.options[f.unidade2.selectedIndex].value,
			area : f.area2.options[f.area2.selectedIndex].value,
			tipo : f.tipo2.options[f.tipo2.selectedIndex].value,
		}, function(resposta) {
			$("#divAno_incluir").html(resposta);
			zera_contador();
		});
	}
	
	
</script>

<div id='tabs'>
	<ul>
		<li><a href='#tabs-1' onclick="" title="Manutenção">Manutenção de Catálogo</a></li>
		<li><a href='#tabs-2' onclick="" title="Manutenção">Incluir Conteúdo no Catálogo </a></li>
	</ul>
	
	<div id="tabs-1" style="min-height: 500px">
		<%@include file="manutencao.jsp"%>
	</div>
	
	<div id="tabs-2" style="min-height: 500px">
		<%@include file="incluir.jsp"%>
	</div>
</div>

<script src="/gecoi.3.0/apps/gecoi_catalogo/scripts/validator.js" charset="UTF-8"></script>
