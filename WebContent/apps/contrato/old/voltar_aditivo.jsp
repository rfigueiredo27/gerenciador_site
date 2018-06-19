<%
String vidLicitacao = request.getParameter("idLicitacao");
String vidConteudo = request.getParameter("idConteudo");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");

String vdataPublicacao = request.getParameter("dataPublicacao");
String vdescricao = request.getParameter("descricao");
String vnContrato = request.getParameter("nContrato");

%>

<a href="/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=<%=vidLicitacao%>&descricao=<%=vdescricao%>&idConteudo=<%=vidConteudo%>&nProcesso=<%=vnumProcesso %>&nPregao=<%=vnumPregao%>&nContrato=<%=vnContrato%>&dataPublicacao=<%=vdataPublicacao%>" target="_parent">Voltar</a>