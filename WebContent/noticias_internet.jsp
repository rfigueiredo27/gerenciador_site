<%@page language="java" import="java.sql.*,java.util.*, br.jus.trerj.funcoes.UltimasNoticiasInternet"%>
<% 
	UltimasNoticiasInternet ultimas = new UltimasNoticiasInternet();
	out.println(ultimas.ultimasTV("gdebossa", "gude0004"));
	out.println("rodou");
%>