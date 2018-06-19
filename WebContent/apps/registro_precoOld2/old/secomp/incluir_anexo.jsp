<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>

function atualizaTela(pnumAta)
{
	//parent.tb_remove();
	if (pnumAta != '0')
		alert("Foi gravada a ata de número " + pnumAta);
	carregaPag("/gecoi.3.0/apps/registro_preco/secomp/alterar_anexo.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + "&nPregao=" + document.fincAnexo.numPregao.value, "divbusca");
}


function criticaAnexo()
{
	critica_inclusao_registro(document.fincAnexo);
	//document.fincAnexo.submit();
	//startProgress();
	//parent.tb_remove();
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
<h1>Inclus&atilde;o de Atas de Registro de Pre&ccedil;os</h1>
<form name="fincAnexo" action="/gecoi.3.0/IncluirRegistroPrecoSecomp" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="app" id="app" value="/gecoi.3.0/apps/registro_preco/secomp/alterar_anexo.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso %>"/>
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidLicitacao%>"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	  	<td>
	  		Número do Processo: <input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
	  	</td>
	  </tr>
	  <tr>
	  	<td>
	  		Número do Pregão: <input type="text" name="numPregao" id="numPregao" value="<%=vnumPregao %>" readonly="readonly" />
	  	</td>
	  </tr>
	  <tr>
	  	<td>
	  		Data de Publicação <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" />
	  	</td>
	  </tr>
	  <tr>
	  	<td>
	  		Vigência <input title="Data de vigência inicial" alt="Data de vigência inicial" type="text" name="dataVigenciaInicial" id="dataVigenciaInicial" size="10" maxlength="10" /> a <input title="Data de vigência final" alt="Data de vigência final" type="text" name="dataVigenciaFinal" id="dataVigenciaFinal" size="10" maxlength="10" />
	  	</td>
	  </tr>
      <tr>
        <td>
        	Descrição<br>
        	(Informar a descrição da ata apenas, o número da ata será gerado quando na gravação da mesma)<br>
   			<textarea title="Descri&ccedil;&atilde;o da ata" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></textarea>
   			<span id="contadorDescricao" class="alert"></span>
        	
        </td>
      </tr>
      <tr>
        <td>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela('0');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
