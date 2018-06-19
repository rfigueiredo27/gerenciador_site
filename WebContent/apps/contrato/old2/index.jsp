<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<link rel="stylesheet" type="text/css" href="../css/anexos.css" />

<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script src="/gecoi.3.0/apps/contrato/scripts/criticas.js" charset="UTF-8"> </script>
   
<script>
$(document).ready(function(){
		//$( document ).tooltip();  
		$( "#tabs" ).tabs();
		$( "#tabs2" ).tabs();
		$( "#vigenciaIni4" ).datepicker();
		$( "#vigenciaFim4" ).datepicker();
		$( "#dataPublicacao4" ).datepicker();
	});


function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/contrato/lista_licitacao.jsp", { vtexto: document.fbusca.texto.value, vano: document.fbusca.ano.value }, function(resposta) {$("#divbusca").html(resposta);$( "#tabsx" ).tabs();});
}

function listarContrato()
{
	document.getElementById("divbuscaContrato").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/contrato/lista_contrato_referencia.jsp", { vtexto: document.fbuscaContrato.texto_contrato.value, vano: document.fbuscaContrato.ano_contrato.value }, function(resposta) {$("#divbuscaContrato").html(resposta);});
}

function listarContratoSemLicitacao()
{
	if (document.fbusca2.tipo[0].checked)
		ptipo = "todos";
	else
		if (document.fbusca2.tipo[1].checked)
			ptipo = "adesao";
		if (document.fbusca2.tipo[2].checked)
			ptipo = "direta";
	document.getElementById("divbusca2").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp", { texto: document.fbusca2.texto.value, ano: document.fbusca2.ano.value, tipo: ptipo }, function(resposta) {$("#divbusca2").html(resposta);$( "#tabsx" ).tabs();});
}

function criticaInclusaoSemLicitacao()
{
	critica_inclusao_contrato_sem_licitacao(document.finclusao);
}

function atualizaTela()
{
	limpaProgress();	
	document.getElementById("contadorDescricao").innerHTML = "";
	document.getElementById("contadorObservacao").innerHTML = "";
	document.finclusao.reset();
}

</script>
<div id='tabs'>
	<ul>
		<li tabindex='1'><a href='#tabs-1' onclick="" >Contratos gerados por licita&ccedil;&atilde;o</a></li>
		<li tabindex='2'><a href='#tabs-2' onclick="">Contratos gerados sem licita&ccedil;&atilde;o</a></li>
		<li tabindex='3'><a href='#tabs-3' onclick="">Troca de Refer&ecirc;ncia</a></li>
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
		<div id='tabs2'>
			<ul>
				<li tabindex='1'><a href='#tabs-21' onclick="" >Inclus&atilde;o de contratos</a></li>
				<li tabindex='2'><a href='#tabs-22' onclick="">Manuten&ccedil;&atilde;o de contratos</a></li>
			</ul>
			<div id='tabs-21'>
				<h1>Inclusão de Contratos e Aditivos sem licitação</h1>
				<form name="finclusao" action="/gecoi.3.0/IncluirContratoSemLicitacao" method="post" target="rodape" enctype="multipart/form-data"> 
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>Informe o tipo de contrato</td>
							<td>
								<select name="tipo">
        							<option value="-">-----------</option>
        							<option value="adesao">Adesão de Ata de Registro de Preço</option>
        							<option value="direta">Contratação Direta</option>
        						</select>
        					</td>
        				</tr>
	 					<tr><td>Número / ano do Processo:</td>
        					<td>
								<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" size="6" maxlength="7" onKeyDown="FormataNumero(this,event);"/>/<input title="Ano do processo com 4 d&iacute;gitos" alt="Ano do processo com 4 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" size="4" maxlength="4"  />
        					</td>
      					</tr>
	 					<tr><td>Nº do Contrato / Ano do Contrato</td>
        					<td>
								<input type="text" name="numContrato" id="numContrato"  maxlength="9"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2"/>
        					</td>
      					</tr>
      					<tr><td>Vigência</td>
        					<td >
								<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni4" id="vigenciaIni4" size="10" maxlength="10"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim4" id="vigenciaFim4" size="10" maxlength="10" " />
        					</td>
      					</tr>
      					<tr><td>Descri&ccedil;&atilde;o</td>
        					<td>
   								<textarea title="Descri&ccedil;&atilde;o do contrato" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
   								<span id="contadorDescricao" class="alert"></span>
        					</td>
      					</tr>
      					<tr><td>Observa&ccedil;&atilde;o</td>
        					<td>
   								<textarea title="Observa&ccedil;&atilde;o do contrato" name="observacao" id="observacao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);" onKeyUp="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);" onKeyDown="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);"></textarea>
   								<span id="contadorObservacao" class="alert"></span>
        					</td>
      					</tr>
      					<tr><td>Data de Publica&ccedil;&atilde;o</td>
        					<td >
								<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao4" id="dataPublicacao4" size="10" maxlength="10" " />
        					</td>
      					</tr>
      					<tr>
        					<td>
        						<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
								<div id="progressBar" style="display: none;">
									<div id="theMeter">
            							<div id="progressBarText"></div>
                						<div id="progressBarBox">
                							<div id="progressBarBoxContent"></div>
               							</div>
            						</div>
         						</div>
        					</td>
      					</tr>
      					<tr>
        					<td height="40" align="right" valign="middle">
        						<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         						<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaInclusaoSemLicitacao();"  />
        					</td>
      					</tr>
  					</table>
				</form>
				<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 

			</div>
			<div id='tabs-22'>
				<h1>Manutenção de Contratos e Aditivos sem licitação</h1>
   				<jsp:useBean id="listaContrato" class="br.jus.trerj.controle.contrato.ListaContratos"/>
   				<c:set var="anos" value="${listaContrato.getAnosSemLicitacao(sessionScope['login'], sessionScope['senha'])}" />
				<form name="fbusca2" method="post" target="divbusca" >
					<p>Selecione o ano do contrato:</p>
					<select name="ano">
        				<option>-----------</option>
        				<c:forEach var="ano" items="${anos}">
        					<option value="${ano}">${ano}</option>
        				</c:forEach>
        			</select>
           
        			<p>Palavra Chave</p>
        			<input name="texto" type="text" size="35" maxlength="150" /><br>
        			
       				<input type="radio" name="tipo" id="tipo" value="todos"  onclick="listarContratoSemLicitacao()" checked="checked" />Todos
       				<input type="radio" name="tipo" id="tipo" value="adesao"  onclick="listarContratoSemLicitacao()" />Adesão por Ata de Registro de Preço
       				<input type="radio" name="tipo" id="tipo" value="direta"  onclick="listarContratoSemLicitacao()" />Contratação Direta

        			<input type="button" name="buscar" id="buscar" value="buscar" onclick="listarContratoSemLicitacao();" />
				</form>
   				<div id="divbusca2"></div>
			</div>
		</div>
	</div>
	<div id='tabs-3'>
   		<jsp:useBean id="listaContratos" class="br.jus.trerj.controle.contrato.ListaContratos"/>
   		<c:set var="anosContrato" value="${listaContratos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
		<form name="fbuscaContrato" method="post" target="divbuscaContrato" >
			<p>Selecione o ano do Contrato:</p>
			<select name="ano_contrato">
        		<option>-----------</option>
        		<c:forEach var="anoContrato" items="${anosContrato}">
        			<option value="${anoContrato}">${anoContrato}</option>
        		</c:forEach>
        	</select>
           
        	<p>Palavra Chave</p>
        	<input name="texto_contrato" type="text" size="35" maxlength="150" />
        	<input type="button" name="buscar_contrato" id="buscar_contrato" value="buscar" onclick="listarContrato();" />
		</form>
   		<div id="divbuscaContrato"></div>

	</div>			
</div>
