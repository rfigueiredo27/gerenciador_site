<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<form name="finclusao" id="finclusao" action="/gecoi.3.0/IncluirDocumento" onsubmit="" method="post"  data-toggle="
idator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
	<div id="flex">
		
	<div id="unidade" >
		<fieldset>
			<legend>Unidade</legend>
			<jsp:useBean id="lista_grupos" class="br.jus.trerj.controle.documentoEliminacao.ListaDocumentosEliminacao" />
			<c:set var="items" value="${lista_grupos.getUnidades(sessionScope['login'], sessionScope['senha'])}" />
			<select name="unidade" id="unidade">
					<option value="">--</option>
				<c:forEach var="lista_grupo" items="${items}">
					<option value="${lista_grupo.unidade}">${lista_grupo.unidade}</option>
				</c:forEach>
			</select>
			</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Edital/Ano</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="edital" id="edital" placeholder="0000/0000"/>
		</fieldset>
	</div>
	
	<div id="data">
    		<fieldset>
                <legend>Data de Publicação</legend>
                <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" 
                data-error="Insira uma data correta" required placeholder="DD/MM/YYYY"/>
	  		</fieldset>
	</div>
	</div>
	
	<div id="arquivo_principal">
		<fieldset>
			<legend>Edital de Ciência de Eliminação de Documentos</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descricao1" id="descricao1" placeholder="Descrição do Arquivo Principal"/>
				<div id="campoArquivo">
				<input type="file" name="arquivo1" id="arquivo1" alt="Arquivo a ser inserido" required> 
				</div>
		</fieldset>
	</div>
	
	<div id="arquivo_anexo">
		<fieldset>
			<legend>Lista de Documentos para Eliminação</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descricao2" id="descricao2" placeholder="Descrição do Arquivo Anexo"/>
				<div id="campoArquivo">
				<input type="file" name="arquivo2" id="arquivo2" alt="Arquivo a ser inserido" required> 
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
	<br><br>
	<div id="botao" align="center">
		<input type="button" name="button" id="button" value="Publicar"	onClick="critica_inclusao(document.finclusao);" />
	</div>
	
</form>

