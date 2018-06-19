
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

String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");

%>

			<frameset rows="30,*" cols="*" frameborder="no" border=0 framespacing=0>
				<frame src="/gecoi.3.0/apps/licitacao/voltar.jsp?idConteudo=<%=vidConteudo%>&nProcesso=<%=vnumProcesso%>&nPregao=<%=vnumPregao%>"></frame>
  				<frame src="/gecoi.3.0/apps/global/grava_arquivo.jsp?idarquivo=<%=vidArquivo%>" name="aviso" title="Frame para download de arquivo" scrolling="auto">
			</frameset>
<noframes>
<body>
</body>
</noframes>
</html>