<h1>Inclusão de Contratos e Aditivos sem licitação</h1>
<form name="finclusao" action="/gecoi.3.0/IncluirContratoSemLicitacao" method="post" target="rodape" enctype="multipart/form-data">
<div id="tipo_contrato">
	<fieldset>
    <legend>Tipo de contrato</legend>
		<select name="tipo">
			<option value="-">-----------</option>
			<option value="adesao">Adesão de Ata de Registro de Preço</option>
			<option value="direta">Contratação Direta</option>
		</select>
	</fieldset>
</div>
<div id="processo_sem_licitacao">
	<fieldset>
    <legend>Processo</legend>
	<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" size="6" maxlength="7" value="Número" onfocus="this.value=''" onKeyDown="FormataNumero(this,event);"/>-<input title="Ano do processo com 4 d&iacute;gitos" alt="Ano do processo com 4 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" size="4" maxlength="4" value="Ano"  readonly="readonly"/>
</fieldset>
</div>
<div id="contrato_sem_licitacao">
	<fieldset>
    <legend>Contrato</legend>
<input type="text" name="numContrato" id="numContrato"  maxlength="9" value="Número" onfocus="this.value=''"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2" value="Ano" readonly="readonly"/>
	</fieldset>
</div>
<div id="vigencia_sem_licitacao">
	<fieldset>
    <legend>Vigência</legend>
<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni4" id="vigenciaIni4" size="10" maxlength="10" value="Inicio" onfocus="this.value=''" /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim4" id="vigenciaFim4" size="10" maxlength="10" value="Fim" onfocus="this.value=''"/>
	</fieldset>
</div>
<div id="descricao_sem_licitacao">
	<fieldset>
    <legend>Descri&ccedil;&atilde;o</legend>
 <textarea title="Descri&ccedil;&atilde;o do contrato" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
 <span id="contadorDescricao" class="alert"></span>
 	</fieldset>
</div>
<div id="publicao_sem_licitacao">
	<fieldset>
    <legend>Publica&ccedil;&atilde;o</legend>
<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao4" id="dataPublicacao4" size="10" maxlength="10" value="Data da Publicação" onfocus="this.value=''"/>

<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
<div id="progressBar" style="display: none;">
	<div id="theMeter">
		<div id="progressBarText"></div>
		<div id="progressBarBox">
			<div id="progressBarBoxContent"></div>
		</div>
	</div>
</div>
</fieldset>
</div>
<div id="observacao_sem_licitacao">
	<fieldset>
    <legend>Observa&ccedil;&atilde;o</legend>
 <textarea title="Observa&ccedil;&atilde;o do contrato" name="observacao" id="observacao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);" onKeyUp="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);" onKeyDown="javascript:resta(this.form.observacao, 'contadorObservacao', 1000);"></textarea>
 <span id="contadorObservacao" class="alert"></span>
 </fieldset>
</div>
<div id="botao">
 <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
 <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaInclusaoSemLicitacao();"  />
</div>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
