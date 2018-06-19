<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>
<script language="javascript" src="/gecoi.3.0/apps/licitacao/scripts/criticas.js" charset="utf-8"> </script>


   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
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
	});

function trocaFiltro()
{
	if (document.fbusca.filtro.value == "---")
		document.getElementById("divfiltro").innerHTML = "opcional<select name='filtrovalor' id='filtrovalor' style='visibility:hidden;'' ></select>";
	else
		if (document.fbusca.filtro.value == "modalidade")
			document.getElementById("divfiltro").innerHTML = "<select name='filtrovalor'>" +
															 "<option value='1021'>Concorrência Pública</option>" +
															 "<option value='882'>Pregão Eletrônico</option>" +
															 "<option value='883'>Pregão Eletrônico por Registro de Preço</option>" +
															 "<option value='885'>Pregão Presencial</option>" +
															 "<option value='886'>Pregão Presencial por Registro de Preço</option>" +
															 "<option value='887'>Tomada de Preço</option>" +
															 "</select>";
		else
			if (document.fbusca.filtro.value == "abertura")
			{				
 			   //document.getElementById("divfiltro").innerHTML = "<input name='filtrovalor' type='text' class='form-text pictureInput' id='datepicker' size='12' maxlength='10' style='' />";
 			   document.getElementById("divfiltro").innerHTML = "<input name='filtrovalor' type='text' size='10' maxlength='10' style='' id='datepicker' />";
 			   $('#datepicker').datepicker({changeMonth: true,changeYear: true	});  
			}
			
			else
				if (document.fbusca.filtro.value == "situacao")
					document.getElementById("divfiltro").innerHTML = "<select name='filtrovalor'>" +
															 		 "<option value='Publicado'>Publicado</option>" +
															 		 "<option value='Aberto'>Aberto</option>" +
															 		 "<option value='Concluído'>Concluído</option>" +
																	  "<option value='Suspenso'>Suspenso</option>" +
															 		 "</select>";
}

function listar(f)
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/licitacao/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value, vfiltro: document.fbusca.filtro.value, vfiltroValor: document.fbusca.filtrovalor.value }, function(resposta) {$("#divbusca").html(resposta);});
}

function atualiza_ano()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value }, function(resposta) {$("#divAno").html(resposta);});
}

function atualiza_descricao()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_descricao.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value, ano: document.frelatorio.ano.options[document.frelatorio.ano.selectedIndex].value }, function(resposta) {$("#divDescricao").html(resposta);});
}

function imprime()
{
	$.post("/gecoi.3.0/apps/licitacao/emitir_relatorio_controle.jsp", {area: document.frelatorio.modalidade.options[document.frelatorio.modalidade.selectedIndex].value, ano: document.frelatorio.ano.options[document.frelatorio.ano.selectedIndex].value, idArquivo: document.frelatorio.descricao.value }, function(resposta) {$("#divrelatorio").html(resposta);});
}

function atualiza_ano_status(f)
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano_status.jsp", {area: f.area.options[f.area.selectedIndex].value }, function(resposta) {$("#divAnoStatus").html(resposta);});
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

   		$.post("/gecoi.3.0/apps/licitacao/lista_status.jsp", {area: f.area.value, ano: f.ano.value, filtro: pfiltro }, function(resposta) {$("#divStatus").html(resposta);});
	}
}

function concluir(pacao, pconteudo)
{
	var pdiv = "divbotao" + pconteudo;
   document.getElementById(pdiv).innerHTML = "Concluindo...";
   $.post("/gecoi.3.0/apps/licitacao/processa_status.jsp", {idConteudo: pconteudo, acao: pacao }, function(resposta) {$("#" + pdiv).html(resposta);});
}

function atualiza_ano_extrato()
{
	$.post("/gecoi.3.0/apps/licitacao/lista_ano_extrato.jsp", function(resposta) {$("#divAnoExtrato").html(resposta);});
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
		  })
		  ;
   	}
   else
   	{
		$.post(pag, {'ano': f.ano.value, 'chave':f.chave.value}, function(resposta) {
	      $("#divExtrato").html(resposta);
	       //tb_init("#divExtrato a.thickbox");	      
		  })
		  ;
   	}   
}

//função que carrega os arquivos, de acordo com o tipo de filtro selecionado
function trocaFiltroExtrato()
{
	if (document.fextrato.filtro.value == "---")
		document.getElementById("divfiltroExtrato").innerHTML = "";
	else
		if (document.fextrato.filtro.value == "modalidade")
			document.getElementById("divfiltroExtrato").innerHTML = "<select name='filtrovalor'>" +
															 "<option value='1021'>Concorrência Pública</option>" +
															 "<option value='882'>Pregão Eletrônico</option>" +
															 "<option value='883'>Pregão Eletrônico por Registro de Preço</option>" +
															 "<option value='885'>Pregão Presencial</option>" +
															 "<option value='886'>Pregão Presencial por Registro de Preço</option>" +
															 "<option value='887'>Tomada de Preço</option>" +
															 "</select>";
		else
			if (document.fextrato.filtro.value == "abertura")
			{
				document.getElementById("divfiltroExtrato").innerHTML = "<input name='filtrovalor' type='text' class='form-text' id='datepicker' size='10' maxlength='10' />";
				$('#datepicker').datepicker({changeMonth: true,changeYear: true	});
			}
			else
				if (document.fextrato.filtro.value == "situacao")
					document.getElementById("divfiltroExtrato").innerHTML = "<select name='filtrovalor'>" +
															 		 "<option value='Publicado'>Publicado</option>" +
															 		 "<option value='Aberto'>Aberto</option>" +
															 		 "<option value='Concluido'>Concluído</option>" +
																	  "<option value='Suspenso'>Suspenso</option>" +
															 		 "</select>";
}



</script>
<%
	Calendar c = Calendar.getInstance();
	int vano = c.get(Calendar.YEAR);
%>
<div id='tabs'>
	<ul>
		<li tabindex='1'><a href='#tabs-1' onclick="" >Incluir novo</a></li>
		<li tabindex='2'><a href='#tabs-2' onclick="">Licita&ccedil;&otilde;es cadastradas</a></li>
		<li tabindex='3'><a href='#tabs-3' onclick="" >Relatório</a></li>
		<li tabindex='4'><a href='#tabs-4' onclick="" >Troca Status</a></li>
		<li tabindex='5'><a href='#tabs-5' onclick="atualiza_ano_extrato();" >Extrato</a></li>
	</ul>
	<div id='tabs-1'>
	 <form name="finclusao" action="/gecoi.3.0/IncluirLicitacao" method="post"  target="processa_background" enctype="multipart/form-data">
  		<p>Modalidade</p>
		<div>
  			<p>
  			  <select title="Tipo" alt="tipo" name="tipo" id="tipo">
  			    <option value="CP">Concorr&ecirc;ncia P&uacute;blica</option>
  			    <option value="PE">Preg&atilde;o Eletr&ocirc;nico</option>
  			    <option value="PERP">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
  			    <option value="PP">Preg&atilde;o Presencial</option>
  			    <option value="PPRP">Preg&atilde;o Presencial por Registro de Pre&ccedil;o</option>
  			    <option value="TP">Tomada de Pre&ccedil;o</option>
		      </select>
  			</p>
		</div>
		<p>Nº do Pregão</p>
		<div>
  			<p>N&uacute;mero/Ano </p>
  			<p>
    			<input title="N&uacute;mero do preg&atilde;o" alt="N&uacute;mero do preg&atilde;o"  type="text" name="numPregao" id="numPregao" size="6" maxlength="6" onKeyDown="FormataNumero(this,event);"/>/<input title="Ano do preg&atilde;o com 4 d&iacute;gitos" alt="Ano do preg&atilde;o com 4 d&iacute;gitos" type="text" name="anoPregao" id="anoPregao" size="4" maxlength="4" <%=vano%> />
  			</p>
		</div>
		<p>Nº do Processo</p>
		<div>
  			<p>N&uacute;mero/Ano </p>
  			<p>
    			<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" size="6" maxlength="7" onKeyDown="FormataNumero(this,event);"/>/<input title="Ano do processo com 4 d&iacute;gitos" alt="Ano do processo com 4 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" size="4" maxlength="4" <%=vano%> />
  			</p>
		</div>
    	<div>
    		<p>Data Abertura</p>
			<p>
				<input title="Data de abertura" alt="Data de abertura" type="text" name="dataAbertura" id="dataAbertura" size="10" maxlength="10" />
				<script type="text/javascript">
					$('#dataAbertura').datetimepicker({
						controlType: 'select',
						//timeFormat: 'HH:mm:ss',
						dateFormat: 'dd/mm/yy',
    					changeMonth: true,
    					changeYear: true																	
					});
				</script>
			</p>
		</div>
    	<div>
    		<p>Data Encerramento</p>
			<p>
				<input title="Data de fechamento" alt="Data de fechamento" type="text" name="dataFechamento" id="dataFechamento" size="10" maxlength="10" />
			</p>
		</div>
		<div>
			<p>Objeto</p>
    	<p>Descri&ccedil;&atilde;o do  Objeto</p>
		<div>
  			<p>
    			<!-- <input title="Descri&ccedil;&atilde;o do objeto" alt="Descri&ccedil;&atilde;o do objeto"  type="text" name="descricao" id="descricao" /> -->
    			<textarea title="Descri&ccedil;&atilde;o do objeto" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
   				<span id="contadorDescricao" class="alert"></span>
  			</p>
		</div>
			<p> 
				<div id="campoArquivo"><input title="Arquivo a ser inserido" alt="Arquivo a ser inserido" type="file" name="arquivo" id="arquivo" /></div>
				<div id="progressBar" style="display: none;">
            		<div id="theMeter">
                		<div id="progressBarText"></div>
                		<div id="progressBarBox">
                    		<div id="progressBarBoxContent"></div>
               			</div>
            		</div>
         		</div>
			</p>
			<p>
				<input type="button" name="button" id="button" value="Gravar dados" onClick="critica_inclusao_licitacao(document.finclusao);" />
				<!-- <input type="submit" id="submitID" name="submit" value="Upload" /> -->
			</p>
		</div>
  	</form>
  	<div id="mensagem_caixa"></div>
  	<iframe name="processa_background" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>
   </div> 
  
   <div id="tabs-2">
   		<jsp:useBean id="todosAnos" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
   		<c:set var="anos" value="${todosAnos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
		<form name="fbusca" method="post" target="divbusca" >
			<p>Selecione o ano da licitação:</p>
			<select name="ano">
        		<option>-----------</option>
        		<c:forEach var="ano" items="${anos}">
        			<option value="${ano}">${ano}</option>
        		</c:forEach>
        	</select>
        	<p>Selecione o  filtro</p>
         	<select name="filtro" onchange="trocaFiltro();">
           		<option value="---">---</option>
           		<option value="modalidade">Modalidade</option>
           		<option value="abertura">Data Abertura</option>
           		<option value="situacao">Situa&ccedil;&atilde;o</option>
           	</select>
           	<span id="divfiltro">opcional<select name='filtrovalor' id="filtrovalor" style="visibility:hidden;" ></select></span>
           
        	<p>Palavra Chave</p>
        	<input name="texto" type="text" size="35" maxlength="150" />
        	<input type="button" name="buscar" id="buscar" value="buscar" onclick="listar(this.form);" />
		</form>
   		<div id="divbusca"></div>
   </div>
	<div id="tabs-3">
		<form id="frelatorio" name="frelatorio" method="post" >
 			<table width="100%" border="0" cellspacing="5" cellpadding="0">
   				<tr>
     				<td colspan="2"><strong>Selecione o edital para o relat&oacute;rio</strong><br /><br /></td>
    			</tr>
   				<tr>
     				<td width="8%"><strong>Modalidade:</strong></td>
     				<td width="92%">
      					<select name="modalidade" size="1" class="form-select" id="modalidade" onchange="atualiza_ano();">
      						<option value="0">-</option>
      						<option value="-1">Todas</option>
							<option value='1021'>Concorr&ecirc;ncia P&uacute;blica</option>
      						<option value="882">Preg&atilde;o Eletr&ocirc;nico</option>
      						<option value="883">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
							<option value='885'>Preg&atilde;o Presencial</option>
							<option value='886'>Preg&atilde;o Presencial por Registro de Pre&ccedil;o</option>
							<option value='887'>Tomada de Pre&ccedil;o</option>
    					</select>
     				</td>
   				</tr>
   				<tr>
     				<td><strong>Ano:</strong></td>
     				<td><div id="divAno"><select name="ano" class="form-select" id="ano" onchange=""></select></div></td>
   				</tr>
   				<tr>
     				<td><strong>Descri&ccedil;&atilde;o: </strong></td>
     				<td><div id="divDescricao"><select name="descricao" class="form-select" id="descricao" onchange=""></select></div></td>
   				</tr>
   				<tr>
     				<td>&nbsp;</td>
     				<td><input name="relatorio" type="button" class="form-botao" id="relatorio" value=" Emitir Relatório " onclick="imprime()" /></td>
   				</tr>
   				<tr>
     				<td>&nbsp;</td>
     				<td>&nbsp;</td>
   				</tr>
 			</table>
		</form>
 		<div id="divrelatorio"></div>
	</div> 
	<div id="tabs-4">
 		<form name="fstatus" method="post" action="">
  			<table width="100%" border="0" cellspacing="3" cellpadding="2">
    			<tr>
      				<td colspan="2"><strong>Selecione o edital para a manuten&ccedil;&atilde;o</strong><br /><br /></td>
    			</tr>
    			<tr>
      				<td width="9%"><strong>Modalidade:</strong></td>
      				<td width="91%" colspan="2">
      					<p><select name="area" class="form-select" id="area" onchange="atualiza_ano_status(this.form);">
      						<option value="0">-</option>
							<option value='1021'>Concorr&ecirc;ncia P&uacute;blica</option>
      						<option value="882">Preg&atilde;o Eletr&ocirc;nico</option>
      						<option value="883">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
							<option value='885'>Preg&atilde;o Presencial</option>
							<option value='886'>Preg&atilde;o Presencial por Registro de Pre&ccedil;o</option>
							<option value='887'>Tomada de Pre&ccedil;o</option>
            			</select></p>
      				</td>
    			</tr>
    			<tr>
      				<td><strong>Ano:</strong></td>
      				<td colspan="2">
            			<div id="divAnoStatus"><select name="ano" class="form-select" id="ano" onchange=""><option value="0"></option></select></div>
      				</td>
    			</tr>
  			</table>
  			<br />
  			<table  width="100%" border="0" cellspacing="3" cellpadding="0">
    			<tr>
       				<td></td>
       				<td width="151"><input type="radio" name="filtro" id="filtro" value="A"  onclick="carrega_edital(this.form)" />Abertos</td>
       				<td width="186"><input type="radio" name="filtro" id="filtro" value="E"  onclick="carrega_edital(this.form)" />Encerrados</td>
       				<td width="186"><input type="radio" name="filtro" id="filtro" value="S"  onclick="carrega_edital(this.form)" />Suspensos</td>
       				<td width="146"><input type="radio" name="filtro" id="filtro" value="T" checked="checked" onclick="carrega_edital(this.form)" />Todos</td>
       				<td></td>
    			</tr>
    			<tr>
      				<td colspan="6"><br /><hr width="98%" size="1"/></td>
    			</tr>
    			<tr>
      				<td colspan="6">
        				<div id="divStatus">
          					<ol></ol>
          				</div>
        			</td>
    			</tr>
    		</table>
  		</form>
  		<div id="divStatus"></div>
	</div>
	<div id="tabs-5">
		<form name="fextrato">
  		<table width="100%" border="0" cellspacing="5">
  			<tr>
      			<td colspan="3"><strong>Selecione o edital para o extrato<br /></strong><br /></td>
    		</tr>
     		<tr>
       			<td width="23%">Selecione o ano</td>
       			<td colspan="2" valign="top">
       				<div id="divAnoExtrato"></div>              
       			</td>
       			<td width="45%" >&nbsp;</td>
     		</tr>
     		<tr>
       			<td>Selecione o tipo de filtro</td>
				<td width="8%" valign="top">
         			<select name="filtro" onchange="trocaFiltroExtrato();">
           				<option value="---">---</option>
           				<option value="modalidade">Modalidade</option>
           				<option value="abertura">Data Abertura</option>
           				<option value="situacao">Situa&ccedil;&atilde;o</option>
         			</select>
       			</td>
       			<td colspan="2" valign="top">
         			<div id="divfiltroExtrato"></div></td>
       		</tr>
      		<tr>
        		<td>Filtrar por palavra chave</td>
        		<td colspan="2" valign="top">
          			<input name="chave" type="text" size="50" />
        		</td>
        		<td valign="top">
          			<input type="button" name="button" value="Pesquisar" onclick="listarExtrato(this.form);"/>
        		</td>
      		</tr>
    	</table>
 		</form>
		<div id="divExtrato"></div>
	</div>
</div>
 