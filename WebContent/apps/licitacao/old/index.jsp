<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/licitacao/scripts/criticas.js"> </script>
<script src="/gecoi.3.0/apps/licitacao//scripts/icheck.js"></script>

   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> 
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/incluir_novo.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/licitacoes_cadastradas.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/relatorio.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/troca_status.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/extrato_aba.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/licitacao/css/altera_dados.css" />
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/tabela_gecoi.css" />
   <link href="/gecoi.3.0/apps/licitacao/css/grey.css" rel="stylesheet">

<script>

$(document).ready(function(){
		//$( document ).tooltip();  
		$( "#dataFechamento" ).datepicker();
		$( "#tabs" ).tabs();
		  $("input[name*='num']").keypress(function (e) {
			     //if the letter is not digit then display error and don't type anything
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			        //display error message
			        $("#errmsg").html("Digits Only").show().fadeOut("slow");
			               return false;
			    }
			   });
		  $("input[name*='ano']").keypress(function (e) {
			     //if the letter is not digit then display error and don't type anything
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			        //display error message
			        $("#errmsg").html("Digits Only").show().fadeOut("slow");
			               return false;
			    }
			   });
		$("#abaIncluir").focus();
	});

function trocaFiltro()
{
	$("#divfiltro").css("visibility", "hidden");
	
	if (document.fbusca.filtro.value == "---")
	{
		document.getElementById("spanfiltro").innerHTML = "opcional<select name='filtrovalor' id='filtrovalor' style='visibility:hidden;'></select>";
	}
	else
		if (document.fbusca.filtro.value == "modalidade")
		{
			$("#legenda").html("Modalidade");
			$("#divfiltro").css("visibility", "visible");
			document.getElementById("spanfiltro").innerHTML = "<select name='filtrovalor'>" +
															 "<option value='1021'>Concorrência Pública</option>" +
															 "<option value='882'>Pregão Eletrônico</option>" +
															 "<option value='883'>Pregão Eletrônico por Registro de Preço</option>" +
															 "<option value='885'>Pregão Presencial</option>" +
															 "<option value='886'>Pregão Presencial por Registro de Preço</option>" +
															 "<option value='887'>Tomada de Preço</option>" +
															 "</select>";
		}
		else
			if (document.fbusca.filtro.value == "abertura")
			{				
 			   //document.getElementById("divfiltro").innerHTML = "<input name='filtrovalor' type='text' class='form-text pictureInput' id='datepicker' size='12' maxlength='10' style='' />";
 			   document.getElementById("spanfiltro").innerHTML = "<input name='filtrovalor' type='text' size='10' maxlength='10' style='' id='datepicker' />";
 			   $('#datepicker').datepicker({changeMonth: true,changeYear: true	});
			   $("#divfiltro").css("visibility", "visible");
			   $("#legenda").html("Data");  
			}
			
			else
				if (document.fbusca.filtro.value == "situacao")
				{
					$("#legenda").html("Situação");
					$("#divfiltro").css("visibility", "visible");
					document.getElementById("spanfiltro").innerHTML = "<select name='filtrovalor'>" +
															 		 "<option value='Publicado'>Publicado</option>" +
															 		 "<option value='Aberto'>Aberto</option>" +
															 		 "<option value='Concluído'>Concluído</option>" +
																	  "<option value='Suspenso'>Suspenso</option>" +
															 		 "</select>";
				}
}

function listar(f)
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/licitacao/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value, vfiltro: document.fbusca.filtro.value, vfiltroValor: document.fbusca.filtrovalor.value }, function(resposta) {$("#divbusca").html(resposta);zera_contador();});
}

function atualiza_ano()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value }, function(resposta) {$("#divAno").html(resposta);zera_contador();});
}

function atualiza_descricao()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_descricao.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value, ano: document.frelatorio.ano.options[document.frelatorio.ano.selectedIndex].value }, function(resposta) {$("#divDescricao").html(resposta);zera_contador();});
}

function imprime()
{
	$.post("/gecoi.3.0/apps/licitacao/emitir_relatorio_controle.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value, ano: document.frelatorio.ano.options[document.frelatorio.ano.selectedIndex].value, idArquivo: document.frelatorio.descricao.value }, function(resposta) {$("#divrelatorio").html(resposta);zera_contador();});
}

function atualiza_ano_status(f)
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano_status.jsp", {area: f.area.options[f.area.selectedIndex].value }, function(resposta) {$("#divAnoStatus").html(resposta);zera_contador();});
}

function carrega_edital(f)
{
	if ((f.ano.value != 0) && (f.area.value != 0))
	{
		document.getElementById("divStatus").innerHTML = "Carregando Resultados";
   		if (f.filtro[0].checked)
      		pfiltro = "A";
   		else
      		if (f.filtro[1].checked)
	     		pfiltro = "E";
	  		else
	     		if (f.filtro[2].checked)
            		pfiltro = "S";
	  			else
	     			if (f.filtro[3].checked)
            			pfiltro = "T";

   		$.post("/gecoi.3.0/apps/licitacao/lista_status.jsp", {area: f.area.value, ano: f.ano.value, filtro: pfiltro }, function(resposta) {$("#divStatus").html(resposta);zera_contador();});
	}
}

function concluir(pacao, pconteudo)
{
	var pdiv = "divbotao" + pconteudo;
   document.getElementById(pdiv).innerHTML = "Concluindo...";
   $.post("/gecoi.3.0/apps/licitacao/processa_status.jsp", {idConteudo: pconteudo, acao: pacao }, function(resposta) {$("#" + pdiv).html(resposta);zera_contador();});
}

function atualiza_ano_extrato()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano_extrato.jsp", function(resposta) {$("#divAnoExtrato").html(resposta);zera_contador();});
}

function listarExtrato(f)
{

   document.getElementById("divExtrato").innerHTML = "Carregando Resultados";

   valor = Math.random();
   pag = "/gecoi.3.0/apps/licitacao/lista_extrato.jsp";
   if (f.filtro.value != "---")
   	{
		
		$.post(pag, {'ano': f.ano.value, 'chave':f.chave.value, 'filtro':f.filtro.value,'filtrovalor':f.filtrovalor.value}, function(resposta) {
	     $("#divExtrato").html(resposta);
		  //tb_init("#divExtrato a.thickbox")
		  zera_contador();
		  })
		  ;
   	}
   else
   	{
		$.post(pag, {'ano': f.ano.value, 'chave':f.chave.value}, function(resposta) {
	      $("#divExtrato").html(resposta);
	       //tb_init("#divExtrato a.thickbox");	      
		   zera_contador();
		  })
		  ;
   	}   
}

//função que carrega os arquivos, de acordo com o tipo de filtro selecionado
function trocaFiltroExtrato()
{
	$("#divfiltro2").css("visibility", "hidden");
	if (document.fextrato.filtro.value == "---")
	{
		document.getElementById("spanfiltro2").innerHTML = "opcional<select name='filtrovalor' id='filtrovalor' style='visibility:hidden;'></select>";
	}
		//document.getElementById("divfiltroExtrato").innerHTML = "";
	else
		if (document.fextrato.filtro.value == "modalidade")
		{
			$("#legenda2").html("Modalidade");
			$("#divfiltro2").css("visibility", "visible");
			document.getElementById("spanfiltro2").innerHTML = "<select name='filtrovalor'>" +
															 "<option value='1021'>Concorrência Pública</option>" +
															 "<option value='882'>Pregão Eletrônico</option>" +
															 "<option value='883'>Pregão Eletrônico por Registro de Preço</option>" +
															 "<option value='885'>Pregão Presencial</option>" +
															 "<option value='886'>Pregão Presencial por Registro de Preço</option>" +
															 "<option value='887'>Tomada de Preço</option>" +
															 "</select>";
		}
		else
			if (document.fextrato.filtro.value == "abertura")
			{
				//document.getElementById("divfiltroExtrato").innerHTML = "<input name='filtrovalor' type='text' class='form-text' id='datepicker' size='10' maxlength='10' />";
				document.getElementById("spanfiltro2").innerHTML = "<input name='filtrovalor' type='text' size='10' maxlength='10' style='' id='datepicker' />";
				$('#datepicker').datepicker({changeMonth: true,changeYear: true	});
				$("#divfiltro2").css("visibility", "visible");
			    $("#legenda2").html("Data");  
			}
			else
				if (document.fextrato.filtro.value == "situacao")
				{
					$("#legenda2").html("Situação");
					$("#divfiltro2").css("visibility", "visible");
					document.getElementById("spanfiltro2").innerHTML = "<select name='filtrovalor'>" +
															 		 "<option value='Publicado'>Publicado</option>" +
															 		 "<option value='Aberto'>Aberto</option>" +
															 		 "<option value='Concluido'>Concluído</option>" +
																	  "<option value='Suspenso'>Suspenso</option>" +
															 		 "</select>";
				}
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
<%
	Calendar c = Calendar.getInstance();
	String vano = "" + c.get(Calendar.YEAR);
%>

<div id='tabs'>
<ul>
		<li><a href='#tabs-1' onclick="" title="Incluir novo" id="abaIncluir">Incluir novo</a></li>
		<li><a href='#tabs-2' onclick="" title="Licita&ccedil;&otilde;es cadastradas">Licita&ccedil;&otilde;es cadastradas</a></li>
		<li><a href='#tabs-3' onclick="" title="Download de editais">Download de editais</a></li>
		<li><a href='#tabs-4' onclick="" title="Troca status">Troca status</a></li>
		<li><a href='#tabs-5' onclick="atualiza_ano_extrato();" title="Extrato">Extrato</a></li>
</ul>
<div id='tabs-1'>
<%@include file="incluir_novo.jsp"%>
</div> 
<div id="tabs-2">
<%@include file="licitacoes_cadastradas.jsp"%>
</div>
<div id="tabs-3">
<%@include file="relatorio.jsp"%>		
</div> 
<div id="tabs-4">
<%@include file="troca_status.jsp"%>	
</div>
<div id="tabs-5">
<%@include file="extrato_aba.jsp"%>		
</div>

 