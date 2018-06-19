<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GECOI Arquivos - Visualizao do Arquivo</title>
<link rel="stylesheet" type="text/css" href="../css/iframe.css"/>

<script language="javascript">
//função que abre janela com o anexo escolhido
function abreJanelaAnexo(ida)
{ 
   url = "grava_arquivo.jsp?idarquivo=" + ida;
   window.open( url,"ANEXOS","resizable=yes,scrollbars=no,toolbar=yes,width=780,height=580");
}
</script>
    
<style type="text/css">
body {
	background:#cccccc;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>

</head>

<body>
<div style="background:#ccc">
  <span class="texto_sub_unidade" >&nbsp;&nbsp;<br />
  &nbsp;ANEXOS</span>
  <table cellpadding="2">
  <tr>
	<td valign='top'><ul class='bullet'>
<%
	String vidConteudo = request.getParameter("idconteudo");
	String vidArquivo = request.getParameter("idarquivo");
%>	
<c:set var="vlinha" value="0" scope="page" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
<c:set var="idArquivo" value="<%=vidArquivo %>" scope="page" />
<jsp:useBean id="lista" class="br.jus.trerj.funcoes.ListaArquivo" />
<c:set var="items" value="${lista.getListaAnexos(idConteudo, idArquivo, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<c:forEach var="anexo" items="${items}" >
			<c:set var="vlinha" value="${vlinha + 1 }"/>
			<c:if test="${vlinha > 2 }">
				</ul></td><td valign='top'><ul class='bullet'>
				<c:set var="vlinha" value="0"/>
			</c:if>
			<li><a href='#' onclick="abreJanelaAnexo('${anexo.idArquivo}')">${anexo.descricao}</a></li>
		</c:forEach>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não tem registros" />
	</c:otherwise>
</c:choose>
  </table>
	</ul></td>
  </tr>
  </table>
</div>
</body>
</html>