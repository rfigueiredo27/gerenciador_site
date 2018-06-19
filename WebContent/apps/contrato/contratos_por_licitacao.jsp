	<div id='tabs-1'>
		<h1>Cadastro de Contratos e Aditivos</h1>
   		<jsp:useBean id="listaLicitacao" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
   		<c:set var="anos" value="${listaLicitacao.getAnos(sessionScope['login'], sessionScope['senha'])}" />
         <div id="cadastro">
         
			<form name="fbusca" method="post" target="divbusca" >
            <div id="ano">
            	<fieldset>
            		<legend>Ano do Contrato</legend>
					<select name="ano">
        				<option value="0">-----------</option>
        				<c:forEach var="ano" items="${anos}">
        					<option value="${ano}">${ano}</option>
        				</c:forEach>
        			</select>
                </fieldset>
            </div>
            <div id="palavra">
           <fieldset>
           	<legend>Palavra Chave</legend>
        	<input name="texto" type="text" size="35" maxlength="150" />
           </fieldset>
        </div>
        	<div id="botao"><input type="button" name="buscar" id="buscar" value="buscar" onclick="listar();" /></div>
		</form>
      </div>
   		<div id="divbusca"></div>
	</div>
	