<form id="frelatorio" name="frelatorio" method="post" >
<div id="relatorio">
    <div id="relatorio_modalidade">
    	<fieldset>
        	<legend>Modalidade</legend>
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
        </fieldset>
    </div>
    <div id="relatorio_ano_descricao">
    	<fieldset>
        	<legend>Ano/Descri&ccedil;&atilde;o</legend>
     	    <div id="divAno"><select name="ano" class="form-select" id="ano" onchange=""></select></div>
     	    <div id="divDescricao"><select name="descricao" class="form-select" id="descricao" onchange=""></select></div>
        </fieldset>
    </div>
    
</div>
<div id="botao"><input name="relatorio" type="button" class="form-botao" id="relatorio" value=" Emitir Relat&oacute;rio " onclick="imprime()" /></div>
		</form>
 		<div id="divrelatorio"></div>