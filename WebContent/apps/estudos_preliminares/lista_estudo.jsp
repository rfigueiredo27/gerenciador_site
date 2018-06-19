<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<%request.setCharacterEncoding("UTF-8");%>
   

<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vedital = request.getParameter("edital");
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.estudosPreliminares.ListaEstudo" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="edital" value="<%=vedital %>" scope="page" /> 
<c:set var="items" value="${lista.getListaReferencia(idLicitacao, sessionScope['login'], sessionScope['senha'])}" />
<div id="altera_ata">
<fieldset>
	<legend>Lista de Estudos Preliminares</legend>
		<form name="fanexo" action="/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
        
			<input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
			<div id="numero">
    			<div id="descricao_arquivo">
        			<p>Descri&ccedil;&atilde;o: <strong><%= vedital%></strong></p>
				</div>
				<div id="numero_processo">
        			<p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso%></strong></p>
				</div>
    			<div id="numero_pregao">
     				<p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnumPregao%></strong></p>
				</div>
            </div>
            <div id="anexo_tabela">
			 <table id="tb_gecoi">
				<tr><thead>
					<th scope="col" width="24%">DESCRI&Ccedil;&Atilde;O </th>
					<th scope="col" width="4%">PUBLICA&Ccedil;&Atilde;O</th>
					<th scope="col" colspan="8" width="20%">A&Ccedil;&Atilde;O</th>
				</tr></thead>
			<c:forEach var="anexo" items="${items}" >
      			<!--///////////////zebra a tabela /////////-->
<% 
if (vcor.equals(""))
	vcor="#ECECEC";
else
	vcor="";    
%>

      			<tr  bgcolor=<%=vcor%> >
        			<td align="left">${anexo.descricao }</td>
        			<td align="center">${anexo.dataPublicacao }</td>
        			<td width="2%" align="center"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" target="_blank" /></a></td>
           			<td width="2%" align="center"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&edital=${edital}&descricao=${anexo.descricao}','divbusca');" title="Substitui&ccedil;&atilde;o do Estudo Preliminar"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%" align="center"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/alterar_dados_estudo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataPublicacao=${anexo.dataPublicacao}&idArea=${anexo.idArea}&edital=${edital}','divbusca');" title="Alterar dados do Estudo Preliminar"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%" align="center"><a href="#" onclick="excluirAnexo(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}', '${edital}');" title="Exclusão do Estudo Preliminar"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a></td>
      			</tr>
			</c:forEach>
     			</table> 
                <div id="anexo">   			
        			<a href="#" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/incluir_estudo.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&edital=${edital}','divbusca');">(+) Incluir Estudo Preliminar</a>
                </div>
        </div>
	</form>
    
<div id="botao">
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
</div>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>

<script>

function excluirAnexo(vidConteudo, pLicitacao, pnProcesso, pnPregao, pedital)
{
	if (confirm("Deseja realmente excluir o estudo preliminar selecionado?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=" + pLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso + "&edital=" + pedital,"divbusca");});
}
</script> 