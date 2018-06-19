<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.revistaJE.ListaRevistaJE" />
<c:set var="items"
	value="${lista.getListaRevistasJE(sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<h3 align="center">Lista de Revistas JE</h3>
			<br><br>
			<div class="dataTables_wrapper">
				<table id="revistas" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th scope="col">Data Publicação</th>
							<th scope="col">Volume</th>
							<th scope="col">Número</th>
							<th scope="col">Mês Inicial</th>
							<th scope="col">Ano Inicial</th>
							<th scope="col">Mês Final</th>
							<th scope="col">Ano Final</th>
							<th scope="col">Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="revistas" items="${items}">
							
							<tr>
								<td align="center" width="20%">${revistas.dataPublicacao }</td>
								<td align="center" width="10%">${revistas.volume }</td>
								<td align="center" width="10%">${revistas.numero }</td>
								<td align="center" width="10%">${revistas.mes_inicial }</td>
								<td align="center" width="10%">${revistas.ano_inicial }</td>
								<td align="center" width="10%">${revistas.mes_final }</td>
								<td align="center" width="10%">${revistas.ano_final }</td>
								<td align="center" width="20%"><div class='divAcoes'>
									<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${revistas.idConteudo }&idArquivo=${revistas.idArquivo }"	target="_blank" title="Visualização do arquivo">
										<img id="arquivo${revistas.idConteudo }" name="arquivo${revistas.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a> 
									<a href="#"	onclick="carregaPag('/gecoi.3.0/apps/revista_je/alterar_dados.jsp?idConteudo=${revistas.idConteudo }&idArquivo=${revistas.idArquivo }&descricao=${revistas.descricao_arquivo }&data=${revistas.dataPublicacao }&volume=${revistas.volume }&numero=${revistas.numero }&ano_inicial=${revistas.ano_inicial }&ano_final=${revistas.ano_final }&mes_inicial=${revistas.mes_inicial }&mes_final=${revistas.mes_final }&area=${revistas.idArea }','divbusca');"
									title="Alteração dos dados da Revista">
										<img id="dados${revistas.idConteudo }" name="dados${revistas.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a> 
									<a href="#" onclick="carregaPag('/gecoi.3.0/apps/revista_je/alterar_arquivo.jsp?id=${revistas.idConteudo }&idArquivo=${revistas.idArquivo }&descricao=${revistas.descricao_arquivo }','divbusca');"
									title="Substitui&ccedil;&atilde;o do arquivo">
										<img id="arquivo${revistas.idConteudo }" name="arquivo${revistas.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a>  
									<a href="#" title="Exclusão do Aviso"><img id="excluir${revistas.idConteudo }" name="excluir${revistas.idConteudo }" src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"
										onclick="excluir('${revistas.idConteudo }');" /></a>
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
			$("#revistas")
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
						            null,
						            null,
						            null
						            ]

					});
		});



</script>