<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirRevista" onsubmit="" method="post"  
data-toggle="idator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
	<div id="flex">
		
	<div id="edital" >
		<fieldset>
			<legend>Volume</legend>
				<input type="text" title="Volume" name="volume" id="volume" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Número</legend>
				<input type="text" title="Número" name="numero" id="numero" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Mês Inicial</legend>
                <select name="mes_inicio" id="mes_inicial">
					<option value="Janeiro">Janeiro</option>
					<option value="Fevereiro">Fevereiro</option>
					<option value="Março">Março</option>
					<option value="Abril">Abril</option>
					<option value="Maio">Maio</option>
					<option value="Junho">Junho</option>
					<option value="Julho">Julho</option>
					<option value="Agosto">Agosto</option>
					<option value="Setembro">Setembro</option>
					<option value="Outubro">Outubro</option>
					<option value="Novembro">Novembro</option>
					<option value="Dezembro">Dezembro</option>
			</select>
	  		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Ano Inicial</legend>
				<input type="text" title="Ano Inicial" name="ano_inicial" id="ano_inicial" placeholder=""/>
		</fieldset>
		
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Mês Final</legend>
                <select name="mes_fim" id="mes_final">
					<option value="Janeiro">Janeiro</option>
					<option value="Fevereiro">Fevereiro</option>
					<option value="Março">Março</option>
					<option value="Abril">Abril</option>
					<option value="Maio">Maio</option>
					<option value="Junho">Junho</option>
					<option value="Julho">Julho</option>
					<option value="Agosto">Agosto</option>
					<option value="Setembro">Setembro</option>
					<option value="Outubro">Outubro</option>
					<option value="Novembro">Novembro</option>
					<option value="Dezembro">Dezembro</option>
			</select>
	  		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Ano Final</legend>
				<input type="text" title="Ano Final" name="ano_final" id="ano_final" placeholder=""/>
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

