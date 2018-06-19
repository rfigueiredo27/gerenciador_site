<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<script>
function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + document.fanexo.idConteudo.value + "&nProcesso=" + document.fanexo.nProcesso.value + "&nPregao=" + document.fanexo.nPregao.value, "divbusca");
}


function excluirAnexo(vidArquivo, vidConteudo)
{
	if (confirm("Deseja realmente excluir o anexo ?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=" + vidConteudo + "&nProcesso=" + document.fanexo.nProcesso.value + "&nPregao=" + document.fanexo.nPregao.value,"divbusca");});

}
</script>
<%
String vidConteudo = request.getParameter("id");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" /> 
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" /> 
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="items" value="${lista.getListaAnexos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />

<div id="altera_anexo_incluir">
<fieldset>
	<legend>Lista de Anexos</legend>
<div id="numero">
	<div id="numero_processo">	
    	<p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso%></strong></p>
	</div>
    <div id="numero_pregao">
     	<p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnumPregao%></strong></p>
	</div>
</div>

	<form name="fanexo" action="/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=${idConteudo}&nPregao=${numPregao }&nProcesso=${numProcesso}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo %>" />
         <input type="hidden" name="nPregao" id="nPregao" value="<%=vnumPregao %>"  />
         <input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnumProcesso %>" /> 
            <table id="tb_gecoi">
				<tr>
					<th scope="col" width="60%">DESCRI&Ccedil;&Atilde;O</th>
					<th scope="col" colspan="8" width="20%">A&Ccedil;&Atilde;O</th>
				</tr></thead><tbody>
			<c:forEach var="anexo" items="${items}" >
<!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>

      			<tr  bgcolor=<%=vcor%> >
        			<td align="left">
        				${anexo.descricao }
        			</td>
           			<td width="2%"><a href="/gecoi.3.0/apps/global/grava_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" target="_blank" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_arquivo.jsp?id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=<%=vnumProcesso%>&nPregao=<%=vnumPregao%>&descricao=${anexo.descricao }&tipo=${licitacao.tipo }&origem=anexo&titulo=anexo','divbusca');" title="Substitui&ccedil;&atilde;o do Aditivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/alterar_descricao_anexo.jsp?id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=<%=vidConteudo%>&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>&tipo=${licitacao.tipo }','divbusca');" title="Alterar dados do anexo"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="excluirAnexo(${anexo.idArquivo },${anexo.idConteudo });"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a></td>	
      			</tr>
			</c:forEach>
            </tbody></table>
        		<div id="anexo">	
        			<a href="#" onclick="carregaPag('/gecoi.3.0/apps/licitacao/incluir_anexo.jsp?idConteudo=${idConteudo}&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>','divbusca');" >(+) Incluir Anexo</a>
               </div>	
	</form>
    <div id="botao_anexo">
		<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
	</div>

    
</fieldset>
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 