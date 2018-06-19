<%@ page import="java.sql.*,br.jus.trerj.funcoes.*" %>
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
LimpaParametro limpa = new LimpaParametro();
//String vfiltro = "<script>testando o script.  Será que limpou?  <>>> *&*&()";
String vfiltro = limpa.limpa(request.getParameter("filtro"));
//vfiltro = limpa.limpa(vfiltro);
out.print(vfiltro);
//vfiltro = "";
vfiltro = limpa.limpa(vfiltro);
out.print(vfiltro);
%>
</body>
</html>