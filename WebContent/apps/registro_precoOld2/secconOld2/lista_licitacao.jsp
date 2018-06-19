<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<html>
<head>


<script>
//$(document).ready(function(){
		//$( "#tabs" ).tabs();
//	});
/*	
function excluir(vidConteudo, vdescricao)
{
	if (confirm("Deseja realmente excluir o registro de preços de " + vdescricao + " ?") == true)
		$.post("/gecoi.3.0/apps/registro_preco/seccon/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar();});
}
*/
</script>
</head>
<body>
<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
String vcor       = "#ECECEC";  // zebra a tabela
%>
<h2>Lista  de Editais de licita&ccedil;&atilde;o</h2>
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="filtro" value="" scope="page" />
<c:set var="filtroValor" value="" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="items" value="${lista.getListaLicitacao(ano, texto, filtro, filtroValor, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
				<form name="flista">
				<table id="tb_gecoi"><thead>
					<tr>
						<th scope="col" width="8%">Nº DO PREG&Atilde;O</th>	
						<th scope="col" width="76%">OBJETO</th>
						<th scope="col" width="8%">Nº DO PROCESSO</th>
						<th scope="col" colspan="8" width="5%">A&Ccedil;&Otilde;ES</th>
					</tr></thead><tbody>
		<c:forEach var="registro" items="${items}" >
        <% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
				<td  align="center">${registro.numPregao }</td>
				<td  align="left">${registro.descricao }</td>
				<td  align="center">${registro.numProcesso }</td>
				<td><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${registro.idConteudo }&idArquivo=${registro.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${registro.idConteudo }" name="arquivo${registro.idConteudo }" src="/gecoi.3.0/img/consulta.png" onClick="" width="22" height="22" /></a></td>
				<td><a href="#" onClick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=${registro.idArquivo }&nPregao=${registro.numPregao }&nProcesso=${registro.numProcesso }','divbusca');"  title="Manutenção das Atas"><img id="aditivo${registro.idConteudo }" name="aditivo${registro.idConteudo }" src="/gecoi.3.0/img/texto.jpg" onClick="" width="22" height="22" /></a></td>
			</tr>					
		</c:forEach>
		</tbody></table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
</body>
</html>