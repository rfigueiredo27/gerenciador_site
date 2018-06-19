<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="br.jus.trerj.funcoes.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Chave chave = new Chave();
//out.print(chave.verifica("B@1ed40e0", "GDEBOSSA", "gude0004"));
//out.print(chave.verifica("[B@b87035", "GDEBOSSA", "gude0004"));

 //out.print(chave.verifica("R1VTVEFWTyBBRkZPTlNPIERFQk9TU0FNQEBHREVCT1NTQQ==", "GDEBOSSA", "gude0004"));
 //chave.enviar(request.getServletPath(), request.getRemoteAddr(), "GDEBOSSA");
 out.print(chave.verificaValidade("R1VTVEFWTyBBRkZPTlNPIERFQk9TU0FNQEBHREVCT1NTQUBAMjAxODA1MTExMzAw", "GDEBOSSA", "gude0004"));
%>
</body>
</html>