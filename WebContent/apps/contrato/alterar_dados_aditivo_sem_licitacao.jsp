
<script>
function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=" + document.fdescAditivo.descricao.value + "&idConteudo=" + document.fdescAditivo.idConteudo.value + "&nProcesso=" + document.fdescAditivo.nProcesso.value + "&nContrato=" + document.fdescAditivo.nContrato.value + "&dataPublicacao=" + document.fdescAditivo.dataPublicacao.value + "&idArea=" + document.fdescAditivo.idArea.value, "divbusca2");
}

$(document).ready(function(){
	$( "#vigenciaIni7" ).datepicker();
	$( "#vigenciaFim7" ).datepicker();
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
});

function criticaAditivo()
{
	if (critica_altera_aditivo_sem_licitacao(document.fdescAditivo))
	{
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_aditivo_sem_licitacao.jsp", {idConteudo: document.fdescAditivo.idConteudo.value, 
																				idArquivo : document.fdescAditivo.idArquivo.value, 
																				ordem: document.fdescAditivo.ordem.value, 
																				termo: document.fdescAditivo.termo.value,
																				numProcesso: document.fdescAditivo.nProcesso.value, 
																				numContrato: document.fdescAditivo.nContrato.value,
																				dataIni: document.fdescAditivo.vigenciaIni7.value,
																				dataFim: document.fdescAditivo.vigenciaFim7.value,
																				dataPublicacao: document.fdescAditivo.dataPublicacao.value,
																				idArea : document.fdescAditivo.idArea.value
																				},
				function(){
							atualizaTela();
				});
	}
}

</script>
<%
String vnContrato = request.getParameter("nContrato");
String vnProcesso = request.getParameter("nProcesso");
int vordem = Integer.parseInt(request.getParameter("ordem"));
int vtermo = Integer.parseInt(request.getParameter("termo"));

String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataVigenciaInicial7 = request.getParameter("dataVigenciaInicial");
String vdataVigenciaFinal7 = request.getParameter("dataVigenciaFinal");
String vdataPublicacao = request.getParameter("dataPublicacao");
String vidArea = request.getParameter("idArea");

%>

<div id="altera_arquivo">
	<fieldset>
		<legend>Altera&ccedil;&atilde;o dos dados do aditivo</legend>
<form name="fdescAditivo" action=""> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>"/>
<input type="hidden" name="ordem" id="ordem" value="<%=vordem %>"/>
<input type="hidden" name="termo" id="termo" value="<%=vtermo %>"/>
<div id="numero">
	<div id="descricao_arquivo">
    	<p>N&uacute;mero do Termo aditivo: <strong><%=vtermo %></strong></p>
	</div>
    <div id="numero_pregao">
    	<p>N&uacute;mero Contrato: <br /><strong><%=vnContrato%></strong></p>
	</div>
	<div id="numero_processo">
    	<p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
</div>
<div id="vigencia_aditivo">
  <fieldset>
  	<legend>Vigência</legend>
		<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do aditivo" type="text" name="vigenciaIni7" id="vigenciaIni7" size="10" maxlength="10" value="<%=vdataVigenciaInicial7 %>" /> a <input title="Vig&ecirc;ncia final do aditivo" alt="Vig&ecirc;ncia final do aditivo" type="text" name="vigenciaFim7" id="vigenciaFim7" size="10" maxlength="10"  value="<%=vdataVigenciaFinal7 %>" />
    </fieldset>
</div>
<div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAditivo();"  /> 
</div>
  <input type="hidden" name="ordem" id="ordem" value="<%=vordem%>"/>
  <input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao%>"/>
  <input type="hidden" name="idArea" id="idArea" value="<%=vidArea%>"/>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
