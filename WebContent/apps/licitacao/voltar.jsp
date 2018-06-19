<%
String vidConteudo = request.getParameter("idConteudo");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");

%>

<a href="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=<%=vidConteudo%>&nProcesso=<%=vnumProcesso%>&nPregao=<%=vnumPregao%>" target="_parent">Voltar</a>