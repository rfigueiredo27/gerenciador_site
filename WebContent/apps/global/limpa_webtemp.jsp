<%@page import="java.io.File"%>

<%
String diretorio = getServletContext().getRealPath("/") + "webtemp";
String arquivos;
File pasta = new File(diretorio);
File[] listaArquivos = pasta.listFiles(); 
for (int i = 0; i < listaArquivos.length; i++) 
{
	if (listaArquivos[i].isFile()) 
	{
		if (listaArquivos[i].getName().indexOf(session.getAttribute("login").toString()) > -1)
		{
			listaArquivos[i].delete();
		}
	}
}
%>