<%@page import="br.jus.trerj.modelo.TrocaBanco, java.util.ArrayList, com.thoughtworks.xstream.XStream, com.thoughtworks.xstream.io.xml.DomDriver, java.io.BufferedReader, java.io.FileReader, java.io.File, java.util.Iterator, java.util.ListIterator;"%>

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
	<form action='/gecoi.3.0/apps/troca_banco/trocar_banco.jsp' name='ftroca' target="">
	<table>
		<tr>
			<th>Usuário</th>
			<th>Ambiente</th>
		</tr>
<%
	String vusuario = session.getAttribute("login").toString();
	String caminho = application.getRealPath("/") + "apps\\troca_banco\\banco.xml";
	String vambiente = "producao";
	String vseleciona = "";
	String vleitura = "";
	int conta = 0;
	boolean achei = false;
	File arquivoAux = new File(caminho);
	if (arquivoAux.exists())
	{
		
		XStream stream = new XStream(new DomDriver());
		stream.alias("bancos", ArrayList.class);
		stream.alias("banco", TrocaBanco.class);
		
		BufferedReader input = new BufferedReader(new FileReader(caminho));
		ArrayList<TrocaBanco> lista = (ArrayList<TrocaBanco>) stream.fromXML(input);
		input.close();
		
		Iterator<TrocaBanco> interacao = lista.iterator();
		while (interacao.hasNext()) 
		{
			TrocaBanco item = interacao.next();
			vleitura = "disabled='disabled'";
			if (item.getUsuario().equals(vusuario))
			{
				vambiente = item.getAmbiente();  
				achei = true;
				vleitura = "";
			}
			
			conta++;
			out.print("<tr>");
			out.print("<td><input type='text' readonly='readonly' " + vleitura + " value='" + item.getUsuario() + "' name='usuario" + conta + "' id='usuario" + conta + "' /></td>");
			out.print("<td>");
			out.print("<select name='ambiente" + conta + "' id='ambiente" + conta + "' " + vleitura + ">");
			if (vambiente.equals("desenvolvimento"))
				vseleciona = "selected='selected'";
			out.print("<option value='desenvolvimento' " + vseleciona + ">Desenvolvimento</option>");
		
			if (vambiente.equals("producao"))
				vseleciona = "selected='selected'";
			out.print("<option value='producao' " + vseleciona + ">Produção</option>");
			out.print("</select>");
			out.print("</td>");
			out.print("</tr>");
		}
	}
	if (!achei)
	{
		conta++;
		out.print("<tr>");
		out.print("<td><input type='text' readonly='readonly' value='" + vusuario + "' name='usuario" + conta + "' id='usuario" + conta + "' /></td>");
		out.print("<td>");
		out.print("<select name='ambiente" + conta + "' id='ambiente" + conta + "'>");
		if (vambiente.equals("desenvolvimento"))
			vseleciona = "selected='selected'";
		out.print("<option value='desenvolvimento' " + vseleciona + ">Desenvolvimento</option>");
	
		if (vambiente.equals("producao"))
			vseleciona = "selected='selected'";
		out.print("<option value='producao' " + vseleciona + ">Produção</option>");
		out.print("</select>");			
		out.print("</td>");
		out.print("</tr>");
	}
%>
	</table>
	<input type="submit" value="Trocar" onclick="" />
	</form>
	<div id="divtroca"></div>
</body>
</html>