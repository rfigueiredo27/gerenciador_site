<%@page import="java.net.SocketException"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.sun.jmx.snmp.Enumerated"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"> 

<style>

legend
{
	margin-bottom:0px;
	border-bottom: none;
	width: auto;
}



</style>

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirArquivo" method="post"  target="processa_background" enctype="multipart/form-data" autocomplete="off" accept-charset="UTF-8">

	<div id="selecionar_area" align="left">
		<fieldset>
			<legend>Área de Publicação*</legend>
			<jsp:useBean id="lista_incluir"	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
			<c:set var="items" value="${lista_incluir.getArea(sessionScope['login'], sessionScope['senha'])}" />
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
                <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" 
                data-error="Insira uma data correta" required/>
                <div class="help-block with-errors"></div>
	  		</fieldset>
	</div>

	<div id="titulo" align="left">
		<fieldset>
			<legend>Observação</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="observacao" id="observacao" data-error="Esse campo é obrigatório" />
		</fieldset>
	</div>

	<div id="titulo" align="left">
		<fieldset>
		<legend>Descrição do Arquivo Principal</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descricao" id="descricao_incluir" data-error="Esse campo é obrigatório" required/>		
		</fieldset>
	</div>
	<div id="arquivo_pdf" align="left">
		<fieldset>
			<legend>Inclusão do Arquivo Principal</legend>
				<div id="campoArquivo">
				<input type="file" name="arquivo" id="arquivo" alt="Arquivo a ser inserido" required> 
				</div>
		</fieldset>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
					<div id="progressBarText"></div>
					<div id="progressBarBox">
						<div id="progressBarBoxContent"></div>
					</div>
				</div>
			</div>
	</div>

	<br> <br>

	<div id="dynamicDiv1">
			<a class="add" style="text-decoration:none" href="javascript:void(0)" id="addInput">
				(+) Adicionar Arquivo(s)
			</a>
	</div>

<!-- 	<input type="hidden" name="total_anexos" id="total_anexos" value = "0" /> -->
	<br> <br> <br>
	<div id="botao">
<!-- 		<input type="submit" name="button" id="button" value="Publicar"	/> -->
<!-- 		<input type="button" name="button" id="button" value="Publicar"	onClick="validar_anexos();" /> -->
		<input type="button" name="button" id="button" value="Publicar"	onClick="critica_inclusao_arquivos(document.finclusao);" />
		<input type="reset" value="Limpar">
	</div>

</form>



<script>
	$(function() {
		var scntDiv = $('#dynamicDiv1');
		$(document).on('click','#addInput',	function() {
							$('#total_anexos').val(parseInt($('#total_anexos').val())+1);
							$(
									'<z><br><br>'
									
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
							return false;
						});
		$(document).on('click', '#remInput', function() { $('#total_anexos').val(parseInt($('#total_anexos').val())-1);
			$(this).parents('z').remove();
			return false;
		});
	});
</script>

