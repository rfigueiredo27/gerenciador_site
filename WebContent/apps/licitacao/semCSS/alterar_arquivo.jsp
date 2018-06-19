<%@include file="/includes/prepara_barra_progresso.jsp"%>
<script>
function atualizaTela()
{
	if (document.farquivo.origem.value == 'principal')
		listar();
	else
		carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.farquivo.idconteudo.value + "&nProcesso=" + document.farquivo.nProcesso.value + "&nPregao=" + document.farquivo.nPregao.value,"divbusca");
}
</script>
<%
String vidConteudo = request.getParameter("id");
String vdescricao = request.getParameter("tipo") + "-" + request.getParameter("nPregao") + "-" + request.getParameter("nProcesso") + "-" + request.getParameter("descricao");
String vidArquivo = request.getParameter("idArquivo");
String vorigem = request.getParameter("origem");
String vtitulo = request.getParameter("titulo");
String vnPregao = request.getParameter("nPregao");
String vnProcesso = request.getParameter("nProcesso");
%>

<h1>Troca de arquivo de <%=vtitulo %></h1>
<h2>N&uacute;mero do processo: <%= request.getParameter("nProcesso")%><br>
N&uacute;mero do preg&atilde;o: <%= request.getParameter("nPregao")%></h2> <br><br>
<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>           
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<div id="campoArquivo"><input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="arquivo" id="arquivo" /></div>
		<div id="progressBar" style="display: none;">
			<div id="theMeter">
            	<div id="progressBarText"></div>
                <div id="progressBarBox">
                	<div id="progressBarBoxContent"></div>
               	</div>
            </div>
         </div>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
        	<% 
        		if (vorigem.equals("principal"))
        		{
        	%>
					<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
			<%
        		}
				else
				{
			%>
					<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo%>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>','divbusca');" />
			<%
				}
			%>
           	<input type="button" name="save" value="Grava alterações" onclick="document.farquivo.submit();startProgress();" />
        </td>
      </tr>
  </table>
  <input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
  <input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso%>"/>           
  <input type="hidden" name="origem" id="origem" value="<%=vorigem%>"/>
</form>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
