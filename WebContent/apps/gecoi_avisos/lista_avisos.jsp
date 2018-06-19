<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>


<link rel="stylesheet" type="text/css"
	href="/gecoi.3.0/apps/gecoi_avisos/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/gecoi_avisos/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/gecoi_avisos/DataTable/js/tabela.js"></script>

<style>
	.divAcoes{
	display:flex;
	justify-content:space-around;	
}
</style>

<script>
	//$(document).ready(function(){
	//$( "#tabs" ).tabs();
	//	});

	function excluir(vidConteudo, vdescricao) {
		if (confirm("Deseja realmente excluir o aviso selecionado?") == true)
			$.post("/gecoi.3.0/apps/gecoi_avisos/processa_exclusao.jsp", {
				idConteudo : vidConteudo
			}, function() {
				top.listar();
			});
	}
</script>
<%
	String varea = request.getParameter("area");
	String vano = request.getParameter("ano");
	String vcor = "#ECECEC"; // zebra a tabela
%>

<c:set var="vidAno" value="<%=vano%>" scope="page" />
<c:set var="idArea" value="<%=varea%>" scope="page" />
<jsp:useBean id="lista"
	class="br.jus.trerj.controle.gecoiAvisos.ListaGecoiAviso" />
<c:set var="items"
	value="${lista.getListaAvisos(idArea, vidAno, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<br>
			<br>
			<br>
			<div class="dataTables_wrapper">
				<table id="gecoi2" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th scope="col">DATA</th>
							<th scope="col">HORA</th>
							<th scope="col">TITULO</th>
							<th scope="col">PUBLICADOR</th>
							<th scope="col">ALTERADO EM</th>
							<th scope="col">ALTERADOR</th>
							<th scope="col">AÇÕES</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="avisos" items="${items}">
							<!--///////////////zebra a tabela /////////-->
							<%
								if (vcor.equals(""))
												vcor = "#ECECEC";
											else
												vcor = "";
							%>
							<tr bgcolor=<%=vcor%>>
								<td align="center" width="5%">${avisos.dataPublicacao }</td>
								<td align="center" width="5%">${avisos.horaPublicacao }</td>
								<td align="center" width="45%">${avisos.descricao }</td>
								<td align="center" width="10%">${avisos.usuario }</td>
								<td align="center" width="10%">${avisos.dataAlteracao }</td>
								<td align="center" width="10%">${avisos.usuario_ateracao }</td>
								<td align="center" width="15%"><div class='divAcoes'><a
									href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${avisos.idConteudo }&idArquivo=${avisos.idArquivo }"
									target="_blank" title="Visualização do arquivo"><img
										id="arquivo${avisos.idConteudo }"
										name="arquivo${avisos.idConteudo }"
										src="/gecoi.3.0/img/consulta.png" onclick="" width="22"
										height="22" /></a> <a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/gecoi_avisos/alterar_dados.jsp?idConteudo=${avisos.idConteudo }&idArquivo=${avisos.idArquivo }&descricao=${avisos.descricao }','divbusca');"
									title="Alteração dos dados do aviso"><img
										id="dados${avisos.idConteudo }"
										name="dados${avisos.idConteudo }"
										src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22"
										height="22" /></a> <a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/gecoi_avisos/alterar_arquivo.jsp?id=${avisos.idConteudo }&idArquivo=${avisos.idArquivo }&descricao=${avisos.descricao }','divbusca');"
									title="Substitui&ccedil;&atilde;o do arquivo"><img
										id="arquivo${avisos.idConteudo }"
										name="arquivo${avisos.idConteudo }"
										src="/gecoi.3.0/img/reverter.png" onclick="" width="22"
										height="22" /></a> <a href="#"
									onclick="carregaPag('/gecoi.3.0/apps/gecoi_avisos/alterar_anexo.jsp?id=${avisos.idConteudo }','divbusca');"
									title="Manutenção dos Anexos"><img
										id="aditivo${avisos.idConteudo }"
										name="aditivo${avisos.idConteudo }"
										src="/gecoi.3.0/img/clips.png" onclick="" width="16"
										height="16" /></a> <a href="#" title="Exclusão do Aviso"><img
										id="excluir${avisos.idConteudo }"
										name="excluir${avisos.idConteudo }"
										src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"
										onclick="excluir('${avisos.idConteudo }');" /></a></div></td>
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
		<c:out value="Não tem registros" />
		<% out.print(varea + "/" + vano + "/" + vcor); %>
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
