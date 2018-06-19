
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<style>
legend {
	margin-bottom: 0px;
	border-bottom: none;
	width: auto;
}
</style>

<script>
function atualizaTela()
{
	document.fincInclusao.reset();
}


function critica()
{
	critica_inclusao(document.fincInclusao);
	zera_contador();
}



</script>

<%

		//Obter ano atual
		Date data = new Date(System.currentTimeMillis());  
		SimpleDateFormat formatarDate = new SimpleDateFormat("yyyy"); 
		String ano = formatarDate.format(data);

%>

<form name="fincInclusao"	action="/gecoi.3.0/apps/prestacao_contas/processa_incluir.jsp"	method="post" target="rodape" enctype="multipart/form-data">
	<div id="edital_ano">
		<fieldset>
			<legend>Edital/Ano</legend>
			<input title="Numero do Edital" alt="Numero do Edital" type="number" name="edital" id="edital" required/><span id="personalizado">&nbsp;/</span>
			<input title="Ano do Edital" alt="Ano do Edital" type="number" name="ano" id="ano" value="<%=ano%>" required/>
		</fieldset>
	</div>
	
	<div id="prestacao_contas">
		<fieldset>
			<legend>Prestação de Contas</legend>
			<input title="Prestacao de contas" alt="Prestacao de contas" type="text" name="prestacao" id="prestacao" required/>
		</fieldset>
	</div>
	
	<div id="partido_politico">
		<fieldset>
			<legend>Partido Político</legend>
			<input title="Partido" alt="PPartido" type="text" name="partido" id="partido" />
		</fieldset>
	</div>
	
	<div id="balanco_arquivo">
		<fieldset>
			<legend>Selecione o arquivo de Balanço</legend>
			<input name="balanco" type="file" id="balanco" required>
		</fieldset>
	</div>
	
	<div id="demonstrativo_arquivo">
		<fieldset>
			<legend>Selecione o arquivo de Demonstrativo (opcional)</legend>
			<input name="demonstrativo" type="file" id="demonstrativo">
		</fieldset>
	</div>
	<div id="editar_arquivo">
		<fieldset>
			<legend>Inclus&atilde;o do Texto<br></legend>
			<textarea name="vtexto" id="vtexto" required="required"></textarea>
			<script>
				//ClassicEditor.create(document.querySelector('#ckeditor_editor' )).then( editor => {console.log( editor );}).catch( error => {console.error( error );} );
            	CKEDITOR.replace('vtexto');
            </script>
		</fieldset>
	</div>
	<div id="campoArquivo"></div>
	<div id="progressBar" style="display: none;">
		<div id="theMeter">
			<div id="progressBarText"></div>
			<div id="progressBarBox">
				<div id="progressBarBoxContent"></div>
			</div>
		</div>
	</div>
	<div id="botao">
		<input type="submit" name="gravar" id="gravar" value="Gravar" />
	</div>
</form>


<iframe name="rodape" frameborder="0" allowtransparency="yes"
	height="0" width="0"></iframe>
