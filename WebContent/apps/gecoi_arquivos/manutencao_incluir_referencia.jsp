
<%@page import = "java.text.*,java.util.*,java.sql.*" %>


<% 
int vprincipal   =  (request.getParameter("idprincipal")==null) ? 0 : Integer.parseInt(request.getParameter("idprincipal").toString()); 
String vdescricao  = request.getParameter("descricao");
%>
<div id="altera_dados">

<fieldset>
<legend>Inclusão de Referências</legend>
<form method="post" class="form-horizontal" name="inclusao" id="inclusao">
	
	<div class="form-group">
		<label class="control-label col-sm-2" for="tipo">Tipo de Conte&uacute;do:</label>
		<div class="col-sm-10">
    		<select class="form-control" name="tipo" id="tipo" onchange="atualiza_unidade();">
    			<option value="0">-----------</option>
    			<option value="1">Arquivos</option>
    			<option value="2">Avisos</option>
    			<option value="3">&Aacute;lbum</option>
    		</select>
    	</div>
    </div>

    <div class="form-group">
	    <label class="control-label col-sm-2" for="unidade">Unidade:</label>
	    <div id="idUnidade" class="col-sm-10">
		    <select class="form-control" name="grupo" id="grupo" disabled="disabled" onchange="atualiza_area();">
		    	<option value="-5">-----------</option>
	    	</select>
	    </div>
    </div>
    
    
    <div class="form-group">
    	<label class="control-label col-sm-2" for="area">&Aacute;rea:</label>
    	<div id="idarea" class="col-sm-10">
	    	<select class="form-control" name="area" id="area" disabled="disabled" onchange="atualiza_ano();">
	    		<option value="0">-----------</option>
	    	</select>
	    </div>
    </div>
    
    <div class="form-group">
    	<label class="control-label col-sm-2" for="ano">Ano:</label>
    	<div id="idano" class="col-sm-10">
    		<select class="form-control" name="ano" id="ano" disabled="disabled">
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
    
    <input name="principal" type="hidden" value="<%=vprincipal%>" />

    <div id="botao">
    <input type="button" onclick="listar_referencia(this.form);" name="pesquisar" value="Pesquisar"  />  
<%--     <input type="button" onclick="document.location.href='/gecoi.3.0/apps/gecoi_arquivos/manutencao_referencia.jsp?idprincipal=<%=vprincipal%>&descricao=<%=vdescricao%>';" name="voltar" value="Voltar"  /> --%>
    <input type="button" onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/manutencao_referencia.jsp?idprincipal=<%=vprincipal%>&descricao=<%=vdescricao%>','divbusca');" name="voltar" value="Voltar"  />
    </div>
	<div id="mensagem" class="destaque" ></div><hr width="745px" />
    
<div id='divconteudo2' class='productInformation'></div>
</form>
</fieldset>
</div>

