<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GECOI Arquivos - Visualiza&ccedil;&atilde;o do Arquivo</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<%
String vidConteudo = request.getParameter("idConteudo");
String vidArquivo = request.getParameter("idArquivo");
%>
<jsp:useBean id="totalAnexos" class="br.jus.trerj.funcoes.ListaArquivo" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="idArquivo" value="<%=vidArquivo %>" scope="page" />
<c:set var="tamanhoAnexo" value="${totalAnexos.getTamanhoAnexos(idConteudo, idArquivo, sessionScope['login'], sessionScope['senha'])}" />
			<frameset rows="*,${tamanhoAnexo}" cols="*" frameborder="no" border=0 framespacing=0>
  				<frame src="grava_arquivo.jsp?idarquivo=<%=vidArquivo%>" name="aviso" title="Frame para download de arquivo" scrolling="auto">
  				<frame src="visualizar_anexos.jsp?idconteudo=<%=vidConteudo %>&idarquivo=<%=vidArquivo%>" name="anexo"  title="Frame para visualização de arquivo" noresize frameborder="NO" scrolling="auto">
			</frameset>
<noframes>
<body>
</body>
</noframes>
</html>