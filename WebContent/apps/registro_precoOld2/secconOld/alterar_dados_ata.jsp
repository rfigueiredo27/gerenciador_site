<script>
$(document).ready(function(){
	$( "#dataPublicacao2" ).datepicker();
	$( "#dataVigenciaInicial2" ).datepicker();
	$( "#dataVigenciaFinal2" ).datepicker();
});

function criticaAnexo(pLicitacao, pnPregao, pnProcesso)
{
	if (critica_altera_registro(document.fdescAnexo))
	{
		$.post("/gecoi.3.0/apps/registro_preco/seccon/processa_alteracao_dados_ata.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, 
																					idArquivo : document.fdescAnexo.idarquivo.value, 
																					descricao : document.fdescAnexo.numAta.value + " - " + document.fdescAnexo.descricao.value,
																					dataPublicacao : document.fdescAnexo.dataPublicacao2.value,
																					dataVigenciaInicial : document.fdescAnexo.dataVigenciaInicial2.value,
																					dataVigenciaFinal : document.fdescAnexo.dataVigenciaFinal2.value,
																					idArea : document.fdescAnexo.idarea.value
																					},
				function(){
					carregaPag("/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + pLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");
				});
	}
}
</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
String vdataPublicacao2 = request.getParameter("dataPublicacao");
String vdataVigenciaInicial2 = request.getParameter("dataVigenciaInicial");
String vdataVigenciaFinal2 = request.getParameter("dataVigenciaFinal");
String vidArea = request.getParameter("idArea");
String vnumAta = request.getParameter("numAta");
%>

<div id="altera_ata">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados da ata de registro de pre&ccedil;os</legend>
<div id="numero">
    <div id="numero_processo">
        <p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>
<form name="fdescAnexo" action="/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnPregao %>&nProcesso=<%=vnProcesso %>" method="post"> 
<input type="hidden" name="idlicitacao" id="idlicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=vidArea%>"/>

      <div id="data">
    		<fieldset>
                <legend>Data de Publicação</legend>
	  		 	<input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao2" id="dataPublicacao2" size="10" maxlength="10" value="<%=vdataPublicacao2 %>" />
	  		</fieldset>
	  </div>
      
	  <div id="vigencia">
    		<fieldset>
                <legend>Vigência</legend>
	  			<input title="Data de vigência Inicial" alt="Data de vigência Inicial" type="text" name="dataVigenciaInicial2" id="dataVigenciaInicial2" size="10" maxlength="10" value="<%=vdataVigenciaInicial2 %>" /> a <input title="Data de vigência Final" alt="Data de vigência Final" type="text" name="dataVigenciaFinal2" id="dataVigenciaFinal2" size="10" maxlength="10" value="<%=vdataVigenciaFinal2 %>" />
                </fieldset>
	  </div>
      
	  	<div id="descricao">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o</legend>
	  			<p><strong><%=vnumAta %></strong></p>
	  			<input type="hidden" name="numAta" id="numAta" value="<%=vnumAta %>" />
        		<textarea title="Descri&ccedil;&atilde;o da ata" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"><%=vdescricao %></textarea>
   				<span id="contadorDescricao" class="alert"></span>
           </fieldset>
	  </div>
      
      <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(<%=vidLicitacao%>, '<%=vnPregao%>', '<%=vnProcesso%>');"  /> 
     </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
