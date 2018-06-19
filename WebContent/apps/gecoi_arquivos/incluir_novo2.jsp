<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>


<style>
#botao input[type="reset"] {
	font-family: Tahoma, Arial, Helvetica, sans-serif;
	font-size: 13px;
	background: #ECECEC;
	color: #777777;
	border: #777777 solid 1px;
	height: 32px;
	width: 120px;
}

</style>



<form name="finclusao2" id="finclusao2"
	action="/gecoi.3.0/IncluirArquivo2" method="post"
	data-toggle="validator" target="processa_background"
	enctype="multipart/form-data" id="formulario" autocomplete="off">

	<div id="selecionar_area" align="left">
		<fieldset>
			<legend>Área de Publicação*</legend>
			<jsp:useBean id="lista_incluir2"
				class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
			<c:set var="items"
				value="${lista_incluir2.getArea(sessionScope['login'], sessionScope['senha'])}" />
			<select name='area' id='area' required>
				<option value=''>--</option>
				<c:forEach var="lista_gecoi" items="${items}">
					<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao_area }</option>
				</c:forEach>
			</select>
		</fieldset>
	</div>

	<div id="data_publicacao" align="left">
		<fieldset>
			<legend>Data de Publicação</legend>
			<input title="Data de publicação" alt="Data de publicação"
				type="text" name="dataPublicacao" id="dataPublicacao2" size="10"
				maxlength="10" required />
		</fieldset>
	</div>

	<div id="titulo" align="left">
		<fieldset>
			<legend>Observação</legend>
			<input type="text" title="Descri&ccedil;&atilde;o do objeto"
				name="observacao" id="observacao" />
		</fieldset>
	</div>

	<div id="titulo" align="left">
		<fieldset>
			<legend>Descrição do Arquivo Principal</legend>
			<input type="text" title="Descri&ccedil;&atilde;o do objeto"
				name="descricao" id="descricao_incluir" required />
		</fieldset>
	</div>
	<div id="arquivo_pdf" align="left">
		<fieldset>
			<legend>Inclusão do Arquivo Principal</legend>
			<div id="campoArquivo2">
				<input type="file" name="arquivo" id="arquivo"
					alt="Arquivo a ser inserido" required>
			</div>
		</fieldset>
		<div id="progressBar2" style="display: none;">
			<div id="theMeter2">
				<div id="progressBarText2"></div>
				<div id="progressBarBox2">
					<div id="progressBarBoxContent2"></div>
				</div>
			</div>
		</div>
	</div>

	<br> <br>

	<div id="dynamicDiv2">

		<a class="add" style="text-decoration: none" href="javascript:void(0)"
			id="addInput2"> (+) Adicionar Arquivo(s) </a>

	</div>


	<br> <br> <br>
	<div id="botao">
		<!-- 		<input type="submit" name="button" id="button" value="Publicar"	/> -->
		<input type="button" name="button" id="button" value="Publicar"
			onClick="critica_inclusao_arquivos2(document.finclusao2);" /> <input
			type="reset" value="Limpar">
	</div>
<input type="hidden" name="total_anexos" id="total_anexos" value="0" />

</form>



<script>
	$(function() {
		var scntDiv = $('#dynamicDiv2');
		$(document)
				.on(
						'click',
						'#addInput2',
						function() {
							$('#total_anexos').val(parseInt($('#total_anexos').val())+1);
							$(
									'<z><br><br>'
											+	'<div id="data_publicacao" align="left">'
											+   '<fieldset>'
											+   '<legend>Data de Publicação</legend>'
											+   '<input title="Data de publicação" alt="Data de publicação" type="text" class="date" name="data_anexo'+$('#total_anexos').val()+'" id="data_anexo'+$('#total_anexos').val()+'" size="10" maxlength="10" required/>'
											+	'</fieldset>'
											+	'</div>'
											+	'<div id="titulo" align="left">'
											+	'<fieldset>'
											+	'<legend>Descrição</legend>'
											+	'<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descanexo" id="descanexo" required/>'
											+	'</fieldset>'
											+	'</div>'
											+	'<div id="arquivo_pdf" align="left">'
											+   '<fieldset>'
											+   '<legend>Incluir Arquivo</legend>'
											+	'<input type="file" name="arquivo_anexo" id="arquivo_anexo" alt="Arquivo a ser inserido" required />' 
											+	'</fieldset>'
											+	'</div>'
											+	'</div>'
											+	'<div id="progressBar" style="display: none;">'
											+	'<div id="theMeter">'
											+	'<div id="progressBarText"></div>'
											+	'<div id="progressBarBox">'
											+	'<div id="progressBarBoxContent"></div>'
											+	'</div>'
											+	'</div>'
											+	'</div>'
											+ '<a class="rem" style="text-decoration:none" href="javascript:void(0)" id="remInput">'
											+ '<br>'
											+ '(-) Remover Arquivo' + '</a>'
											+ '<z>').appendTo(scntDiv);
							$('.date').datepicker({'autoclose': true});
							return false;
						});
		$(document).on('click', '#remInput', function() { $('#total_anexos').val(parseInt($('#total_anexos').val())-1);
			$(this).parents('z').remove();
			return false;
		});
	});
</script>


<script>$( function() {$( "#dataPublicacao" ).datepicker();} );</script>
