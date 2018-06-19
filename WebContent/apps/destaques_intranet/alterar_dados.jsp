 
<%
response.setContentType("text/html;charset=iso-8859-1");
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vpublicado = request.getParameter("publicado");
String[] vobservacao = request.getParameter("link").split("@@");
String vlink = vobservacao[0];
String valvo = "_blank"; 
if (vobservacao.length > 1)
	valvo = vobservacao[1];
String vdataIni2 = request.getParameter("dataIni2");
String vdataFim2 = request.getParameter("dataFim2");
String vdescricaoAnexo = (request.getParameter("descricaoAnexo") == null) ? "" : request.getParameter("descricaoAnexo");
int vtemAnexo = (request.getParameter("temAnexo") == null) ? 0 : Integer.parseInt(request.getParameter("temAnexo"));
%>
<script>
$(document).ready(function(){
	$("#dataIni2").datepicker();
	$("#dataFim2").datepicker();
});

function alterar(f)
{
	
	// apago o link com espacos em branco porque na hora de gravar a procedure não faz alteracao no campo observacao (onde será gravado o link) quando esse é nulo
	if (f.link.value == "")
		f.link.value = "   ";
	if (f.descricao.value == "")
		alert("É necessário preencher o nome.");
	else
		$.post("/gecoi.3.0/apps/destaques_intranet/processa_alteracao.jsp", {idConteudo: f.idconteudo.value, idArquivo : f.idarquivo.value, descricao: f.descricao.value, publicadoAtual: f.publicadoAtual.value, publicadoNovo: f.publicadoNovo.value, link: f.link.value + "@@" + f.alvo.value, dataIni2: f.dataIni2.value, dataFim2: f.dataFim2.value}, function(){top.listar();});
}
</script>
<form name="fdestaque" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="publicadoAtual" id="publicadoAtual" value="<%=vpublicado%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Ordem de exibição na TV</td>
        <td>
			<input type="text" name="publicadoNovo" id="publicadoNovo" value="<%=vpublicado%>" maxlength="1"/>
        </td>
      </tr>
      <tr><td>Descri&ccedil;&atilde;o do banner</td>
        <td >
			<input type="text" name="descricao" id="descricao" value="<%=vdescricao%>"/>
        </td>
      </tr>
      <tr><td>Digite o endereço do link</td>
        <td>
			<input type="text" name="link" id="link" value="<%=vlink%>" onfocus="alert(document.fdestaque.ordem.value);document.fdestaque.link.value = document.fdestaque.link.value.trim();"/>
        </td>
      </tr>
      <tr><td>OU Escolha um arquivo</td>
        <td>
			<input type="text" name="descricaoAnexo" id="descricaoAnexo" value="<%=vdescricaoAnexo%>" />
			<input type="file" name="anexo" id="anexo" />
			<%
				if (vtemAnexo > 0)
				{
					out.print("<a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivo + "' target='_blank' title='Visualização do arquivo'><img id='imganexo' name='imganexo' src='/gecoi.3.0/img/consulta.png' onclick='' width='22' height='22' /></a>");
				}
			%>
        </td>
      </tr>
      <tr><td>Selecione o target</td>
        <td>
          <label for="alvo"></label>
          <select name="alvo" id="alvo">
          <%
          	if (valvo.equals("_blank"))
          	{
            	out.print("<option value='_blank' selected='selected'>blank</option>");
                out.print("<option value='_self'>self</option>");
          	}
          	else
          	{
            	out.print("<option value='_blank'>blank</option>");
                out.print("<option value='_self' selected='selected'>self</option>");
          	}
          %>
        </select></td>
      </tr>
      <tr><td>Data in&iacute;cio de exibi&ccedil;&atilde;o</td>
        <td >
			<input type="text" name="dataIni2" id="dataIni2" value="<%=vdataIni2%>"/>
        </td>
      </tr>
      <tr><td>Data fim de exibi&ccedil;&atilde;o</td>
        <td >
			<input type="text" name="dataFim2" id="dataFim2" value="<%=vdataFim2%>"/>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Grava alterações" onclick="alterar(this.form);" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
