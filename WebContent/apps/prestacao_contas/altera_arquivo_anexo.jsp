<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%
	String vidConteudo = request.getParameter("idConteudo");
	String vDescriao = request.getParameter("descricao");
	String vidArquivo = request.getParameter("idArquivo");
	String vorigem = request.getParameter("origem");
	String vano  = request.getParameter("ano");
	String vedital  = request.getParameter("edital");
%>
<script>
function critica_substituicao_anexo(f)
{
	var msg = "";
	
	if (f.anexo.value.replace(/^\s*|\s*$/g,"")=="")
	{
		msg = msg + "- O ARQUIVO n\u00e3o foi selecionado.\n";
	}
	if (msg.replace(/^\s*|\s*$/g,"")=="")
	{  
		f.submit();
	}
	else
	{
		alert("Ocorreram os seguintes erros:\n\n" + msg);
		return false;
	}

}
	
	
function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=<%=vidConteudo %>&ano=<%=vano %>&edital=<%=vedital %>", "resultado");
}
</script>

<div id="altera_dados_anexo">
	<fieldset>
		<legend>Troca de arquivo</legend>
			<div id="descricao_anexo" style="min-height: 200px;">
				<p align="left" style="font-size: 13px;">
					Descrição: <strong><%=vDescriao%></strong>
				</p>
				<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo" method="post" target="rodape" enctype="multipart/form-data">
					<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>" /> 
					<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>" /> 
					<input type="hidden" name="descricao" id="descricao" value="<%=vDescriao%>" />
					<input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="anexo" id="anexo" />
					
				</form>
				<div id="botao">
		
				<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=<%=vidConteudo%>&ano=<%=vano %>&edital=<%=vedital %>','resultado');" />
				<input type="button" name="save" value="Grava alterações" onclick="critica_substituicao_anexo(document.farquivo);" />
			</div>

		</div>
	</fieldset>
</div>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
