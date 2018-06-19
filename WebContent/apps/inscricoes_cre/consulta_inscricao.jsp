<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<style>



.flex_box{
	display: flex;
  	
}

@media(max-width: 768px){
	.flex_box{
	    flex-direction: column;
	}
	}

</style>

<form name="fbusca" method="post" target="divbusca" id="formulario" autocomplete="off" >
	<div class="flex_box">
		<div id="cadastradas_filtro">
			<fieldset>
				<legend>Concursos</legend>
				<select name='inscricao' id='inscricao'>
					<option value='1'>Concurso de V&iacute;deos</option>
				</select>
			</fieldset>
		</div>
		<br> <br> <br>
		<div id="botao2">
			 <br><input type="button" name="buscar" id="buscar" value="Buscar" onclick="listar(this.form);" />
		</div>
	</div>
</form>



<br />

<div id="divbusca"></div>