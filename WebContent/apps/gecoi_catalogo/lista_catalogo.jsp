<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>


<link rel="stylesheet" type="text/css" href="/gecoi.3.0/apps/gecoi_catalogo/DataTable/css/dataTables.bootstrap4.css">
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_catalogo/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_catalogo/DataTable/js/dataTables.bootstrap4.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_catalogo/DataTable/js/tabela.js"></script>


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

<script language="javascript">
function valida_exclusao(idarquivo, idconteudo, idcatalogo, descricao)
{
	if (confirm("Deseja realmente excluir o Catálogo: " + descricao+"?") == true)
		$.post("/gecoi.3.0/apps/gecoi_catalogo/processa_exclusao_conteudo.jsp", {
			id_arquivo : idarquivo,
			id_conteudo : idconteudo,
			id_catalogo : idcatalogo
		}, function() {
			top.listar();
		});
	
}

</script>
<%
	String vcatalogo  = request.getParameter("catalogo");
	String vano   = (request.getParameter("ano") == null) ? "-1" : request.getParameter("ano").toString();
	int vordem = (request.getParameter("ordem") == null) ? 1 : Integer.parseInt(request.getParameter("ordem"));
	String vtexto = (request.getParameter("texto") == null) ? "" : request.getParameter("texto").toUpperCase();
	int varea = (request.getParameter("area") == null) ? 0 : Integer.parseInt(request.getParameter("area"));
	int vtipo = (request.getParameter("tipo") == null) ? 0 : Integer.parseInt(request.getParameter("tipo"));
	
%>

<c:set var="catalogo" value="<%=vcatalogo%>" scope="page" />
<c:set var="ano" value="<%=vano%>" scope="page" />
<c:set var="ordem" value="<%=vordem%>" scope="page" />
<c:set var="texto" value="<%=vtexto%>" scope="page" />
<c:set var="area" value="<%=varea%>" scope="page" />
<c:set var="tipo" value="<%=vtipo%>" scope="page" />

<jsp:useBean id="lista_catalogos"
	class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
<c:set var="items"
	value="${lista_catalogos.getCatalogo(sessionScope['login'], sessionScope['senha'], catalogo, ano, ordem, texto, area, tipo)}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<br> <br>
			<div align="left">
				<table id="gecoi2"  class="table table-striped table-bordered" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th align="center">DATA</th>
							<th align="center">T&Iacute;TULO</th>
							<th align="center">A&Ccedil;&Otilde;ES</th>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach var="catalogo" items="${items}">
							<tr>
								<td align="center" width="10%">${catalogo.data }</td>
								<td align="center" width="70%">${catalogo.descricao_catalogo }</td>
								<td align="center" width="20%">
								<div class='divAcoes'>
										<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${catalogo.id_conteudo }&idArquivo=${catalogo.id_arquivo }"
											target="_blank" title="Visualização do arquivo">
											<img id="arquivo${catalogo.id_conteudo }" name="arquivo${catalogo.id_conteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" />
										</a> 
									    <a href="#" onclick="carregaPag('/gecoi.3.0/apps/gecoi_catalogo/alterar_dados.jsp?idConteudo=${catalogo.id_conteudo }&idCatalogo=<%=vcatalogo%>&descricao=${catalogo.descricao_catalogo }','divbusca');"
											title="Alteração dos dados">
											<img id="dados${catalogo.id_conteudo }" name="dados${catalogo.id_conteudo }" src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" />
										</a>
										<a href="#" onclick="valida_exclusao('${catalogo.id_arquivo }', '${catalogo.id_conteudo }', '<%=vcatalogo%>', '${catalogo.descricao_catalogo }')" title="Excluir"><img src='/gecoi.3.0/img/excluir_cinza.png' alt='Excluir' border='0'></a> 
											

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
