<%@include file="/includes/prepara_barra_progresso.jsp"%>
<script>
	function atualizaTela() {
		listar();
	}
</script>
<%
	String vidConteudo = request.getParameter("idConteudo");
	String vDescriao = request.getParameter("descricao");
	String vidArquivo = request.getParameter("idArquivo");
	String vorigem = request.getParameter("origem");
%>
<div id="altera_arquivo">
	<fieldset>
		<legend>Troca de arquivo</legend>
		<div id="numero">
			<div id="descricao_arquivo">
				<p>
					Descrição: <strong><%=vDescriao%></strong>
				</p>
			</div>
		</div>

		<form name="farquivo" action="/gecoi.3.0/SubstituiArquivo"
			method="post" target="rodape" enctype="multipart/form-data">
			<input type="hidden" name="idconteudo" id="idconteudo"
				value="<%=vidConteudo%>" /> <input type="hidden" name="idarquivo"
				id="idarquivo" value="<%=vidArquivo%>" /> <input type="hidden"
				name="descricao" id="descricao" value="<%=vDescriao%>" />

			<div id="campoArquivo">
				<input title="Arquivo a ser substituído"
					alt="Arquivo a ser substituído" type="file" name="anexo" id="anexo" />
			</div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
					<div id="progressBarText"></div>
					<div id="progressBarBox">
						<div id="progressBarBoxContent"></div>
					</div>
				</div>
			</div>
			<div id="botao">
				<br>
				<br>
				<br> 
				<input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=<%=vidConteudo%>','divbusca');" />
				<input type="button" name="save" value="Grava alterações" onclick="critica_altera_substituicao_arquivo(document.farquivo);" />
			</div>


			<input type="hidden" name="origem" id="origem" value="<%=vorigem%>" />
		</form>
	</fieldset>
</div>
<div id="mensagem_caixa"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
