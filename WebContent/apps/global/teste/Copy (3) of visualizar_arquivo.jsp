<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String vidConteudo = request.getParameter("idConteudo");
String vidArquivo = request.getParameter("idArquivo");
//54217
%>
<jsp:useBean id="totalAnexos" class="br.jus.trerj.funcoes.ListaArquivo" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="idArquivo" value="<%=vidArquivo %>" scope="page" />
<c:set var="tamanhoAnexo" value="${totalAnexos.getTamanhoAnexos(idConteudo, idArquivo, sessionScope['login'], sessionScope['senha'])}" />
<div id="gravaArquivo"><%//response.sendRedirect("grava_arquivo.jsp?idarquivo=" + vidArquivo); %></div>

<script>

$.post("/gecoi.3.0/apps/global/grava_arquivo.jsp?idarquivo=" + <%=vidArquivo%>, function(resultado){$("#gravaArquivo").html(resultado)});

</script>