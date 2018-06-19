<form name="fextrato">
  <div id="extrato">
  		<div id="extrato_ano">
            <fieldset>
                <legend>Extrato Ano</legend>
       				<div id="divAnoExtrato"></div>              
           </fieldset>
        </div>
        <div id="filtro2">
        	<div id="extrato_filtro">
       			<fieldset>
                	<legend>Tipo de Filtro</legend>
         			<select name="filtro" onchange="trocaFiltroExtrato();">
           				<option value="---">---</option>
           				<option value="modalidade">Modalidade</option>
           				<option value="abertura">Data Abertura</option>
           				<option value="situacao">Situa&ccedil;&atilde;o</option>
         			</select>
                </fieldset>
            </div>  
        	<div style="visibility:hidden;" id="divfiltro2">
            	<fieldset>
                	<legend id="legenda2">Modalidade</legend>
                	<!-- <div id="divfiltroExtrato"></div>-->
                     <span id="spanfiltro2">opcional<select name='filtrovalor' id="divfiltroExtrato" style="visibility:hidden;" ></select></span>
                </fieldset>
        	
        	</div>
        </div>
        <div id="extrato_palavra">
         	<fieldset>
                <legend>Palavra Chave</legend>
          		<input name="chave" type="text" size="50" />
            </fieldset>
        </div>  
  </div>
  <div id="botao"><input type="button" name="button" value="Pesquisar" onclick="listarExtrato(this.form);"/></div>
</form>
<div id="divExtrato"></div>
 