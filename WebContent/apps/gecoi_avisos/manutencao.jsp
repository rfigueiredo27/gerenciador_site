<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<style>


#cadastradas_ano fieldset{
	width: 100px;
	margin-left: 50px;
}

#botao2 {
    
     width: 150px;
     margin-left: 10px;
}

#botao2 input[type="button"] {
    font-size: 13px;
    background: #ECECEC;
    color: #777777;
    border: #777777 solid 1px;
    height: 60%;
    width: 50%;
}

.flex_box{
	display: flex;
  	
}

@media(max-width: 768px){
	.flex_box{
	    flex-direction: column;
	}
	}

</style>

<jsp:useBean id="todosAnos"
	class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
<c:set var="anos"
	value="${todosAnos.getAnos(sessionScope['login'], sessionScope['senha'])}" />
<form name="fbusca" method="post" target="divbusca" id="formulario"
	autocomplete="off" >
	<div class="flex_box">
	<div id="cadastradas_filtro">
		<fieldset>
			<legend>Área de Publicação*</legend>
			<jsp:useBean id="lista_manutencao"
				class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
			<c:set var="items"
				value="${lista_manutencao.getDestino(sessionScope['login'], sessionScope['senha'])}" />
			<select name='area' id='area' onchange="atualiza_ano_status(this.form);">
				<option value='0'>--</option>
				<c:forEach var="lista_gecoi" items="${items}">
					<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao }</option>
				</c:forEach>
			</select>
		</fieldset>
	</div>

	<div id="cadastradas_ano">
            <fieldset>
                <legend>Ano*</legend>
            	<div id="divAnoStatus"><select name="ano" class="form-select" id="ano" ><option value="0"></option></select></div>
      		</fieldset>
    </div>
    
	<br> <br> <br>
	<div id="botao2">
		 <br><input type="button" name="buscar" id="buscar"
			value="Buscar" onclick="listar(this.form);" />
	</div>
	</div>

</form>



<br />

<div id="divbusca"></div>