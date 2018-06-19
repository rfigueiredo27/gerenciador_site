<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirRevistaJurisprudencia" onsubmit="" method="post"  
data-toggle="idator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
	<div id="flex">
		
	<div id="edital" >
		<fieldset>
			<legend>Volume</legend>
				<input type="number" title="Volume" name="volume" id="volume" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Número</legend>
				<input type="number" title="Número" name="numero" id="numero" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Complemento</legend>
                <select name="complemento" id="complemento">
					<option value="">Nenhum</option>
					<option value="Parte 1">Parte 1</option>
					<option value="Parte 2">Parte 2</option>
					<option value="Parte 3">Parte 3</option>
					<option value="Parte 4">Parte 4</option>
					<option value="Parte 5">Parte 5</option>
			</select>
	  		</fieldset>
	</div>
	
	</div>
	
	<div id="arquivo_principal">
		<fieldset>
			<legend>Escolher arquivo</legend>
				<div id="campoArquivo">
				<input type="file" name="arquivo1" id="arquivo1" alt="Arquivo a ser inserido" required> 
				</div>
				<div id="progressBar" style="display: none;">
					<div id="theMeter">
						<div id="progressBarText"></div>
						<div id="progressBarBox">
							<div id="progressBarBoxContent"></div>
						</div>
					</div>
				</div>
		</fieldset>
	</div>
	
	
	<br><br>
	<div id="botao" align="center">
		<input type="button" name="button" id="button" value="Publicar"	onClick="critica_inclusao(document.finclusao);" />
	</div>
	
</form>

