<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@page import="java.util.ArrayList"%>
<html>
<head>
	<link href="/gecoi.3.0/scripts/thickbox/thickbox.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="/gecoi.3.0/scripts/thickbox/thickbox.js" type="text/javascript"></script>


<script>
function ativar(ativo, vidConteudo)
{
	var vativo = "0";
	if (ativo)
		vativo = "1";
	$.post("/gecoi.3.0/apps/curriculo/processa_alteracao_curriculo.jsp", {idConteudo : vidConteudo, publicado: vativo}, function(){});

}

function excluir(vidConteudo, vdescricao)
{
	if (confirm("Deseja realmente excluir o currículo de " + vdescricao) == true)
		$.post("/gecoi.3.0/apps/curriculo/processa_exclusao_curriculo.jsp", {idConteudo : vidConteudo}, function(){top.listar();});
}
</script>
</head>
<body>
<%
String vtexto = request.getParameter("vtexto");
String vativo = request.getParameter("vativo");
%>
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ativo" value="<%=vativo %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.controle.curriculo.ListaCurriculos" /> 
<c:set var="items" value="${lista.getListaCurriculos(texto, ativo)}" />
<c:choose>
	<c:when test="${!empty items}">
	<form name="flista">
		<table>
			<tr>
				<th>NOME</th>
				<th>NOME</th>
				<th>FOTO</th>
				<th>TEXTO</th>
				<th>EXCLUIR</th>
				<th>ATIVO</th>
			</tr>
		<c:forEach var="curriculo" items="${items}" >
			<tr>
				<td>${curriculo.descricao }</td>
				<td><a href="/gecoi.3.0/apps/curriculo/alterar_descricao.jsp?id=${curriculo.idConteudo }&descricao=${curriculo.descricao }&keepThis=true&TB_iframe=false&height=150&width=300" class="thickbox" title="Manutenção da descri&ccedil;&atilde;o"><img id="foto${curriculo.idConteudo }" name="foto${curriculo.idConteudo }" src="/gecoi.3.0/img/maquina_digital.jpg" onclick="" width="30" height="30" /></a></td>
				<td><a href="/gecoi.3.0/apps/curriculo/alterar_imagem.jsp?id=${curriculo.idConteudo }&idArquivoImg=${curriculo.idArquivoImg }&descricao=${curriculo.descricao }&nome=${curriculo.nomeArquivoImg }&keepThis=true&TB_iframe=true&height=550&width=800" class="thickbox" target="divthick" title="Manutenção da foto"><img id="foto${curriculo.idConteudo }" name="foto${curriculo.idConteudo }" src="/gecoi.3.0/img/maquina_digital.jpg" onclick="" width="30" height="30" /></a></td>
				<td><a href="/gecoi.3.0/apps/curriculo/alterar_texto.jsp?id=${curriculo.idConteudo }&idArquivoTexto=${curriculo.idArquivoTexto }&descricao=${curriculo.descricao }&nome=${curriculo.nomeArquivoTexto }&keepThis=true&TB_iframe=true&height=350&width=800" class="thickbox"  title="Manutenção do texto"><img id="texto${curriculo.idConteudo }" name="texto${curriculo.idConteudo }" src="/gecoi.3.0/img/texto.jpg" onclick="" width="30" height="30" /></a></td>
				<td><a href="#" title="Exclusão do currículo"><img id="excluir${curriculo.idConteudo }" name="excluir${curriculo.idConteudo }" src="/gecoi.3.0/img/botao_excluir.png" width="30" height="30" onclick="excluir('${curriculo.idConteudo }', '${curriculo.descricao }');" /></a></td>
				<c:set var="ativo" value="" />
				<c:if test="${curriculo.publicado > 0}">
					<c:set var="ativo" value="checked='checked'" />
				</c:if>
				<td><input type="checkbox" name="ativo${curriculo.idConteudo }" id="ativo${curriculo.idConteudo }" onclick="ativar(this.checked, '${curriculo.idConteudo }');" ${ativo } /></td>
			</tr>					
		</c:forEach>
		</table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
<div id="rodape"></div>
</body>
</html>