<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script>
function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/documentos_eliminacao/alterar_anexo.jsp?id=" + document.fanexo.idConteudo.value , "divbusca");
}


function excluirAnexo(vidArquivo, vidConteudo)
{
	if (confirm("Deseja realmente excluir o arquivo selecionado?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/documentos_eliminacao/alterar_anexo.jsp?id=" + vidConteudo ,"divbusca");});

}
</script>
<%
	String vidConteudo = request.getParameter("id");
	String vcor = "#ECECEC"; // zebra a tabela
%>

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.documentoEliminacao.ListaDocumentosEliminacao" />
<c:set var="idConteudo" value="<%=vidConteudo%>" scope="page" />
<c:set var="items"
	value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<div id="altera_anexo" >
	<fieldset style="width: 100%;">
		<legend>Lista de Documentos para Eliminação</legend>

		<div id="anexo_tabela">
			<form name="fanexo">
				<input type="hidden" name="idConteudo" id="idConteudo"
					value="<%=vidConteudo%>" />
					<br><br>
				<table class="table table-bordered table-inverse table-hover" style="width: 90%;" align="center">
					<thead>
						<tr>
						<th scope="col">Descrição do arquivo da Lista inserido no GECOI</th>
						<th scope="col">A&Ccedil;&Atilde;O</th>
						<tr>
					</thead>
					<tbody>
						<c:forEach var="anexo" items="${items}">
							<tr>
								<td align="left">${anexo.descricao }</td>
								<td width="20%">
								<a href="/gecoi.3.0/apps/global/grava_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }"
									target="_blank" title="Visualização do arquivo"><img
										id="arquivo${anexo.idConteudo }"
										name="arquivo${anexo.idConteudo }"
										src="/gecoi.3.0/img/consulta.png" onclick="" width="22"
										height="22" target="_blank" /></a>
								<a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/documentos_eliminacao/altera_arquivo_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }','divbusca');"
									title="Substitui&ccedil;&atilde;o do Arquivo"><img
										id="arquivo${anexo.idConteudo }"
										name="arquivo${anexo.idConteudo }"
										src="/gecoi.3.0/img/reverter.png" onclick="" width="22"
										height="22" /></a>
								<a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/documentos_eliminacao/alterar_descricao_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }','divbusca');"
									title="Alterar dados do arquivo"><img
										src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22"
										height="22" /></a>
								<a href="#"
									onclick="excluirAnexo(${anexo.idArquivo },${anexo.idConteudo });"><img
										src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<br><br><br><br>
		<div id="botao">
			<br><br><br><br>
			<input type="button" name="cancelar" value="Voltar"
				onclick="listar();" />
		</div>
	</fieldset>
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
