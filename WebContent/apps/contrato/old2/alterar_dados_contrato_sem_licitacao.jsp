<script>
$(document).ready(function(){
	$( "#vigenciaIni5" ).datepicker();
	$( "#vigenciaFim5" ).datepicker();
	$( "#dataPublicacao5" ).datepicker();
});

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");
}

function criticaAnexo()
{
	if (critica_altera_contrato_sem_licitacao(document.fdescAnexo))
	{
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_contrato_sem_licitacao.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, 
																					idArquivo : document.fdescAnexo.idarquivo.value, 
																					descricao : document.fdescAnexo.descricao.value,
																					dataPublicacao : document.fdescAnexo.dataPublicacao5.value,
																					dataVigenciaInicial : document.fdescAnexo.vigenciaIni5.value,
																					dataVigenciaFinal : document.fdescAnexo.vigenciaFim5.value,
																					numContrato : document.fdescAnexo.numContrato.value,
																					anoContrato : document.fdescAnexo.anoContrato.value,
																					numProcesso : document.fdescAnexo.numProcesso.value,
																					anoProcesso : document.fdescAnexo.anoProcesso.value,
																					observacao : document.fdescAnexo.observacao.value,
																					idArea : document.fdescAnexo.idArea.value
																					},
				function(){
					atualizaTela();
				});
	}
}
</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao5 = request.getParameter("dataPublicacao");
String vdataVigenciaInicial5 = request.getParameter("dataVigenciaInicial");
String vdataVigenciaFinal5 = request.getParameter("dataVigenciaFinal");
String[] vcontrato = request.getParameter("nContrato").split("/");
String vnumContrato = vcontrato[0];
String vanoContrato = vcontrato[1];
String[] vprocesso = request.getParameter("nProcesso").split("/");
String vnumProcesso = vprocesso[0];
String vanoProcesso = vprocesso[1];
String vobservacao = request.getParameter("observacao");
String vidArea = request.getParameter("idArea");
%>
<h1>Altera&ccedil;&atilde;o dos dados do contrato</h1>
<form name="fdescAnexo" action=""> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idArea" id="idArea" value="<%=vidArea%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr><td>Número / ano do Processo:</td>
        <td>
        	<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" size="6" maxlength="7" onKeyDown="FormataNumero(this,event);" value="<%=vnumProcesso %>" />/<input title="Ano do processo com 4 d&iacute;gitos" alt="Ano do processo com 4 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" size="4" maxlength="4" value="<%=vanoProcesso %>" />
        </td>
      </tr>
	 <tr><td>Nº do Contrato / Ano do Contrato</td>
        <td>
			<input type="text" name="numContrato" id="numContrato"  maxlength="9" value="<%=vnumContrato%>"/> / <input type="text" name="anoContrato" id="anoContrato"  maxlength="2" value="<%=vanoContrato%>"/>
        </td>
      </tr>
      <tr><td>Vigência</td>
        <td >
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni5" id="vigenciaIni5" size="10" maxlength="10" value="<%=vdataVigenciaInicial5%>" /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim5" id="vigenciaFim5" size="10" maxlength="10"  value="<%=vdataVigenciaFinal5%>" />
        </td>
      </tr>
      <tr><td>Descri&ccedil;&atilde;o</td>
        <td>
   			<textarea title="Descri&ccedil;&atilde;o do contrato" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao5', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao5', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao5', 1000);"><%=vdescricao%></textarea>
   			<span id="contadorDescricao5" class="alert"></span>
        </td>
      </tr>
      <tr><td>Data de Publica&ccedil;&atilde;o</td>
        <td >
			<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao5" id="dataPublicacao5" size="10" maxlength="10"  value="<%=vdataPublicacao5%>" />
        </td>
      </tr>
      <tr><td>Observa&ccedil;&atilde;o</td>
        <td >
			<textarea title="Observa&ccedil;&atilde;o do contrato" name="observacao" id="observacao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.observacao, 'contadorObservacao5', 1000);" onKeyUp="javascript:resta(this.form.observacao, 'contadorObservacao5', 1000);" onKeyDown="javascript:resta(this.form.observacao, 'contadorObservacao5', 1000);"><%=vobservacao %></textarea>
   			<span id="contadorObservacao5" class="alert"></span>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
