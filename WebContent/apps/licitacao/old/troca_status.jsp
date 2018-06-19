<form name="fstatus" method="post" action="">
<div id="troca_status">
  		<div id="status_edital">
            <fieldset>
                <legend>Edital</legend>
      				<select name="area" class="form-select" id="area" onchange="atualiza_ano_status(this.form);">
      						<option value="0">-</option>
							<option value='1021'>Concorr&ecirc;ncia P&uacute;blica</option>
      						<option value="882">Preg&atilde;o Eletr&ocirc;nico</option>
      						<option value="883">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
							<option value='885'>Preg&atilde;o Presencial</option>
							<option value='886'>Preg&atilde;o Presencial por Registro de Pre&ccedil;o</option>
							<option value='887'>Tomada de Pre&ccedil;o</option>
            		</select>
            </fieldset>
         </div>
         <div id="status_ano">
            <fieldset>
                <legend>Ano</legend>
            	<div id="divAnoStatus"><select name="ano" class="form-select" id="ano" onchange=""><option value="0"></option></select></div>
      		</fieldset>
  		 </div>
         <div id="status_situacao">
  			<fieldset>
                <legend>Situa&ccedil;&atilde;o</legend>
                 <div class="status_situacao">
       				<div class="aberto"><input type="radio" name="filtro" id="filtro" value="A"  onclick="carrega_edital(this.form)" />
       				Abertos</div> 
       				<div class="encerrado"><input type="radio" name="filtro" id="filtro" value="E"  onclick="carrega_edital(this.form)" /> 
       				Encerrados</div>
       				<div class="suspenso"><input type="radio" name="filtro" id="filtro" value="S"  onclick="carrega_edital(this.form)" />
       				Suspensos</div> 
       				<div class="todos"><input type="radio" name="filtro" id="filtro" value="T" checked="checked" onclick="carrega_edital(this.form)" />
       				Todos</div> 
                 </div>
       		</fieldset>
         </div>
    		
</div>
</form>

<div id="divStatus"></div>
