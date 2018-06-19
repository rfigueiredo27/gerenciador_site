<script>
$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
});

function criticaAnexo(pLicitacao, pnPregao, pnProcesso, pedital)
{
	if (critica_altera_registro(document.fdescAnexo))
	{
		$.post("/gecoi.3.0/apps/estudos_preliminares/processa_alteracao_dados_estudo.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, 
																					idArquivo : document.fdescAnexo.idarquivo.value, 
																					descricao : document.fdescAnexo.descricao.value,
																					dataPublicacao : document.fdescAnexo.dataPublicacao.value,
																					idArea : document.fdescAnexo.idarea.value
																					},
				function(){
					carregaPag("/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=" + pLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso + "&edital=" + pedital,"divbusca");
				});
	}
}

function poeZero()
{
	var numero = parseInt(document.fdescAnexo.num_ata.value);
	//document.fdescAnexo.num_ata.value = String.format("%03d", numero);
	if (numero < 10)
	{
		document.fdescAnexo.num_ata.value = "00" + numero;
	}
	else
	{
		if (numero < 100)
		{
			document.fdescAnexo.num_ata.value = "0" + numero;
		}
	}
}

</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vedital = request.getParameter("edital");
String vdescricao = request.getParameter("descricao");
//String vfornecedor = request.getParameter("fornecedor");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
String vdataPublicacao = request.getParameter("dataPublicacao");
//String vdataVigenciaInicial2 = request.getParameter("dataVigenciaInicial");
//String vdataVigenciaFinal2 = request.getParameter("dataVigenciaFinal");
String vidArea = request.getParameter("idArea");
//String vdescricaoNumAta = request.getParameter("numAta");
//String[] adescricao = vdescricaoNumAta.split("/");
//String vano = adescricao[adescricao.length - 1];
//String[] anumAta = adescricao[0].split(" ");
//String vnumAta = anumAta[anumAta.length - 1];

%>

<div id="altera_ata">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Estudo Preliminar</legend>
<div id="numero">
 <div id="descricao_arquivo">
        <p>Edital: <strong><%= vedital%></strong></p>
	</div>
    <div id="numero_processo">
        <p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>
<form name="fdescAnexo" action="/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=<%=vidLicitacao %>&nPregao=<%=vnPregao %>&nProcesso=<%=vnProcesso %>" method="post"> 
<input type="hidden" name="idlicitacao" id="idlicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=vidArea%>"/>

      
      <div id="data_anexo">
    		<fieldset>
                <legend>Data de Publicação</legend>
	  		 	<input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" value="<%=vdataPublicacao %>" />
	  		</fieldset>
	  </div>
      
	  	<div id="descricao_anexo">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o do Estudo Preliminar</legend>
	  			
        		<input type="text" title="Descri&ccedil;&atilde;o da ata" name="descricao" id="descricao" cols="45" rows="5" value="<%=vdescricao %>" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></input>
   				<span id="contadorDescricao" class="alert"></span>
           </fieldset>
	  </div>
      
      <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>&edital=<%=vedital %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(<%=vidLicitacao%>, '<%=vnPregao%>', '<%=vnProcesso%>', '<%=vedital %>');"  /> 
     </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
