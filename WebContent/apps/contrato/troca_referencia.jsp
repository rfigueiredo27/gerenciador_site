<jsp:useBean id="listaContratos" class="br.jus.trerj.controle.contrato.ListaContratos"/>
	<c:set var="anosContrato" value="${listaContratos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
    <div id="cadastro">
		<form name="fbuscaContrato" method="post" target="divbuscaContrato" >
        	<div id="ano">
            	<fieldset>
            	<legend>Ano do Contrato</legend>
				<select name="ano_contrato">
        			<option value="0">-----------</option>
        				<c:forEach var="anoContrato" items="${anosContrato}">
        				<option value="${anoContrato}">${anoContrato}</option>
        				</c:forEach>
        		</select>
            	</fieldset>
            </div>
            <div id="palavra">
           <fieldset>
           	<legend>Palavra Chave</legend>
        	<input name="texto_contrato" type="text" size="35" maxlength="150" />
              </fieldset>
        </div>
        <div id="botao"><input type="button" name="buscar_contrato" id="buscar_contrato" value="buscar" onclick="listarContrato();" /></div>
		</form>
    </div>
   	<div id="divbuscaContrato"></div>