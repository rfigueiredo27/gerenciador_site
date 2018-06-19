<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar,java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="ata" class="br.jus.trerj.controle.registroPreco.seccon.ListaRegistro" />
<c:set var="numAta" value="${ata.getnumAta(sessionScope['login'], sessionScope['senha'])}" />
<strong>${numAta }</strong><br/>
<%
Calendar c = Calendar.getInstance();
Date data = c.getTime();
                
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
out.println("<p>Gerado em:" + sdf.format(data) + "</p>");  
%>
