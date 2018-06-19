<jsp:useBean id="todosAnos" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
   		<c:set var="anos" value="${todosAnos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
		<form name="fbusca" method="post" target="divbusca" id="formulario" autocomplete="off">
            <div id="cadastradas_ano">
            	<fieldset>
            		<legend>Ano</legend>
					<select name="ano">
        			<option>-----------</option>
        			<c:forEach var="ano" items="${anos}">
        				<option value="${ano}">${ano}</option>
        			</c:forEach>
        			</select>
            	</fieldset>
            </div>
            <div id="filtro">
        	<div id="cadastradas_filtro">
            	<fieldset>
            		<legend>Filtro</legend>
         			<select name="filtro" onchange="trocaFiltro();">
           				<option value="---">---</option>
           				<option value="modalidade">Modalidade</option>
           				<option value="abertura">Data Abertura</option>
           				<option value="situacao">Situa&ccedil;&atilde;o</option>
           			</select>
          		</fieldset>
            </div>
            <div style="visibility:hidden;" id="divfiltro">
            	<fieldset>
                	<legend id="legenda">Modalidade</legend>
            		<span id="spanfiltro">opcional<select name='filtrovalor' id="filtrovalor" style="visibility:hidden;" ></select></span>
                </fieldset>
            </div>
            </div>
            <div id="cadastradas_palavra">
            <fieldset>
            <legend>Palavra Chave</legend>
        	<input name="texto" type="text" size="35" maxlength="150" />
        	
            </fieldset>
           <div id="botao">
			<input type="button" name="buscar" id="buscar" value="Buscar" onclick="listar(this.form);" />
           </div>
            </div>
		</form><br/>
   		<div id="divbusca"></div>