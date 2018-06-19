<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<!-- Area = 2693 -->

<jsp:useBean id="lista"
	class="br.jus.trerj.controle.documentoEliminacao.ListaDocumentosEliminacao" />
<c:set var="items"
	value="${lista.getListaDocumentos(sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="flista">
			<h3 align="center">Lista de Documentos para Eliminação</h3>
			<br><br>
			<div class="dataTables_wrapper">
				<table id="documentos" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th scope="col">Data</th>
							<th scope="col">Unidade (Gecoi)</th>
							<th scope="col">Nº Edital</th>
							<th scope="col">Edital de Eliminação (Descrição)</th>
							<th scope="col">Ações</th>
							<th scope="col">Lista Documentos Eliminação</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="documentos" items="${items}">
							
							<tr>
								<td align="center" width="5%">${documentos.dataPublicacao }</td>
								<td align="center" width="20%">${documentos.unidade }</td>
								<td align="center" width="10%">${documentos.edital }</td>
								<td align="center" width="20%">${documentos.descricao_arquivo }</td>
								
								<td align="center" width="15%"><div class='divAcoes'>
									<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${documentos.idConteudo }&idArquivo=${documentos.idArquivo }"	target="_blank" title="Visualização do arquivo">
										<img id="arquivo${documentos.idConteudo }" name="arquivo${documentos.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" /></a> 
									<a href="#"	onclick="carregaPag('/gecoi.3.0/apps/documentos_eliminacao/alterar_dados.jsp?idConteudo=${documentos.idConteudo }&idArquivo=${documentos.idArquivo }&descricao=${documentos.descricao_arquivo }&data=${documentos.dataPublicacao }&edital=${documentos.edital }&unidade=${documentos.unidade }&area=${documentos.idArea }','divbusca');"
									title="Alteração dos dados do aviso">
										<img id="dados${documentos.idConteudo }" name="dados${documentos.idConteudo }" src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a> 
									<a href="#" onclick="carregaPag('/gecoi.3.0/apps/documentos_eliminacao/alterar_arquivo.jsp?id=${documentos.idConteudo }&idArquivo=${documentos.idArquivo }&descricao=${documentos.descricao_arquivo }','divbusca');"
									title="Substitui&ccedil;&atilde;o do arquivo">
										<img id="arquivo${documentos.idConteudo }" name="arquivo${documentos.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a>  
									<a href="#" title="Exclusão do Aviso"><img id="excluir${documentos.idConteudo }" name="excluir${documentos.idConteudo }" src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22"
										onclick="excluir('${documentos.idConteudo }');" /></a>
									</div></td>
								
								<td align="center" width="20%"><a href="#" class="btn btn-default"
									onclick="carregaPag('/gecoi.3.0/apps/documentos_eliminacao/alterar_anexo.jsp?id=${documentos.idConteudo }','divbusca');"
									title="Acessar a Lista de Documentos para Eliminação">Acessar</a></td>
								
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