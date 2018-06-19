<jsp:useBean id="listaAta" class="br.jus.trerj.controle.registroPreco.seccon.ListaRegistro"/>
	<c:set var="anosAta" value="${listaAta.getAnos(sessionScope['login'], sessionScope['senha'])}" />
     <div id="cadastro">
		<form name="fbuscaAta" method="post" target="divbuscaAta" >
         <div id="ano">
            <fieldset>
            <legend>Ano da ata:</legend>
				<select name="ano_ata">
        			<option>-----------</option>
        			<c:forEach var="anoAta" items="${anos}">
        				<option value="${anoAta}">${anoAta}</option>
        			</c:forEach>
        		</select>
            </fieldset>
            </div>
        <div id="palavra">
           <fieldset>
           	<legend>Palavra Chave</legend>
        		<input name="texto_ata" type="text" size="35" maxlength="150" />
            </fieldset>
        </div>
        <div id="botao"><input type="button" name="buscar_ata" id="buscar_ata" value="buscar" onclick="listarAta();" /></div>
		</form>
     </div>
   		<div id="divbuscaAta"></div>