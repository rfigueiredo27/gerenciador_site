<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File;"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>

function trocar()
{
	$.post("/gecoi.3.0/apps/troca_banco/trocar_banco.jsp", { ambiente: document.ftroca.ambiente.value}, function(resposta) {$("#divtroca").html(resposta);});
}
</script>
</head>
<body>
<form name='ftroca' >
<%
	String caminho = application.getRealPath("/") + "apps\\troca_banco\\banco.txt";
	String vambiente = "Produção";
	
	File arqTexto = new File(caminho);
	
	if (arqTexto.exists())
	{
		FileReader arq = new FileReader(caminho);
		BufferedReader lerArq = new BufferedReader(arq);
	
		vambiente = lerArq.readLine(); // lê a primeira linha

		arq.close();
	}
	String vseleciona = "";
	out.print("<select name='ambiente' id='ambiente'>");
	if (vambiente.equals("Desenvolvimento"))
		vseleciona = "selected='selected'";
	out.print("<option value='Desenvolvimento' " + vseleciona + ">Desenvolvimento</option>");
			
	vseleciona = "";
	if (vambiente.equals("Produção"))
		vseleciona = "selected='selected'";
	out.print("<option value='Produção' " + vseleciona + ">Produção</option>");
	out.print("</select>");
%>
	<input type="button" value="Trocar" onclick="trocar();" />
	</form>
	<div id="divtroca"></div>
</body>
</html>