<%@page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%
	String vidArquivo = request.getParameter("idarquivo");
	String vusuario = session.getAttribute("login").toString();
	String vdiretorio = application.getRealPath("/") + "webtemp";
	//out.print(application.getContextPath()); //gecoi.3.0
	//out.print(request.getLocalName()); //gecoi.3.0
	//out.print(request.getServerName()); //localhost
	
	GravarArquivo gravar = new GravarArquivo();
	String vlink = gravar.gravar(vidArquivo, vdiretorio, vusuario);
	vlink = "/gecoi.3.0/webtemp/" + vlink;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html dir="ltr" xml:lang="pt-br" lang="pt-br" xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>TRE-RJ</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta http-equiv="Cache-Control" content="no cache">
  <meta http-equiv="Pragma" content="no cache">
  <meta http-equiv="Expires" content="0">
  <meta http-equiv="refresh" content="1;URL=<%=vlink%>">

  <!--Estatistica do Google-->
  <script type="text/javascript" src="/site/scripts/estatistica_google.js"></script>  
</head>
<body>
</body>
</html>