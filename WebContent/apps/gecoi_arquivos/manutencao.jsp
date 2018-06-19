<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>
<style>
#botao input[type="button"] {
    font-family: Tahoma, Arial, Helvetica, sans-serif;
    font-size: 13px;
    background: #ECECEC;
    color: #777777;
    border: #777777 solid 1px;
    height: 32px;
    width: 120px;
}
</style>

<jsp:useBean id="selecionar_area"
	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
<c:set var="anos" value="${todosAnos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
<form name="fbusca" method="post" target="divbusca" id="formulario"	autocomplete="off" >
	<div id="selecionar_area">
		<fieldset>
			<legend>Área de Publicação*</legend>
			<jsp:useBean id="lista_manutencao"
				class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
			<c:set var="items"
				value="${lista_manutencao.getArea(sessionScope['login'], sessionScope['senha'])}" />
			<select name='area' id='area' onchange="atualiza_ano_status(this.form);">
				<option value='0'>--</option>
				<c:forEach var="lista_gecoi" items="${items}">
					<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao_area }</option>
				</c:forEach>
			</select>
		</fieldset>
	</div>
	
	<div id="selecionar_ano">
            <fieldset>
                <legend>Ano*</legend>
            	<div id="divAnoStatus">
            		<select name="ano" class="form-select" id="ano" >
            			<option value="0"></option>
            		</select>
            	</div>
      		</fieldset>
    </div>

	<br><br>
	<div id="botao">
		 <input type="button" name="buscar" id="buscar"	value="Buscar" onclick="listar(this.form);" />
	</div>
</form>


<div id="divbusca"></div>