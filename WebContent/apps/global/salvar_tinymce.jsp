<%@ page contentType="text/plain" import="java.util.*, java.io.*"%>
<%
String texto = request.getParameter("texto");

try
{
	byte[] contentInBytes = texto.getBytes();
	File file = new File(application.getRealPath("/") + "/webtemp/arquivo-" + session.getAttribute("login").toString() + ".htm");
	FileOutputStream fop = new FileOutputStream(file);
	fop.write(contentInBytes);
	fop.flush();
	fop.close();
} 
catch (Exception e) 
{
	out.print(e.getMessage());
}
%>