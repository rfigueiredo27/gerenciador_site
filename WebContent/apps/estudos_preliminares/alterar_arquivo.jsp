<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>
function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=" + document.farquivo.idLicitacao.value + "&nPregao=" + document.farquivo.nPregao.value + "&nProcesso=" + document.farquivo.nProcesso.value + "&edital=" + document.farquivo.edital.value, "divbusca");
}
</script>

<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
String vidConteudo = request.getParameter("id");
//String vdescricao = "Preg�o Eletr�nico por Registro de Pre�o " + request.getParameter("nProcesso") + " - " + request.getParameter("descricao");
String vdescricao = request.getParameter("descricao");
String vedital = request.getParameter("edital");
String vidArquivo = request.getParameter("idArquivo");
String vorigem = request.getParameter("origem");
String vpagina = "/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=" + vidLicitacao + "&nPregao=" + vnPregao + "&nProcesso=" + vnProcesso;
%>
<div id="altera_arquivo">
<fieldset>
	<legend>Troca de arquivo do estudo preliminar</legend>
<div id="numero">
	<div id="descricao_arquivo">
        <p>Descri��o: <strong><%=vdescricao%></strong></p>
	</div>
    <div id="numero_processo">
        <p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
	</div>
</div>

<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
      	<div id="campoArquivo"><input title="Arquivo a ser substitu�do" alt="Arquivo a ser substitu�do" type="file" name="anexo" id="anexo" /></div>
		<div id="progressBar" style="display: none;">
			<div id="theMeter">
            	<div id="progressBarText"></div>
                <div id="progressBarBox">
                	<div id="progressBarBoxContent"></div>
               	</div>
            </div>
         </div>
         <div id="botao">
      
			<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnPregao%>&nProcesso=<%=vnProcesso%>&edital=<%=vedital%>','divbusca');" />
           	<input type="button" name="save" value="Grava altera��es" onclick="critica_altera_substituicao_arquivo(document.farquivo);" />
        </div>
        
<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao%>"/>
<input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso%>"/>
<input type="hidden" name="edital" id="edital" value="<%=vedital%>"/>
</form>
</fieldset>
</div>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>
