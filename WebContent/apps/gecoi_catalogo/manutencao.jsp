<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>
<style>
#botao input[type="button"] {
    font-family: Tahoma, Arial, Helvetica, sans-serif;
    font-size: 16px;
    background: #ECECEC;
    color: #777777;
    border: #777777 solid 1px;
    height: 40px;
    min-width: 200px;
}


legend
{
	margin-bottom:0px;
	border-bottom: none;
	width: auto;
}

</style>



<form name="fbusca" method="post" target="divbusca" id="formulario"	autocomplete="off" >
	<div style="float:left; width: 50%" >
	<div id="selecionar_area" >
		<fieldset>
			<legend><strong>Grupo de Acesso*</strong></legend>
			<jsp:useBean id="lista_grupos" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
			<c:set var="items" value="${lista_grupos.getGrupo(sessionScope['login'], sessionScope['senha'])}" />
			<select name="grupo" id="grupo"	onchange="atualiza_catalogo(this.form);">
				<option value='-5'>--</option>
				<c:forEach var="lista_grupo" items="${items}">
					<option value="${lista_grupo.id_grupo}">${lista_grupo.descricao_grupo}</option>
				</c:forEach>
			</select>
			</fieldset>
	</div>
	<div id="selecionar_area" >		
			<fieldset>
                <legend><strong>Catalogo*</strong></legend>
            	<div id="divCatalogo">
            		<select name="catalogo" class="form-select" id="catalogo" >
            			<option value="0"></option>
            		</select>
            	</div>
      		</fieldset>
	</div>
	<div id="selecionar_area" >
		<div id="botao" style="margin-top: 40px;" align="center">
		 <input type="button" name="buscar" id="buscar"	value="Pesquisar" onclick="listar(this.form);" />
		</div>
		
		
	</div>
	</div>
	<div id="filtros" style="width: 50%">
		<fieldset>
			<legend><strong>Filtros para Pesquisa</strong></legend>
			
			<fieldset>
			<legend>Tipo de Arquivo</legend>
			<div id="divTipo">
            		<select name="tipo" class="form-select" id="tipo" >
            			<option value="-1">Todos</option>
            		</select>
            </div>
			</fieldset>
			
			<fieldset>
			<legend>Área</legend>
			<div id="divArea">
            		<select name="area" class="form-select" id="area" >
            			<option value="0">------</option>
            			<option value="-1">Todas</option>
            		</select>
            </div>
			</fieldset>
			
			<fieldset style="width: 40%">
			<legend>Ano</legend>
			<div id="divAno">
            		<select name="ano" class="form-select" id="ano" >
            			<option value='0'>Todos</option>
            		</select>
            	</div>
			</fieldset>
			
		</fieldset>
		<br><br>
	</div>
	
</form>

<div id="divbusca" style="width: 100%"></div>

