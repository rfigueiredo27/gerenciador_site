<%@page import="java.io.PrintWriter, java.io.FileWriter, java.io.File;"%>
<%
String caminho = application.getRealPath("/") + "apps\\troca_banco\\banco.txt";
String vambiente = request.getParameter("ambiente");

try
{
	FileWriter arq = new FileWriter(caminho);
	PrintWriter gravarArq = new PrintWriter(arq);

	gravarArq.printf(vambiente);

	arq.close();
	out.print("Ambiente Gravado");
}
catch (Exception ex)
{
	out.print("erro na gravação do ambiente: " + ex.getMessage());
}

%>

<script>
	top.document.getElementById("span_banco").innerHTML = "Banco de " + document.getElementById("ambiente").options[document.getElementById("ambiente").selectedIndex].text; 
</script>