<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.acessoRapido.ListaAcessoRapido" />
<c:set var="items"
	value="${lista.getListaAcessoRapido(sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<h3 align="center">Lista de Acesso Rápido</h3>
			<br><br>
			<div class="dataTables_wrapper">
				<table id="acesso" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th scope="col">Data Publicação</th>
							<th scope="col">Descricao</th>
							<th scope="col">Link</th>
							<th scope="col">Hint</th>
							<th scope="col">Target</th>
							<th scope="col">Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="acesso" items="${items}">
							
							<tr>
								<td align="center" width="10%">${acesso.dataPublicacao }</td>
								<td align="center" width="15%">${acesso.descricao }</td>
								<td align="center" width="30%">${acesso.link }</td>
								<td align="center" width="15%">${acesso.hint }</td>
								<td align="center" width="10%">${acesso.target }</td>
								<td align="center" width="20%"><div class='divAcoes'>
									<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${acesso.idConteudo }&idArquivo=${acesso.idArquivo }"	target="_blank" title="Visualização do arquivo">
										<img id="arquivo${acesso.idConteudo }" name="arquivo${acesso.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a> 
									<a href="#"	onclick="carregaPag('/gecoi.3.0/apps/acesso_rapido/alterar_dados.jsp?idConteudo=${acesso.idConteudo }&idArquivo=${acesso.idArquivo }&descricao=${acesso.descricao }&data=${acesso.dataPublicacao }&link=${acesso.link }&hint=${acesso.hint }&target=${acesso.target }&area=${acesso.idArea }','divbusca');"
									title="Alteração dos dados">
										<img id="dados${acesso.idConteudo }" name="dados${acesso.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a> 
									<a href="#" onclick="carregaPag('/gecoi.3.0/apps/acesso_rapido/alterar_arquivo.jsp?id=${acesso.idConteudo }&idArquivo=${acesso.idArquivo }&descricao=${acesso.descricao }','divbusca');"
									title="Substitui&ccedil;&atilde;o do arquivo">
										<img id="arquivo${acesso.idConteudo }" name="arquivo${acesso.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a>  
									<a href="#" title="Exclusão do Aviso"><img id="excluir${acesso.idConteudo }" name="excluir${acesso.idConteudo }" src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"
										onclick="excluir('${acesso.idConteudo }');" /></a>
									</div></td>				
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</c:when>
	<c:otherwise>
		<br>
		<br>
		<br>
		<div align="center"><h3><c:out value="Não tem registros" /></h3></div>
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
<script>
$.extend($.fn.dataTableExt.oSort, {
	"date-br-pre": function(a) {
		if (a == null || a == "") {
			return 0;
		}
		var brDatea = a.split('/');
		return (brDatea[2] + brDatea[1] + brDatea[0]) * 1;
	},

	"date-br-asc": function(a, b) {
		return ((a < b) ? -1 : ((a > b) ? 1 : 0));
	},

	"date-br-desc": function(a, b) {
		return ((a < b) ? 1 : ((a > b) ? -1 : 0));
	}
	
});

$(document)
.ready(
		function tabela_dinamica () {
			$("#acesso")
			.DataTable(
					{
						"oLanguage": {
							"sEmptyTable": "Nenhum registro encontrado",
						    "sInfo": "Mostrando de _START_ at\u00e9 _END_ de _TOTAL_ registros",
						    "sInfoEmpty": "Mostrando 0 at\u00e9 0 de 0 registros",
						    "sInfoFiltered": "(Filtrados de _MAX_ registros)",
						    "sInfoPostFix": "",
						    "sInfoThousands": ".",
						    "sLengthMenu": "Exibir _MENU_ Resultados por p\u00e1gina",
						    "sLoadingRecords": "Carregando...",
						    "sProcessing": "Processando...",
						    "sZeroRecords": "Nenhum registro encontrado",
						    "sSearch": "Filtro",
						    "oPaginate": {
						        "sNext": "Pr\u00f3ximo",
						        "sPrevious": "Anterior",
						        "sFirst": "Primeiro",
						        "sLast": "\u00daltimo"
							}
						},

						"order": [[ 0, "desc" ]],

						"columns": [
						            { "type": "date-br" },
						            null,
						            null,
						            null,
						            null,
						            null
						            ]

					});
		});



</script>