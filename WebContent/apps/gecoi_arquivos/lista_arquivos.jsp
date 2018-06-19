<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>


<link rel="stylesheet" type="text/css" href="/gecoi.3.0/apps/gecoi_arquivos/DataTable/css/dataTables.bootstrap4.css">
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_arquivos/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_arquivos/DataTable/js/dataTables.bootstrap4.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_arquivos/DataTable/js/tabela.js"></script>


<style>
.divAcoes {
	display: flex;
	justify-content: space-around;
}

th
{
	font-size: 10pt;
	text-align: center;
}
td
{
	font-size: 9pt;
	text-align: center;
}
</style>


<script>
	function excluir(id_conteudo, vdescricao) {
		if (confirm("Deseja realmente excluir o Arquivo selecionado?") == true)
			$.post("/gecoi.3.0/apps/gecoi_arquivos/processa_exclusao.jsp", {
				idConteudo : id_conteudo
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
	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
<c:set var="items"
	value="${lista.getListaArquivos(idArea, vidAno, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<br> <br>
			<div align="left">
				<table id="gecoi2"  class="table table-striped table-bordered" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th align="center">ID Arquivo</th>
							<th align="center">Título</th>
							<th align="center">Publicação</th>
							<th align="center">Última Alteração</th>
							<th align="center">Usuário</th>
							<th align="center">Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="arquivos" items="${items}">
							<tr bgcolor=<%=vcor%>>
								<td align="center" width="5%">${arquivos.idArquivo }</td>
								<td align="center" width="40%">${arquivos.descricao_conteudo }</td>
								<td align="center" width="5%">${arquivos.dataPublicacao }</td>
								<td align="center" width="10%">${arquivos.dataAlteracao }</td>
								<td align="center" width="10%">${arquivos.usuario_ateracao }</td>
								<td align="center" width="30%">
								<div class='divAcoes'>
										<a
											href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${arquivos.idConteudo }&idArquivo=${arquivos.idArquivo }"
											target="_blank" title="Visualização do arquivo"><img
											id="arquivo${arquivos.idConteudo }"
											name="arquivo${arquivos.idConteudo }"
											src="/gecoi.3.0/img/consulta.png" onclick="" width="22"
											height="22" /></a> <a href="#"
											onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_arquivo.jsp?id=${arquivos.idConteudo }&idArquivo=${arquivos.idArquivo }&descricao=${arquivos.descricao }','divbusca');"
											title="Substitui&ccedil;&atilde;o do arquivo"><img
											id="arquivo${arquivos.idConteudo }"
											name="arquivo${arquivos.idConteudo }"
											src="/gecoi.3.0/img/reverter.png" onclick="" width="22"
											height="22" /></a> <a href="#"
											onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_dados.jsp?idConteudo=${arquivos.idConteudo }&descricao_area=${arquivos.descricao_area }&idArquivo=${arquivos.idArquivo }&observacao=${arquivos.observacao }&descricao_conteudo=${arquivos.descricao_conteudo }&descricao=${arquivos.descricao }&dataPublicacao=${arquivos.dataPublicacao }&area=<%=varea%>','divbusca');"
											title="Alteração dos dados do Arquivo"><img
											id="dados${arquivos.idConteudo }"
											name="dados${arquivos.idConteudo }"
											src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22"
											height="22" /></a>
											
<!-- 										------------	Verifica se o arquivo é HTML ou TXT ------------>
											<c:choose>
											<c:when test="${fn:containsIgnoreCase(arquivos.arquivo_nome, 'txt') or fn:containsIgnoreCase(arquivos.arquivo_nome, 'htm')}">
											<a href="#"
											onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/edicao_arquivo.jsp?idConteudo=${arquivos.idConteudo }&idArquivo=${arquivos.idArquivo }&descricao=${arquivos.descricao }','divbusca');"
											title="Editar arquivo TXT/HTML"><img
											id="dados${arquivos.idConteudo }"
											name="dados${arquivos.idConteudo }"
											alt="Editar arquivo TXT/HTML"
											src="/gecoi.3.0/img/texto.jpg" onclick="" width="22"
											height="22" /></a>
											
											</c:when>
											<c:otherwise>
											
											<a href="#"
											onclick="javascript:alert('Esse arquivo não é do tipo HTML/TXT, portanto não pode ser editado pelo GECOI.')"
											title="Editar arquivo TXT/HTML"><img
											id="dados${arquivos.idConteudo }"
											name="dados${arquivos.idConteudo }"
											alt="Editar arquivo TXT/HTML"
											src="/gecoi.3.0/img/texto.jpg" onclick="" width="22"
											height="22" /></a>
											
											</c:otherwise>
											</c:choose>
											
											  <a href="#" title="Exclusão do Arquivo"><img
											id="excluir${arquivos.idConteudo }"
											name="excluir${arquivos.idConteudo }"
											src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"
											onclick="excluir('${arquivos.idConteudo }');" /></a> 
											
											<a href="#"
											onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=${arquivos.idConteudo }','divbusca');"
											title="Manutenção dos Anexos"><img
											id="aditivo${arquivos.idConteudo }"
											name="aditivo${arquivos.idConteudo }"
											src="/gecoi.3.0/img/clips.png" onclick="" width="16"
											height="16" /></a>
											
											<a href="#"
											onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/manutencao_referencia.jsp?idprincipal=${arquivos.idArquivo }&descricao=${arquivos.descricao }','divbusca');"
											title="Manutenção de Referências"><img
											id="dados${arquivos.idConteudo }"
											name="dados${arquivos.idConteudo }"
											src="/gecoi.3.0/img/consulta_img.png" onclick="" width="22"
											height="22" /></a>
											
											<a
											href='/gecoi.3.0/apps/gecoi_arquivos/download_arquivo.jsp?iddownload=0&idArquivo=${arquivos.idArquivo}'
											title='Download do arquivo'> <img alt="download arquivo"
											src="/gecoi.3.0/img/icones/download.png" /></a>
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
		<c:out value="Não tem registros" />
		
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
