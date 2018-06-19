<%@include file="/includes/prepara_barra_progresso.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script src="/gecoi.3.0/apps/documentos_eliminacao/scripts/criticas.js" charset="UTF-8"></script>
<script>
function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/legislacao/lista_legislacao.jsp?ano=" + document.farquivo.anoBusca.value + "&legislacao=" + document.farquivo.legislacaoBusca.value,"resultado");
}
</script>

<%
String vidConteudo = request.getParameter("id");
String vdescricao = request.getParameter("descricao");
String vidArquivo = request.getParameter("idArquivo");
String vanoBusca = request.getParameter("anoBusca");
String vLegislacaoBusca = request.getParameter("legislacaoBusca");
%>
<div id="altera_arquivo">
<fieldset>
	<legend>Troca de arquivo de legisla&ccedil;&atilde;o</legend>
<div id="legislacao">
        <p>Legisla&ccedil;&atilde;o: <strong><%= vdescricao%></strong></p>
</div>

<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
      	<div id="campoArquivo"><input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="anexo" id="anexo" /></div>
		<div id="progressBar2" style="display: none;">
			<div id="theMeter2">
            	<div id="progressBarText2"></div>
                <div id="progressBarBox2">
                	<div id="progressBarBoxContent2"></div>
               	</div>
            </div>
         </div>
         <div id="botao">
      
			<input type="hidden" name="anoBusca" id="anoBusca" value="<%=vanoBusca%>"/>
			<input type="hidden" name="legislacaoBusca" id="legislacaoBusca" value="<%=vLegislacaoBusca%>"/>
			<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
           	<input type="button" name="save" value="Grava alterações" onclick="critica_altera_substituicao_arquivo(document.farquivo);" />
        </div>
        
</form>
</fieldset>
</div>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>
