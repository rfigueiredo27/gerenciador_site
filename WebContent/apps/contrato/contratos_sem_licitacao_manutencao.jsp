<h1>Manutenção de Contratos e Aditivos sem licitação</h1>
</script>
<jsp:useBean id="listaContrato" class="br.jus.trerj.controle.contrato.ListaContratos"/>
<c:set var="anos" value="${listaContrato.getAnosSemLicitacao(sessionScope['login'], sessionScope['senha'])}" />
<form name="fbusca2" method="post" target="divbusca" >

<div id="contrato_ano_sem_licitacao">
	<fieldset>
    <legend>Ano</legend>
		<select name="ano">
			<option value="0">-----------</option>
			<c:forEach var="ano" items="${anos}">
				<option value="${ano}">${ano}</option>
			</c:forEach>
		</select>
    </fieldset>
</div>
<p></p>
<div id="contrato_palavra_sem_licitacao">
	<fieldset>
    <legend>Palavra Chave</legend>
		<input name="texto" type="text" size="35" maxlength="150" />
    </fieldset>
</div>
<div id="contrato_tipo_sem_licitcao">
	<fieldset>
    <legend>Tipo de contrato</legend>
    <div class="contrato_tipo_sem_licitcao">
		<div class="todos"><input type="radio" name="tipo" id="tipo" value="todos"  onclick="listarContratoSemLicitacao();" checked="checked" /> 
		Todos</div> 
		<div class="adesao"><input type="radio" name="tipo" id="tipo" value="adesao"  onclick="listarContratoSemLicitacao();" /> 
		Adesão por Ata de Registro de Preço</div> 
		<div class="direta"><input type="radio" name="tipo" id="tipo" value="direta"  onclick="listarContratoSemLicitacao();" /> 
		Contratação Direta</div>
    </div> 
    </fieldset>
</div>
<div id="botao">
<input type="button" name="buscar" id="buscar" value="buscar" onclick="listarContratoSemLicitacao();" />
</div>
</form>
<div id="divbusca2"></div>