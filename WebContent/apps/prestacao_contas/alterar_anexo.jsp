<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String vidConteudo = request.getParameter("idConteudo");
	String vano = request.getParameter("ano");
	String vcor = "#ECECEC"; // zebra a tabela
	String vedital = request.getParameter("edital");
%>
<script>
function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=" + document.fanexo.idConteudo.value , "resultado");
}



function excluirAnexo(vidArquivo, vidConteudo, edital)
{
	if (confirm("Deseja realmente excluir o arquivo selecionado?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=" + vidConteudo+ "&edital=<%=vedital%>" ,"resultado");});

}
</script>

<jsp:useBean id="lista"
	class="br.jus.trerj.funcoes.ListaAnexosPadrao" />
<c:set var="idConteudo" value="<%=vidConteudo%>" scope="page" />
<c:set var="items"
	value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<div id="altera_anexo" >
	<fieldset>
		<legend>Lista de Arquivos PDF</legend>
		<p align="left" class="destaque_edital">Edital: ${param.edital}</p>
		<div id="anexo_tabela">
			<form name="fanexo">
				<input type="hidden" name="idConteudo" id="idConteudo"
					value="<%=vidConteudo%>" />
					<br><br>
				<table class="table table-bordered table-inverse table-hover" style="width: 90%;" align="center">
					<thead>
						<tr>
						<th scope="col">Descrição do arquivo</th>
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
									onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/altera_arquivo_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }&ano=${param.ano }&edital=${param.edital }','resultado');"
									title="Substitui&ccedil;&atilde;o do Arquivo"><img
										id="arquivo${anexo.idConteudo }"
										name="arquivo${anexo.idConteudo }"
										src="/gecoi.3.0/img/reverter.png" onclick="" width="22"
										height="22" /></a>
								
								<a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/alterar_descricao_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }&ano=${param.ano }&edital=${param.edital }','resultado');"
									title="Alterar tipo de Arquivo"><img
										src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22"
										height="22" /></a>
								
								<a href="#"
									onclick="excluirAnexo(${anexo.idArquivo },${anexo.idConteudo }, <%=vedital %>);"><img
										src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div id="anexo">
					<a href="#"	onclick="carregaPag('/gecoi.3.0/apps/prestacao_contas/incluir_anexo.jsp?idConteudo=${param.idConteudo}&ano=${param.ano }&edital=${param.edital }','resultado');">(+) Incluir Arquivo PDF</a>
		</div>
		<div id="botao" align="center">
			<input type="button" name="cancelar" value="Voltar"	onclick="listar2(<%=vano %>);" />
		</div>
	</fieldset>
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
