<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import = "java.text.*,java.util.*,java.sql.*" %>
<div id="altera_dados">

<fieldset>
<legend><strong>Inclusão de Conteúdos no Catálogo</strong></legend>
<form method="post" class="form-horizontal" name="inclusao" id="inclusao">
	
	<div class="form-group">
			<label class="control-label col-sm-2" for="tipo">Grupo de Acesso*</label>
			<div class="col-sm-10">
			<jsp:useBean id="lista_grupos2" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
			<c:set var="items" value="${lista_grupos2.getGrupo(sessionScope['login'], sessionScope['senha'])}" />
			<select class="form-control" name="grupo2" id="grupo2" onchange="atualiza_catalogo_incluir(this.form);">
				<option value='-5'>-----------</option>
				<c:forEach var="lista_grupo" items="${items}">
					<option value="${lista_grupo.id_grupo}">${lista_grupo.descricao_grupo}</option>
				</c:forEach>
			</select>
			</div>
	</div>
	
	<div class="form-group">	
			<label class="control-label col-sm-2" for="tipo">Catalogo*</label>
            	<div id="divCatalogo_Incluir" class="col-sm-10">
            		<select name="catalogo" class="form-control" id="catalogo" >
            			<option value="0">-----------</option>
            		</select>
            	</div>
	</div>
	<hr width="745px" />
	
	<fieldset style="min-height: 200px;">
	<legend>*Filtros para Pesquisa*</legend>
	<div class="form-group">
		<label class="control-label col-sm-2" for="tipo">Tipo de Conte&uacute;do:</label>
		<div class="col-sm-10">
    		<select class="form-control" name="tipo2" id="tipo2" onchange="atualiza_unidade_incluir(this.form);">
    			<option value="0">-----------</option>
    			<option value="1">Arquivos</option>
    			<option value="2">Avisos</option>
    			<option value="3">&Aacute;lbum</option>
    		</select>
    	</div>
    </div>

    <div class="form-group">
	    <label class="control-label col-sm-2" for="unidade">Unidade:</label>
	    <div id="divTipo_incluir" class="col-sm-10">
		    <select class="form-control" name="unidade2" id="unidade2" onchange="atualiza_area_incluir(this.form);">
		    	<option value="-5">-----------</option>
	    	</select>
	    </div>
    </div>
    
    
    <div class="form-group">
    	<label class="control-label col-sm-2" for="area">&Aacute;rea:</label>
    	<div id="divArea_incluir" class="col-sm-10">
	    	<select class="form-control" name="area2" id="area2" onchange="atualiza_ano_incluir(this.form);">
	    		<option value="0">-----------</option>
	    	</select>
	    </div>
    </div>
    
    <div class="form-group">
    	<label class="control-label col-sm-2" for="ano">Ano:</label>
    	<div id="divAno_incluir" class="col-sm-10">
    		<select class="form-control" name="ano2" id="ano2">
    			<option value="0">-----------</option>
    		</select>
    	</div>
    </div>
    
	<div class="form-group">
		<label class="control-label col-sm-2" for="chave">Palavra Chave:</label>
    	<div class="col-sm-10">
    		<input class="form-control" name="chave" type="text" size="60" maxlength="100" />
    	</div>
    </div>
    <div id="botao">
    		<input type="button" onclick="listar_referencia(this.form);" name="pesquisar" value="Pesquisar"  />  
	</div>
	<div id="mensagem" class="destaque" ></div><hr width="745px" />
    
    </fieldset>
    
    
<div id='divconteudo2' class='productInformation'></div>
</form>
</fieldset>
</div>

