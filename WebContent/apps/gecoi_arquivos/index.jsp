<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/gecoi_arquivos/scripts/criticas.js" charset="UTF-8"></script>

<!-- <script src="/gecoi.3.0/apps/gecoi_arquivos/scripts/icheck.js"></script> -->
<!-- <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> -->
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="/gecoi.3.0/scripts/summernote/summernote.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/summernote/summernote.js"></script>
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/manutencao.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/troca_status.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/extrato_aba.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/altera_dados.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/css/tabela_gecoi.css" />
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/relatorio.css" />
<link href="/gecoi.3.0/apps/gecoi_arquivos/css/grey.css" rel="stylesheet">
<link rel="stylesheet" media="all" type="text/css"	href="/gecoi.3.0/apps/gecoi_arquivos/css/gecoi.css" />


<script>

	$( function() {
	    $( "#dataPublicacao" ).datepicker();
	    $( "#dataPublicacao2" ).datepicker();
	    $( "#dataPublicacao3" ).datepicker();
	  } );
	
	$(document).ready(function() {
		//$( document ).tooltip();  
		$("#tabs").tabs();
		$("#tabs2").tabs();
		$("#abaIncluir").focus();
	});

	function listar(f) {
		var msg = "";
		if (document.fbusca.area.value == "0") {
			msg = msg + "Escolha uma area para prosseguir.\n";

		}
		if (document.fbusca.ano.value == "0") {
			msg = msg + "Escolha um ano para prosseguir.\n";

		}
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/gecoi_arquivos/lista_arquivos.jsp", {
				ano : document.fbusca.ano.value,
				area : document.fbusca.area.value
			}, function(resposta) {
				$("#divbusca").html(resposta);
				zera_contador();
			});
		} else
			alert("Ocorreram os seguintes erros:\n\n" + msg);
	}

	function critica_inclusao_registro(f, ar) {
		var msg = "";
		ext = (ar.substring(ar.lastIndexOf("."))).toLowerCase();
		if (f.descricao.value == "") {
			msg = msg + "- A DESCRI\u00c7\u00c3O deve ser preenchida.\n";
		}
		if (f.anexo.value.replace(/^\s*|\s*$/g, "") == "") {
			msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
		}

		//Se não houver mensagens de erro o submit e acionado no form correspondente
		if (msg.replace(/^\s*|\s*$/g, "") == "") {
			f.submit();
			startProgress();
		}

		else {
			alert("Ocorreram os seguintes erros:\n\n" + msg);
			return false;
		}

	}

	function atualiza_ano_status(f) {
		$.post("/gecoi.3.0/apps/gecoi_arquivos/lista_ano_status.jsp", {
			area : f.area.options[f.area.selectedIndex].value
		}, function(resposta) {
			$("#divAnoStatus").html(resposta);
			zera_contador();
		});
	}
</script>
<script>
	
	
	function inicia_editor(campo){
		$('#'+campo).summernote({
			minHeight: 600,
			disableResize: true,
			placeholder: "Texto da reportagem...",
			//airMode: true,
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    //['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
				['insert', ['link', 'picture', 'video']],
			    ['imagesize', ['imageSize100', 'imageSize50', 'imageSize25']],
			    //['float', ['floatLeft', 'floatRight', 'floatNone']],
			    ['remove', ['removeMedia']],
				['view', ['fullscreen', 'codeview']],
				['table', ['table']]
			]
	  	});
	}
</script>

<div id='tabs'>
	<ul>
		<li><a href='#tabs-1' onclick="" title="Inclusão de Arquivo"
			id="">Inclusão de Arquivos</a></li>
		<li><a href='#tabs-2' onclick="" title="Manutenção de Arquivos">Manutenção</a></li>
	</ul>
	<div id='tabs-1' align="center">
		<div id='tabs2'>
			<ul>
				<li><a href='#tabs-11' onclick="" title="Inclusão 1" id="">Arquivos
						com a mesma data</a></li>
				<li><a href='#tabs-12' onclick="" title="Inclusão 2" id="">Arquivos
						com datas diferentes</a></li>
				<li><a href='#tabs-13' onclick="" title="Inclusão 3" id="">Arquivos
						com anexos</a></li>
			</ul>
			<div id='tabs-11'>
				<%@include file="incluir_novo.jsp"%>
			</div>
			<div id='tabs-12'>
				<%@include file="incluir_novo2.jsp"%>
			</div>
			<div id='tabs-13'>
				<%@include file="incluir_novo3.jsp"%>
			</div>
		</div>
	</div>
	<div id="tabs-2" align="center">
		<%@include file="manutencao.jsp"%>
	</div>
</div>

<script src="/gecoi.3.0/apps/gecoi_arquivos/scripts/validator.js" charset="UTF-8"></script>
