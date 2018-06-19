<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
{
	if (pnumAta != '0')
		alert("Foi gravada a ata de número " + pnumAta);
	carregaPag("/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.getElementById("divnumProcesso").innerHTML + "&nPregao=" + document.getElementById("divnumPregao").innerHTML, "divbusca");
}


function criticaAnexo(ar)
{
	
		critica_inclusao_registro(document.fincAnexo,ar);
	
}

$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
	$( "#dataVigenciaInicial" ).datepicker();
	$( "#dataVigenciaFinal" ).datepicker();
});


</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
%>

<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Atas de Registro de Pre&ccedil;os</legend>
    <div id="numero">
    <div id="numero_processo">
        <strong><p>N&uacute;mero do processo: <br /><div id="divnumProcesso"><%=vnumProcesso %></div></p></strong>
	</div>
	<div id="numero_pregao">
        <strong><p>N&uacute;mero do preg&atilde;o: <br /><div id="divnumPregao"><%=vnumPregao %></div></p></strong>
	</div>
</div>
<form name="fincAnexo" action="/gecoi.3.0/IncluirRegistroPrecoSeccon" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidLicitacao%>"/>
 		<div id="data_anexo">
    		<fieldset>
                <legend>Data de Publicação</legend>
                <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" />
	  		</fieldset>
	    </div>
      
	    <div id="vigencia_anexo">
    		<fieldset>
                <legend>Vigência</legend>
	  				<input title="Data de vigência inicial" alt="Data de vigência inicial" type="text" name="dataVigenciaInicial" id="dataVigenciaInicial" size="10" maxlength="10" /> a <input title="Data de vigência final" alt="Data de vigência final" type="text" name="dataVigenciaFinal" id="dataVigenciaFinal" size="10" maxlength="10" />
	  	    </fieldset>
	    </div>
        <div id="numero_anexo">
    		<fieldset>
                <legend>Número da Ata</legend>
                <p>É gerado automaticamente após a inclusão!</p>
            </fieldset>
	    </div>
      
        <div id="descricao_anexo">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o do Objeto da Ata</legend>
        	 	<textarea title="Descri&ccedil;&atilde;o da ata" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
   			<span id="contadorDescricao" class="alert"></span>
        </fieldset>
	  </div>
      <div id="incluir_arquivo">
      	<fieldset>
        <legend>Incluir Arquivo</legend>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
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
      <div id="botao">
          <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(this.form.anexo.value);"  />
       </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
