<script>

function criticaAnexo()
{
	//if (document.fdescAnexo.descricaoAditivo.value == "")
	//	alert("É necessário preencher a descrição.");
	//else
		$.post("/gecoi.3.0/apps/licitacao/processa_alteracao_descricao_anexo.jsp", {idConteudo: document.fdescAnexo.idconteudo.value, idArquivo : document.fdescAnexo.idarquivo.value, descricao : document.fdescAnexo.descricao.value},
				function(){
					//$.post("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value, function(){document.fdescAnexo.submit()});
					//document.fdescAnexo.submit();
					carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fdescAnexo.idconteudo.value + "&nProcesso=" + document.fdescAnexo.nProcesso.value + "&nPregao=" + document.fdescAnexo.nPregao.value,"divbusca");
				});
}
</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");

%>
<h1>Altera&ccedil;&atilde;o dos dados do anexo</h1>
<form name="fdescAnexo" action="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Nº do Pregão:
        	<input type="text" name="nPregao" id="nPregao" value="<%=vnPregao %>" readonly="readonly" />
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
        	Descrição <input type="text" name="descricao" id="descricao" value="<%=vdescricao %>" />
        		
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo%>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
