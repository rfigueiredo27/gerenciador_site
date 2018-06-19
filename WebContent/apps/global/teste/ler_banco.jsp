<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File"%>
<%
	String caminho2 = application.getRealPath("/") + "apps\\troca_banco\\banco.txt";
	String vambiente2 = "Produção";
	File arqTexto = new File(caminho2);
	
	if (arqTexto.exists())
	{
		FileReader arq2 = new FileReader(caminho2);
    	BufferedReader lerArq2 = new BufferedReader(arq2);

    	vambiente2 = "Banco de " + lerArq2.readLine(); // lê a primeira linha

    	arq2.close();
	}
%>        
