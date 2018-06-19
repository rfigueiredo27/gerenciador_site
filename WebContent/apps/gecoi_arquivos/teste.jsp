<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%

String destino = "";
String descricao = "";
String arquivo = "";
String descricao_anexo = "";
String anexo = "";


Enumeration e = request.getParameterNames();
if (e.hasMoreElements())
{
	destino = request.getParameter("destino");
	descricao = request.getParameter("descricao");
	arquivo = request.getParameter("arquivo");
	descricao_anexo = request.getParameter("descricao_anexo");
	anexo = request.getParameter("anexo");
	String ordem = anexo = request.getParameter("ordem");
	
	out.println(destino + "<br><br>");
	out.println(descricao + "<br><br>");
	out.println(arquivo + "<br><br>");
	out.println(descricao_anexo + "<br><br>");
	out.println(anexo + "<br><br>");
}




%>

</body>
</html>