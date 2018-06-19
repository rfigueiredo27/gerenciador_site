	
	 <form name="finclusao" action="/gecoi.3.0/IncluirLicitacao" method="post"  target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off" >
  		
		<div id="modalidade">
        	<fieldset>
                <legend>Modalidade</legend>
  			  	<select title="Tipo" alt="tipo" name="tipo" id="tipo">
  			    	<option value="CP">Concorr&ecirc;ncia P&uacute;blica</option>
  			    	<option value="PE">Preg&atilde;o Eletr&ocirc;nico</option>
  			    	<option value="PERP">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
  			    	<option value="PP">Preg&atilde;o Presencial</option>
  			    	<option value="PPRP">Preg&atilde;o Presencial por Registro de Pre&ccedil;o</option>
  			    	<option value="TP">Tomada de Pre&ccedil;o</option>
		      </select>
  			</fieldset>
		</div>
		<div id="pregao_processo">
        	<fieldset>
                <legend>Preg&atilde;o</legend>
  			
    			<input title="N&uacute;mero do preg&atilde;o" alt="N&uacute;mero do preg&atilde;o"  type="text" name="numPregao" value="Número" onfocus="this.value=''" id="numPregao" size="6" maxlength="6" onKeyDown="FormataNumero(this,event);"/>
    			-
    			<input title="Ano do preg&atilde;o com 4 d&iacute;gitos" alt="Ano do preg&atilde;o com 4 d&iacute;gitos" type="text" name="anoPregao"value="Ano" onfocus="this.value='<%=vano%>'" id="anoPregao" size="4" maxlength="4"  />
  			
            </fieldset>
            </div>
            <div id="pregao_processo">
        	<fieldset>
                <legend>Processo</legend>
  			
    			<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" value="Número" onfocus="this.value=''" size="6" maxlength="7" onKeyDown="FormataNumero(this,event);"/>
    			-
    			<input title="Ano do processo com 4 d&iacute;gitos" alt="Ano do processo com 4 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" value="Ano" onfocus="this.value='<%=vano%>'" size="4" maxlength="4" <%=vano%> />
  			
            </fieldset>
		</div>
    	<div id="data">
    		<fieldset>
                <legend>Data</legend>
				<input title="Data de abertura" alt="Data de abertura" type="text" name="dataAbertura" id="dataAbertura" value="Abertura" onfocus="this.value=''" size="10" maxlength="10" />
				<script type="text/javascript">
					$('#dataAbertura').datetimepicker({
						controlType: 'select',
						//timeFormat: 'HH:mm:ss',
						dateFormat: 'dd/mm/yy',
    					changeMonth: true,
    					changeYear: true																	
					});
				</script> - 
			
				<!--<input title="Data de fechamento" alt="Data de fechamento" type="text" name="dataFechamento" id="dataFechamento" value="Encerramento" onfocus="this.value=''" size="10" maxlength="10" /> - -->
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao" id="dataPublicacao" value="Publica&ccedil;&atilde;o" onfocus="this.value=''" size="10" maxlength="10" />
           </fieldset>
		</div>
		<div id="descricao_incluir">
    		<fieldset>
            	<legend>Descri&ccedil;&atilde;o do Objeto</legend>
				<div>
    				<!-- <input title="Descri&ccedil;&atilde;o do objeto" alt="Descri&ccedil;&atilde;o do objeto"  type="text" name="descricao" id="descricao" /> -->
    				<textarea title="Descri&ccedil;&atilde;o do objeto" name="descricao" id="descricao_incluir" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao_incluir, 'contadorDescricao', 1000);"></textarea>
				</div>
                <div id="contadorDescrica" align="right"><span id="contadorDescricao" class="alert"></span></div>
				<p> 
				<div id="campoArquivo" align="left"><input title="Arquivo a ser inserido" alt="Arquivo a ser inserido" type="file" name="arquivo" id="arquivo" /></div>
				<div id="progressBar" style="display: none;">
            		<div id="theMeter">
                		<div id="progressBarText"></div>
                		<div id="progressBarBox">
                    		<div id="progressBarBoxContent"></div>
               			</div>
            		</div>
         		</div>
			</p>
			
            </fieldset>
  
            <div id="botao">
				<input type="button" name="button" id="button" value="Gravar dados" onClick="critica_inclusao_licitacao(document.finclusao,this.form.arquivo.value);" />
				<!-- <input type="submit" id="submitID" name="submit" value="Upload" /> -->
           </div>
        	
		</div>
  	</form>
   
  	<div id="mensagem_caixa"></div>
  	<iframe name="processa_background" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>