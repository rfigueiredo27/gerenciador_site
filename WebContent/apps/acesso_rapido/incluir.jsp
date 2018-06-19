<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirAcessoRapido" onsubmit="" method="post"  
data-toggle="idator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
		
	<div id="edital" >
		<fieldset>
			<legend>Descrição</legend>
				<input type="text" title="Descrição" name="descricao1" id="descricao1" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Link</legend>
				<input type="text" title="Link" name="link" id="link" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Hint</legend>
				<input type="text" title="Hint" name="hint" id="hint" placeholder=""/>
		</fieldset>
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Target</legend>
                <select name="target" id="target">
					<option value="_blank">_blank</option>
					<option value="_self">_self</option>
					<option value="_parent">_parent</option>
					<option value="_top">_top</option>
			</select>
	  		</fieldset>
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

