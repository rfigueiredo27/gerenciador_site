<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vapp = request.getParameter("app");

%>

<a href="/gecoi.3.0/apps/<%=vapp%>/alterar_anexo.jsp?idLicitacao=<%=vidLicitacao%>&nProcesso=<%=vnumProcesso%>&nPregao=<%=vnumPregao%>" target="_parent">Voltar</a>