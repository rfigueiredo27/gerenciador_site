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

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirAviso"	method="post"  data-toggle="validator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
	<div id="modalidade" align="left">
		<fieldset>
			<legend>Destino da Publicação</legend>
			<jsp:useBean id="lista_incluir"
				class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
			<c:set var="items"
				value="${lista_incluir.getDestino(sessionScope['login'], sessionScope['senha'])}" />
			<select style="width: 100%;" name='destino' id='destino'>
				<option value='0'>--</option>
				<c:forEach var="lista_gecoi" items="${items}">
					<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao }</option>
				</c:forEach>
			</select>
		</fieldset>
	</div>

	<div id="descricao_incluir" align="left">
		<fieldset>
			<legend>Título do Aviso</legend>
			<div align="left">
				<textarea title="Descri&ccedil;&atilde;o do objeto"	name="descricao" id="descricao_incluir"></textarea>
			</div>
			
		</fieldset>
	</div>

	<div id="descricao_incluir" align="left">
		<fieldset>
			<legend>Incluir Arquivo do Aviso</legend>
			<div id="campoArquivo" align="left">

				<br /> <input type="file" name="arquivo" id="arquivo" alt="Arquivo a ser inserido" required> 

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

	<br> <br>

	<div id="dynamicDiv" align="left">

			<a class="add" style="text-decoration:none" href="javascript:void(0)" id="addInput">
				(+) Adicionar Anexo(s)
			</a>
	
	</div>

	<input type="hidden" name="total_anexos" id="total_anexos" value = "0" />
	<br> <br> <br>
	<div id="botao">
		<input type="button" name="button" id="button" value="Publicar"	onClick="critica_inclusao_aviso(document.finclusao,this.form.arquivo.value);" />
		<input type="reset" value="Limpar">
	</div>


</form>



<script>
	$(function() {
		var scntDiv = $('#dynamicDiv');
		$(document)
				.on(
						'click',
						'#addInput',
						function() {
							$('#total_anexos').val(parseInt($('#total_anexos').val())+1);
							$(
									'<z><br><br>'
											+ '<div id="descricao_incluir" align="left">'
											+ '<fieldset>'
											+ '<legend>Descrição do Anexo</legend>'
											+ '<textarea title="Descri&ccedil;&atilde;o do objeto" name="descricao_anexo"' 
											+ 'id="descricao_anexo" required></textarea>'
											+ '</fieldset></div>'
											
											+ '<div id="descricao_incluir" align="left">'
											+ '<fieldset>'
											+ '<legend>Incluir Arquivo do Anexo</legend>'
											+ '<div id="campoArquivo" align="left">'
											+ ''
											+ '<input type="file" name="anexo" id="anexo" alt="Anexo a ser inserido">'
											+ '<div id="progressBar" style="display: none;">'
											+ '<div id="theMeter">'
											+ '<div id="progressBarText"></div>'
											+ '<div id="progressBarBox">'
											+ '<div id="progressBarBoxContent"></div>'
											+ '</div>'
											+ '</div>'
											+ '</div>'
											+ '</fieldset>'
											+ '</div>'
											+ '<a class="rem" style="text-decoration:none" href="javascript:void(0)" id="remInput">'
											+ '<br>'
											+ '(-) Remover Anexo' + '</a>'
											+ '<z>').appendTo(scntDiv);
							return false;
						});
		$(document).on('click', '#remInput', function() { $('#total_anexos').val(parseInt($('#total_anexos').val())-1);
			$(this).parents('z').remove();
			return false;
		});
	});
</script>

