<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
<script>


function excluirAta(vidConteudo, plicitacao, pnProcesso, pnPregao, pata)
{
	if (confirm("Deseja realmente excluir a ata " + pata + " ?") == true)
		$.post("/gecoi.3.0/apps/registro_preco/secomp/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/registro_preco/secomp/lista_registro.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");});
}
</script>
<%
String vtexto = request.getParameter("vtexto");
String vano = request.getParameter("vano");
String vcor       = "#ECECEC";  // zebra a tabela
%>
<h2>Lista de Atas de Registro de Pre&ccedil;os</h2>
<jsp:useBean id="lista" class="br.jus.trerj.controle.registroPreco.secomp.ListaRegistro" />
<c:set var="texto" value="<%=vtexto %>" scope="page" />
<c:set var="ano" value="<%=vano %>" scope="page" />
<c:set var="items" value="${lista.getListaAta(texto, ano, sessionScope['login'], sessionScope['senha'])}" />
<c:choose>
	<c:when test="${!empty items}">
		<form name="fanexo" action="" method="post" enctype="multipart/form-data">
			<table id="tb_gecoi"><thead>
			<tr>
			 	<th scope="col" width="8%">N&ordm; DO PREG&Atilde;O</th>
			 	<th scope="col" width="8%">N&ordm; DO PROCESSO</th>
				<th scope="col" width="76%">DESCRI&Ccedil;&Atilde;O</th>
				<th scope="col" colspan="8" width="5%">A&Ccedil;&Atilde;O</th>
			</tr></thead>
			<c:forEach var="anexo" items="${items}" >
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
        			<td align="center">${anexo.numPregao }</td>
        			<td align="center">${anexo.numProcesso }</td>
        			<td align="left">${anexo.descricaoCompleta }</td>
        			<td><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onClick="" width="22" height="22" target="_blank" /></a></td>
           			<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/secomp/alterar_referencia_ata.jsp?id=${anexo.idArquivo }&descricaoCompleta=${anexo.descricaoCompleta }&idConteudo=${anexo.idConteudo }&nProcesso=${anexo.numProcesso}&nPregao=${anexo.numPregao}&numAta=${anexo.numAta }&idReferencia=${anexo.idReferencia }','divbuscaAta');" title="Alterar refer&ecirc;ncia da ata"><img src="/gecoi.3.0/img/texto.jpg" onClick="" width="22" height="22" /></a>
           				<!-- <a href="#" onclick="excluirAta(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}', '${anexo.numAta }');" title="Exclusão da Ata"><img width="20" height="20" src="/gecoi.3.0/img/botao_excluir.png" /></a>  -->
        			</td>
      			</tr>
			</c:forEach>
		</table>
	</form>
	</c:when>
	<c:otherwise>
		<c:out value="Não há registros" />
	</c:otherwise>
</c:choose>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
