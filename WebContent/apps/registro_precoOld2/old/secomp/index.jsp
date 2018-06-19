<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script src="/gecoi.3.0/apps/registro_preco/scripts/criticas.js"> </script>

   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
<script>
$(document).ready(function(){
		//$( document ).tooltip();  
	});


 
 function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/registro_preco/secomp/lista_registro.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);});
}


</script>
<h1>Cadastro de Atas de Registro de Pre&ccedil;os</h1>
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

  