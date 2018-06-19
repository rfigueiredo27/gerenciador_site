
<script>
$(document).ready(function(){
	$( "#vigenciaIni3" ).datepicker();
	$( "#vigenciaFim3" ).datepicker();
});

function criticaAditivo(pidLicitacao, pdescricao, pidConteudo, pnProcesso, pnPregao, pnContrato, pdataPublicacao)
{
	//if (document.fdescAditivo.descricaoAditivo.value == "")
	//	alert("É necessário preencher a descrição.");
	//else
	if (critica_altera_aditivo(document.fdescAditivo))
	{
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_aditivo.jsp", {idConteudo: document.fdescAditivo.idconteudo.value, 
																				idArquivo : document.fdescAditivo.idarquivo.value, 
																				ordem: document.fdescAditivo.ordem.value, 
																				numProcesso: document.fdescAditivo.nProcesso.value, 
																				numContrato: document.fdescAditivo.nContrato.value,
																				dataIni: document.fdescAditivo.vigenciaIni3.value,
																				dataFim: document.fdescAditivo.vigenciaFim3.value,
																				dataPublicacao: document.fdescAditivo.dataPublicacao.value
																				},
				function(){
					/*$.post("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + document.fdescAditivo.idLicitacao.value +
																		"&descricao=" + document.fdescAditivo.descricao.value + 
																		"&idConteudo=" + document.fdescAditivo.idconteudo.value +
																		"&nProcesso=" + document.fdescAditivo.nProcesso.value +
																		"&nPregao=" + document.fdescAditivo.nPregao.value +
																		"&nContrato=" + document.fdescAditivo.nContrato.value +
																		"&dataPublicacao=" + document.fdescAditivo.dataPublicacao.value,
																		function(){document.fdescAditivo.submit()});*/
					//document.fdescAditivo.submit();
					carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + pidLicitacao + "&descricao=" + pdescricao + "&idConteudo=" + pidConteudo + "&nProcesso=" + pnProcesso + "&nPregao=" + pnPregao + "&nContrato=" + pnContrato + "&dataPublicacao=" + pdataPublicacao,"divbusca");
				});
	}
}

</script>
<%
String vnContrato = request.getParameter("nContrato");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
int vordem = Integer.parseInt(request.getParameter("ordem"));

String vidLicitacao = request.getParameter("idLicitacao");
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataVigenciaInicial3 = request.getParameter("dataVigenciaInicial");
String vdataVigenciaFinal3 = request.getParameter("dataVigenciaFinal");
String vdataPublicacao = request.getParameter("dataPublicacao");

%>
<h1>Altera&ccedil;&atilde;o dos dados do aditivo</h1>
<form name="fdescAditivo" action="/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idConteudo=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Nº do Contrato:
        	<input type="text" name="nContrato" id="nContrato" value="<%=vnContrato %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>
        	Nº do Processo:
        	<input type="text" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>
        	Termo aditivo nº <input type="text" name="ordem" id="ordem" value="<%=vordem %>" readonly="readonly" />
        		
        </td>
      </tr>
      <tr>
      	<td>Vigência
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do aditivo" type="text" name="vigenciaIni3" id="vigenciaIni3" size="10" maxlength="10" value="<%=vdataVigenciaInicial3 %>" /> a <input title="Vig&ecirc;ncia final do aditivo" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim3" id="vigenciaFim3" size="10" maxlength="10"  value="<%=vdataVigenciaFinal3 %>" />
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=<%=vidLicitacao %>&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>&nContrato=<%=vnContrato %>&dataPublicacao=<%=vdataPublicacao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAditivo(<%=vidLicitacao %>, '<%=vdescricao %>', <%=vidConteudo %>, '<%=vnProcesso %>', '<%=vnPregao %>' , '<%=vnContrato %>' , '<%=vdataPublicacao %>');"  /> 
        </td>
      </tr>
  </table>
  <input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao%>"/>
  <input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
  <input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
