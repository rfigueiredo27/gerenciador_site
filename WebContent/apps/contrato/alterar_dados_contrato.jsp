<script>
$(document).ready(function(){
	$( "#vigenciaIni2" ).datepicker();
	$( "#vigenciaFim2" ).datepicker();
	$( "#dataPublicacao2" ).datepicker();
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
});

function criticaAnexo(pidLicitacao, pnPregao, pnProcesso)
{
	//if (document.fdescAnexo.descricaoAditivo.value == "")
	//	alert("É necessário preencher a descrição.");
	//else
	if (critica_altera_contrato(document.fdescAnexo))
	{
		
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_contrato.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, 
																					idArquivo : document.fdescAnexo.idarquivo.value, 
																					descricao : document.fdescAnexo.descricao.value,
																					dataPublicacao : document.fdescAnexo.dataPublicacao2.value,
																					dataVigenciaInicial : document.fdescAnexo.vigenciaIni2.value,
																					dataVigenciaFinal : document.fdescAnexo.vigenciaFim2.value,
																					numContrato : document.fdescAnexo.numContrato.value,
																					anoContrato : document.fdescAnexo.anoContrato.value,
																					nProcesso : pnProcesso
																					},
				function(){
					//$.post("/gecoi.3.0/apps/registro_preco/lista_contrato.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					/*$.post("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + document.fdescAnexo.idlicitacao.value +
							"&nPregao=" + document.fdescAnexo.numPregao.value +
							"&nProcesso=" + document.fdescAnexo.nProcesso.value
							//function(){document.fdescAnexo.submit()}
							);*/
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + pidLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");
				});
	}
}

function poeZero()
{
	var numero = parseInt(document.fdescAnexo.numContrato.value);
	//document.fdescAnexo.numContrato.value = String.format("%03d", numero);
	if (numero < 10)
	{
		document.fdescAnexo.numContrato.value = "00" + numero;
	}
	else
	{
		if (numero < 100)
		{
			document.fdescAnexo.numContrato.value = "0" + numero;
		}
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
String[] vcontrato = request.getParameter("nContrato").split("/");
String vnumContrato = vcontrato[0];
String vanoContrato = vcontrato[1];
%>
<div id="altera_contrato">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do contrato</legend>
<div id="numero">
	<div id="descricao_arquivo">
    	<p>Descri&ccedil;&atilde;o: <strong><%=vdescricao%></strong></p>
	</div>
     <div id="numero_processo">
        <p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>
<form name="fdescAnexo" action="/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnPregao %>&nProcesso=<%=vnProcesso %>" method="post"> 
<input type="hidden" name="idlicitacao" id="idlicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
      
	 <div id="numero_contrato">
    		<fieldset>
                <legend>Número/Ano</legend>
					<input type="text" name="numContrato" id="numContrato"  maxlength="9" value="<%=vnumContrato%>" onblur="poeZero();"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2" value="<%=vanoContrato%>"/>
  			</fieldset>
	 </div>
     <div id="vigencia_anexo">
    		<fieldset>
                <legend>Vigência</legend>
				<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni2" id="vigenciaIni2" size="10" maxlength="10" value="<%=vdataVigenciaInicial2%>" /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim2" id="vigenciaFim2" size="10" maxlength="10"  value="<%=vdataVigenciaFinal2%>" />
        	</fieldset>
     </div>
     <div id="data_publicacao">
    		<fieldset>
                <legend>Publica&ccedil;&atilde;o</legend>
                <input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao2" id="dataPublicacao2" size="10" maxlength="10"  value="<%=vdataPublicacao2%>" />
                </fieldset>
     </div>
     
        		<input type="hidden" name="descricao" id="descricao" readonly="readonly" value="<%=vdescricao%>"/>
   			<!-- <textarea title="Descri&ccedil;&atilde;o do contrato" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"><%=vdescricao%></textarea>
   			<span id="contadorDescricao" class="alert"></span>-->
        	
     <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(<%=vidLicitacao%>, '<%=vnPregao%>' , '<%=vnProcesso%>');"  /> 
     </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
