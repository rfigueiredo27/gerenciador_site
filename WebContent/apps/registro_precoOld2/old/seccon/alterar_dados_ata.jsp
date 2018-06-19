<script>
$(document).ready(function(){
	$( "#dataPublicacao2" ).datepicker();
	$( "#dataVigenciaInicial2" ).datepicker();
	$( "#dataVigenciaFinal2" ).datepicker();
});

function criticaAnexo(pLicitacao, pnPregao, pnProcesso)
{
	//if (document.fdescAnexo.descricaoAditivo.value == "")
	//	alert("É necessário preencher a descrição.");
	//else
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
					//$.post("/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					/*$.post("/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=" + document.fdescAnexo.idlicitacao.value +
							"&nPregao=" + document.fdescAnexo.numPregao.value +
							"&nProcesso=" + document.fdescAnexo.nProcesso.value,
							function(){document.fdescAnexo.submit()});*/
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=" + pLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");
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
<h1>Altera&ccedil;&atilde;o dos dados da ata de registro de pre&ccedil;os</h1>
<form name="fdescAnexo" action="/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnPregao %>&nProcesso=<%=vnProcesso %>" method="post"> 
<input type="hidden" name="idlicitacao" id="idlicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=vidArea%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Nº do Processo:
        	<input type="text" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>" readonly="readonly" />
        </td>
      </tr>
	  <tr>
	  	<td>
	  		Número do Pregão: <input type="text" name="numPregao" id="numPregao" value="<%=vnPregao %>" readonly="readonly" />
	  	</td>
	  </tr>
	  <tr>
	  	<td>
	  		Data de Publicação <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao2" id="dataPublicacao2" size="10" maxlength="10" value="<%=vdataPublicacao2 %>" />
	  	</td>
	  </tr>
	  <tr>
	  	<td>
	  		Vigência: <input title="Data de vigência Inicial" alt="Data de vigência Inicial" type="text" name="dataVigenciaInicial2" id="dataVigenciaInicial2" size="10" maxlength="10" value="<%=vdataVigenciaInicial2 %>" /> a <input title="Data de vigência Final" alt="Data de vigência Final" type="text" name="dataVigenciaFinal2" id="dataVigenciaFinal2" size="10" maxlength="10" value="<%=vdataVigenciaFinal2 %>" />
	  	</td>
	  </tr>
      <tr>
        <td>
        	Descrição <br>
	  		<%=vnumAta %><br>
	  		<input type="hidden" name="numAta" id="numAta" value="<%=vnumAta %>" />
        	<textarea title="Descri&ccedil;&atilde;o da ata" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"><%=vdescricao %></textarea>
   			<span id="contadorDescricao" class="alert"></span>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/alterar_anexo.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(<%=vidLicitacao%>, '<%=vnPregao%>', '<%=vnProcesso%>');"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
