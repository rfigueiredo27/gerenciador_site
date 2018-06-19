<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<%
//String vimagem = (request.getParameter("imagem") == null) ? "/gecoi.3.0/img/adicionar.png" : ("/gecoi.3.0/webtemp/" + request.getParameter("imagem"));
String vimagem = "/gecoi.3.0/img/adicionar.png";

%>

	<!-- usado no destaques_intranet -->
	<script type="text/javascript" src="/gecoi.3.0/apps/destaques_intranet/scripts/critica_destaque.js"></script>
    
	<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/contrato/css/grey.css" />
    <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/tabela_gecoi.css" />
     

<script>

$(document).ready(function(){
	$( "#tabs" ).tabs();  	
	$("#dataIni").datepicker();
	$("#dataFim").datepicker();
	  $("#publicado").keypress(function (e) {
		     //if the letter is not digit then display error and don't type anything
		     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
		        //display error message
		        $("#errmsg").html("Digits Only").show().fadeOut("slow");
		               return false;
		    }
		   });
});


function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/destaques_intranet/lista_destaque.jsp", { vtexto: document.fbusca.descricao.value, vativo: document.fbusca.ativos.value }, function(resposta) {$("#divbusca").html(resposta);});
}

function listaSimples()
{
	$.post("/gecoi.3.0/apps/destaques_intranet/lista_destaque_simples.jsp", function(resposta) {$("#divListaSimples").html(resposta);});
}

</script>
<div id='tabs'>
   <ul>
      <li tabindex='2'><a href='#tabs-1' onclick="listaSimples();" >Incluir novo</a></li>
      <li tabindex='2'><a href='#tabs-2' onclick="">Banners cadastrados</a></li>
   </ul>
   <div id='tabs-1'>
   		<form name="fdestaque" action="/gecoi.3.0/GravaNovoDestaque" method="post"  target="processa_background" enctype="multipart/form-data">
            <fieldset>
            	<legend>Imagem do banner a ser incluso</legend>
	            <input type="file" name="arquivo" id="arquivo" />
				<div id="progressBar" style="display: none;">
            		<div id="theMeter">
                		<div id="progressBarText"></div>
                		<div id="progressBarBox">
                    		<div id="progressBarBoxContent"></div>
               			</div>
            		</div>
         		</div>
             </fieldset>
        	<fieldset>
            	<legend>Descri&ccedil;&atilde;o do banner</legend>
	            <input name="descricao" id="descricao" type="text" maxlength="1000" />
            </fieldset>
            <fieldset>
        		<legend> Link (opcional)</legend>
	            Digite o endereço: <input name="link" id="link" type="text" maxlength="1000" /> OU
	            Escolha um arquivo: <input type="text" name="descricaoAnexo" id="descricaoAnexo" /><input type="file" name="anexo" id="anexo" />
                <div id="progressBar2" style="display: none;">
                    <div id="theMeter2">
                        <div id="progressBarText2"></div>
                        <div id="progressBarBox2">
                            <div id="progressBarBoxContent2"></div>
                        </div>
                    </div>
                 </div>

            </fieldset>
            <fieldset>
        		<legend>Selecione o target</legend>
					<label for="alvo"></label>
					<select name="alvo" id="alvo">
						<option value="_blank">blank</option>
						<option value="_self">self</option>
					</select>
			</fieldset>
            <fieldset>
        		<legend>Data in&iacute;cio da publica&ccedil;&atilde;o</legend>
	            <input name="dataIni" id="dataIni" type="text" maxlength="10" />
            </fieldset>
            <fieldset>
        		<legend>Data fim da publica&ccedil;&atilde;o</legend>
	            <input name="dataFim" id="dataFim" type="text" maxlength="10" />
            </fieldset>
            <fieldset>
        		<legend>Ordem de exibição na TV</legend>
	            <input name="publicado" id="publicado" type="text" maxlength="1" value="1" /><br>
            </fieldset>
            <fieldset>
            	<legend>Destaques ativos</legend>
	            <div id="divListaSimples"></div>
            </fieldset>
            <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaDestaque(this.form);"  />             
        </form>
   </div> 
  
   <div id="tabs-2">
   		<form name="fbusca" method="post" target="divbusca" >
        	<fieldset>
   				<legend>Busca por</legend>
	   			<input name="descricao" id="descricao" type="text" maxlength="1000" /><br>
		      	<input type="radio" name="ativos" id="ativos" value="1" />Ativos
	    	  	<input type="radio" name="ativos" id="ativos" value="0" />Inativos
 	      		<input type="radio" name="ativos" id="ativos" value="todos" checked="checked"/>Todos
	   			<input type="button" name="buscar" id="buscar" value="buscar" onclick="listar();" />
            </fieldset>
   		</form>
   		<div id="divbusca"></div>
   </div>
</div>
<script>
	listaSimples();
</script>