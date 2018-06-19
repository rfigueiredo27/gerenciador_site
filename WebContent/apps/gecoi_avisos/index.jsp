<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script src="/gecoi.3.0/apps/gecoi_avisos/scripts/criticas.js"
	charset="UTF-8"> </script>
<script src="/gecoi.3.0/apps/gecoi_avisos/scripts/icheck.js"></script>
<script type="text/javascript"
	src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/incluir_novo.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/manutencao.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/troca_status.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/extrato_aba.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/altera_dados.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/css/tabela_gecoi.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/css/relatorio.css" />
<link href="/gecoi.3.0/apps/gecoi_avisos/css/grey.css" rel="stylesheet">



<script>
   $(document).ready(function(){
   		//$( document ).tooltip();  
   		$( "#tabs" ).tabs();		
   		$("#abaIncluir").focus();
   	});
   	
   
   
   function listar(f)
   {
   	var msg = "";	
   	if (document.fbusca.area.value == "0")
   	{
   		msg = msg + "Escolha uma area para prosseguir.\n";
   		
   	}
   	if(document.fbusca.ano.value == "0")
   	{
   		msg = msg + "Escolha um ano para prosseguir.\n";
   		
   	}
   	if (msg.replace(/^\s*|\s*$/g,"")=="")
   	{
   		document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
   		$.post("/gecoi.3.0/apps/gecoi_avisos/lista_avisos.jsp", { ano: document.fbusca.ano.value, area: document.fbusca.area.value}, function(resposta) {$("#divbusca").html(resposta);zera_contador();});
   	}
   	else alert("Ocorreram os seguintes erros:\n\n" + msg);
   }
   
   function critica_inclusao_registro(f,ar)
   {
     var msg = "";
     ext = (ar.substring(ar.lastIndexOf("."))).toLowerCase();
     if (f.descricao.value == "")
     {
   	  msg = msg + "- A DESCRI\u00c7\u00c3O deve ser preenchida.\n";
     }
     if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
     {
        msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
     }
     
     //Se não houver mensagens de erro o submit e acionado no form correspondente
     if (msg.replace(/^\s*|\s*$/g,"")=="")
     {  
   	  f.submit();
   	  startProgress();
     }
     
     else
     {
        alert("Ocorreram os seguintes erros:\n\n" + msg);
   	 return false;
     }
     
   }
   
   function atualiza_ano_status(f)
   {
   	$.post("/gecoi.3.0/apps/gecoi_avisos/lista_ano_status.jsp", {area: f.area.options[f.area.selectedIndex].value }, function(resposta) {$("#divAnoStatus").html(resposta);zera_contador();});
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
		<li><a href='#tabs-1' onclick="" title="Incluir novo"
			id="abaIncluir">Incluir Novo Aviso</a></li>
		<li><a href='#tabs-2' onclick=""
			title="Licita&ccedil;&otilde;es cadastradas">Manutenção de Avisos</a></li>
		<!--<li><a href='#tabs-4' onclick="" title="Troca status">Troca status</a></li>
         <li><a href='#tabs-5' onclick="atualiza_ano_extrato();" title="Extrato">Extrato</a></li>-->
	</ul>
	<div id='tabs-1' align="center">
		<%@include file="incluir_novo.jsp"%>
	</div>
	<div id="tabs-2" align="center">
		<%@include file="manutencao.jsp"%>
	</div>
</div>
<script src="/gecoi.3.0/apps/gecoi_avisos/scripts/validator.js"></script>