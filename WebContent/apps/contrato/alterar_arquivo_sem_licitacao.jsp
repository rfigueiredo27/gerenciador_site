<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	if (document.farquivo.origem.value == 'principal')
	{
		if (document.fbusca2.tipo[0].checked)
			ptipo = "todos";
		if (document.fbusca2.tipo[1].checked)
			ptipo = "adesao";
		if (document.fbusca2.tipo[2].checked)
			ptipo = "direta";
		carregaPag("/gecoi.3.0/apps/contrato/lista_contrato_sem_licitacao.jsp?ano=" + document.fbusca2.ano.value + "&texto=" + document.fbusca2.texto.value + "&tipo=" + ptipo, "divbusca2");
	}
	else
	{
		alert("c");
		carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=" + document.farquivo.descricao.value + "&idConteudo=" + document.farquivo.idConteudo.value + "&nProcesso=" + document.farquivo.nProcesso.value + "&nContrato=" + document.farquivo.nContrato.value + "&dataPublicacao=" + document.farquivo.dataPublicacao.value + "&idArea=" + document.farquivo.idArea.value, "divbusca2");
		alert("d");
	}
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

<div id="altera_arquivo_sem_licitacao">
<fieldset>
	<legend>Altera&ccedil;&atilde;o do arquivo de <%=vtitulo %></legend>
    
    <div id="numero">
		<div id="descricao_arquivo">
        	<p>Descri&ccedil;&aring;o: <strong><%= vdescricao%></strong></p>
		</div>
    	<div id="numero_processo_anexo">
        	<p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
		</div>
    	<div id="numero_pregao_anexo">
        	<p>N&uacute;mero do Contrato: <br /><strong><%=vnContrato%></strong></p>
		</div>
	</div>
<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vnContrato%>-<%=vnProcesso%>-<%=vdescricao%>"/>           

      	<div id="campoArquivo2"><input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="anexo" id="anexo" /></div>
		<div id="progressBar2" style="display: none;">
			<div id="theMeter2">
            	<div id="progressBarText2"></div>
                <div id="progressBarBox2">
                	<div id="progressBarBoxContent2"></div>
               	</div>
            </div>
         </div>
       <div id="botao">
          	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
			<input type="button" name="save" value="Grava alterações" onclick="critica_altera_substituicao_arquivo(document.farquivo);" />
        </div>

<input type="hidden" name="origem" id="origem" value="<%=vorigem%>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso%>"/>
<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato%>"/>
<input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao%>"/>
<input type="hidden" name="idArea" id="idArea" value="<%=vidArea%>"/>
</form>
</fieldset>
</div>
<div id="mensagem_caixa"></div>

</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 