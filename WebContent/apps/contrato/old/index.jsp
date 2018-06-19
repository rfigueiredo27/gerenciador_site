<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<link rel="stylesheet" type="text/css" href="../css/anexos.css" />

<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script src="/gecoi.3.0/apps/contrato/scripts/criticas.js"> </script>
   
<script>
$(document).ready(function(){
		//$( document ).tooltip();  
		$( "#tabs" ).tabs();
		$( "#tabs2" ).tabs();
	});


function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/contrato/lista_contrato.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);$( "#tabsx" ).tabs();});
}

function listarContrato()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp", { vtexto: document.fbusca2.texto.value, vano: document.fbusca2.ano.value }, function(resposta) {$("#divbusca2").html(resposta);$( "#tabsx" ).tabs();});
}

</script>
<div id='tabs'>
	<ul>
		<li tabindex='1'><a href='#tabs-1' onclick="" >Contratos gerados por licita&ccedil;&atilde;o</a></li>
		<li tabindex='2'><a href='#tabs-2' onclick="">Contratos gerados sem licita&ccedil;&atilde;o</a></li>
	</ul>
	<div id='tabs-1'>
		<h1>Cadastro de Contratos e Aditivos</h1>
   		<jsp:useBean id="listaLicitacao" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
   		<c:set var="anos" value="${listaLicitacao.getAnos(sessionScope['login'], sessionScope['senha'])}" />
		<form name="fbusca" method="post" target="divbusca" >
			<p>Selecione o ano da licitação:</p>
			<select name="ano">
        		<option>-----------</option>
        		<c:forEach var="ano" items="${anos}">
        			<option value="${ano}">${ano}</option>
        		</c:forEach>
        	</select>
           
        	<p>Palavra Chave</p>
        	<input name="texto" type="text" size="35" maxlength="150" />
        	<input type="button" name="buscar" id="buscar" value="buscar" onclick="listar();" />
		</form>
   		<div id="divbusca"></div>
	</div>
	<div id='tabs-2'>
    	Ainda em implementação.
	</div>
