<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + document.farquivo.idLicitacao.value + "&nPregao=" + document.farquivo.nPregao.value + "&nProcesso=" + document.farquivo.nProcesso.value, "divbusca");
}
</script>

<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
String vidConteudo = request.getParameter("id");
//String vdescricao = "Pregão Eletrônico por Registro de Preço " + request.getParameter("nProcesso") + " - " + request.getParameter("descricao");
String vdescricao = request.getParameter("descricao");
String vidArquivo = request.getParameter("idArquivo");
String vorigem = request.getParameter("origem");
String vpagina = "/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + vidLicitacao + "&nPregao=" + vnPregao + "&nProcesso=" + vnProcesso;
%>
<div id="altera_ata">
<fieldset>
	<legend>Troca de arquivo de ata de registro de pre&ccedil;os</legend>
<div id="numero">
	<div id="descricao">
        <p>Descri&ccedil;&aring;o: <strong><%= vdescricao%></strong></p>
	</div>
    <div id="numero_processo">
        <p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>

<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
      	<div id="campoArquivo"><input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="arquivo" id="arquivo" /></div>
		<div id="progressBar" style="display: none;">
			<div id="theMeter">
            	<div id="progressBarText"></div>
                <div id="progressBarBox">
                	<div id="progressBarBoxContent"></div>
               	</div>
            </div>
         </div>
         <div id="botao">
      
			<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>','divbusca');" />
           	<input type="button" name="save" value="Grava alterações" onclick="document.farquivo.submit();startProgress();" />
        </div>
        
<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso%>"/>           
</form>
</fieldset>
</div>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>
