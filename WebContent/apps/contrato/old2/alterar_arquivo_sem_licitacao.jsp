<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	if (document.farquivo.origem.value == 'principal')
		carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + document.fbusca2.tipo.value, "divbusca2");
	else
		carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=" + document.farquivo.descricao.value + "&idConteudo=" + document.farquivo.idConteudo.value + "&nProcesso=" + document.farquivo.nProcesso.value + "&nContrato=" + document.farquivo.nContrato.value + "&dataPublicacao=" + document.farquivo.dataPublicacao.value + "&idArea=" + document.farquivo.idArea.value, "divbusca2");
}
</script>

<%
String vidConteudo = request.getParameter("id");
//String vdescricao = request.getParameter("nProcesso") + "-" + request.getParameter("nContrato") + "-" + request.getParameter("descricao");
String vdescricao = request.getParameter("descricao");
String vidArquivo = request.getParameter("idArquivo");
String vnContrato = request.getParameter("nContrato");
String vtitulo = request.getParameter("titulo");
String vorigem = request.getParameter("origem");
String vnProcesso = request.getParameter("nProcesso");
String vdataPublicacao = request.getParameter("dataPublicacao");
String vidArea = request.getParameter("idArea");

%>
<div id="trocatela">
<h1>Troca de arquivo de <%=vtitulo %></h1>
<h2>N&uacute;mero do processo: <%= request.getParameter("nProcesso")%><br>
N&uacute;mero do contrato: <%= request.getParameter("nContrato")%><br>
Descri&ccedil;&atilde;o do contrato: <%= request.getParameter("descricao")%><br>
</h2> <br><br>
<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
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
          	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
			<input type="button" name="save" value="Grava alterações" onclick="document.farquivo.submit();startProgress();" />
        </td>
      </tr>
  </table>
<input type="hidden" name="origem" id="origem" value="<%=vorigem%>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso%>"/>
<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato%>"/>
<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao%>"/>
<input type="hidden" name="idArea" id="idArea" value="<%=vidArea%>"/>
</form>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
</div>