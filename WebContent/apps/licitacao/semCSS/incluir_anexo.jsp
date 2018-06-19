   
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	//parent.tb_remove();
	parent.carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fincAnexo.idconteudo.value + "&nProcesso=" + document.fincAnexo.nProcesso.value + "&nPregao=" + document.fincAnexo.nPregao.value, "divbusca");
}



function criticaAnexo()
{	
	critica_inclusao_anexo(document.fincAnexo);
	//document.fincAnexo.submit();
	//startProgress();
	//parent.tb_remove();
	//carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fincAnexo.idconteudo.value + "&nProcesso=" + document.fincAnexo.nProcesso.value + "&nPregao=" + document.fincAnexo.nPregao.value,"divbusca");
}

</script>
<%
String vidConteudo = request.getParameter("idConteudo");
String vnPregao = request.getParameter("nPregao");
String vnProcesso = request.getParameter("nProcesso");
%>
<h1>Inclus&atilde;o de anexos</h1>
<form name="fincAnexo" action="/gecoi.3.0/IncluirAnexoGenerico" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="app" id="app" value="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo %>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Nº do Pregão:
        	<!-- não tem id para não ser usado no IncluirAnexoServlet -->
        	<input type="text" value="<%=vnPregao %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>
        	Nº do Processo:
        	<!-- não tem id para não ser usado no IncluirAnexoServlet -->
        	<input type="text" value="<%=vnProcesso %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>
        	Descrição <input type="text" name="descricao" id="descricao" value=""  />
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
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo%>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
        </td>
      </tr>
  </table>
  <!-- esses inputs são usados para atualizar a página anterior de listagem de anexos -->
  <input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao %>"  />
  <input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>" />
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
