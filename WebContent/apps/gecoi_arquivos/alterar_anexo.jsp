<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script>
function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fanexo.idConteudo.value , "divbusca");
}


function excluirAnexo(vidArquivo, vidConteudo)
{
	if (confirm("Deseja realmente excluir o anexo ?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + vidConteudo ,"divbusca");});

}
</script>
<%
	String vidConteudo = request.getParameter("id");
	String vcor = "#ECECEC"; // zebra a tabela
%>

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
<c:set var="idConteudo" value="<%=vidConteudo%>" scope="page" />
<c:set var="items"
	value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<div id="altera_anexo">
	<fieldset>
		<legend>Lista de Anexos</legend>

		<div id="anexo_tabela">
			<form name="fanexo">
				<input type="hidden" name="idConteudo" id="idConteudo"
					value="<%=vidConteudo%>" />
				<table id="tb_gecoi">
					<tr>
						<th scope="col" width="60%">DESCRI&Ccedil;&Atilde;O</th>
						<th scope="col" colspan="8" width="20%">A&Ccedil;&Atilde;O</th>
					</tr>
					</thead>
					<tbody>
						<c:forEach var="anexo" items="${items}">
							<!--///////////////zebra a tabela /////////-->
							<%
								if (vcor.equals(""))
										vcor = "#ECECEC";
									else
										vcor = "";
							%>

							<tr bgcolor=<%=vcor%>>
								<td align="left">${anexo.descricao }</td>
								<td width="2%"><a
									href="/gecoi.3.0/apps/global/grava_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }"
									target="_blank" title="Visualização do arquivo"><img
										id="arquivo${anexo.idConteudo }"
										name="arquivo${anexo.idConteudo }"
										src="/gecoi.3.0/img/consulta.png" onclick="" width="22"
										height="22" target="_blank" /></a></td>
										
										
								<td width="2%"><a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/altera_arquivo_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }','divbusca');"
									title="Substitui&ccedil;&atilde;o do Arquivo Anexo"><img
										id="arquivo${anexo.idConteudo }"
										name="arquivo${anexo.idConteudo }"
										src="/gecoi.3.0/img/reverter.png" onclick="" width="22"
										height="22" /></a></td>
								
								
								<td width="2%"><a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_descricao_anexo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&descricao=${anexo.descricao }','divbusca');"
									title="Alterar dados do anexo"><img
										src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22"
										height="22" /></a></td>
								<td width="2%"><a href="#"
									onclick="excluirAnexo(${anexo.idArquivo },${anexo.idConteudo });"><img
										src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div id="anexo">
					<a href="#"	onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/incluir_anexo.jsp?idConteudo=${idConteudo}','divbusca');">(+) Incluir Anexo</a>
				</div>
			</form>
		</div>
		<div id="botao">
			<br><br><br><br>
			<input type="button" name="cancelar" value="Cancelar"
				onclick="listar();" />
		</div>
	</fieldset>
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
