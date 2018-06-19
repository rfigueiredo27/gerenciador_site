<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>
   
<script>


function excluirAnexo(vidConteudo, plicitacao, pnProcesso, pnPregao, pata, pedital)
{
	if (confirm("Deseja realmente excluir a ata " + pata + " ?") == true)
		$.post("/gecoi.3.0/apps/registro_preco/seccon/processa_exclusao.jsp", {idConteudo : vidConteudo}, 
				function(){carregaPag("/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + plicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso + "&edital=" + pedital,"divbusca");});
}
</script>
<%
// Arquivo guarda o arquivo principal da licitação - Edital
String vidLicitacao = request.getParameter("idLicitacao");
String vnumPregao = request.getParameter("nPregao");
String vnumProcesso = request.getParameter("nProcesso");
String vedital = request.getParameter("edital");
String vcor       = "#ECECEC";  // zebra a tabela
%>

<jsp:useBean id="lista" class="br.jus.trerj.controle.registroPreco.seccon.ListaRegistro" />
<c:set var="idLicitacao" value="<%=vidLicitacao %>" scope="page" />
<c:set var="numPregao" value="<%=vnumPregao %>" scope="page" />
<c:set var="numProcesso" value="<%=vnumProcesso %>" scope="page" /> 
<c:set var="edital" value="<%=vedital %>" scope="page" /> 
<c:set var="items" value="${lista.getListaReferencia(idLicitacao, sessionScope['login'], sessionScope['senha'])}" />
<div id="altera_ata">
<fieldset>
	<legend>Lista de Atas de Registro de Pre&ccedil;os</legend>
		<form name="fanexo" action="/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=${idLicitacao }&nProcesso=${numProcesso }&nPregao=${numPregao }" method="post" enctype="multipart/form-data">
        
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
					<th scope="col" width="20%">ATA</th>
					<th scope="col" width="17%">FORNECEDOR</th>
					<th scope="col" width="24%">DESCRI&Ccedil;&Atilde;O DETALHADA</th>
					<th scope="col" width="4%">PUBLICA&Ccedil;&Atilde;O</th>
					<th scope="col" width="13%">VIG&Ecirc;NCIA</th>
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
        			<td align="left">${anexo.numAta }</td>
        			<td align="left">${anexo.fornecedor }</td>
        			<td align="left">${anexo.descricao }</td>
        			<td align="center">${anexo.dataPublicacao }</td>
        			<td align="center">${anexo.dataVigenciaInicial } a ${anexo.dataVigenciaFinal }</td>
        			<td width="2%"><a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }" target="_blank" title="Visualização do arquivo"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/consulta.png" onclick="" width="22" height="22" target="_blank" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/alterar_arquivo.jsp?idLicitacao=${idLicitacao }&id=${anexo.idConteudo }&idArquivo=${anexo.idArquivo }&nProcesso=${numProcesso}&nPregao=${numPregao}&descricao=${anexo.descricao }','divbusca');" title="Substitui&ccedil;&atilde;o da Ata"><img id="arquivo${anexo.idConteudo }" name="arquivo${anexo.idConteudo }" src="/gecoi.3.0/img/reverter.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/alterar_dados_ata.jsp?idLicitacao=${idLicitacao }&id=${anexo.idArquivo }&descricao=${anexo.descricao }&idConteudo=${anexo.idConteudo }&nProcesso=${numProcesso}&nPregao=${numPregao}&dataPublicacao=${anexo.dataPublicacao}&dataVigenciaInicial=${anexo.dataVigenciaInicial}&dataVigenciaFinal=${anexo.dataVigenciaFinal}&idArea=${anexo.idArea}&numAta=${anexo.numAta }&edital=${edital}&fornecedor=${anexo.fornecedor }','divbusca');" title="Alterar dados da Ata"><img src="/gecoi.3.0/img/editar_cinza.png" onclick="" width="22" height="22" /></a></td>
           			<td width="2%"><a href="#" onclick="excluirAnexo(${anexo.idConteudo }, ${idLicitacao}, '${numPregao}', '${numProcesso}', '${anexo.numAta }', '${edital}');" title="Exclusão da Ata"><img src="/gecoi.3.0/img/excluir_cinza.png" width="22" height="22" /></a></td>
        			</td>
      			</tr>
			</c:forEach>
     			</table> 
                <div id="anexo">   			
        			<a href="#" onclick="carregaPag('/gecoi.3.0/apps/registro_preco/seccon/incluir_ata.jsp?nProcesso=${numProcesso}&idLicitacao=${idLicitacao}&nPregao=${numPregao}&edital=${edital}','divbusca');">(+) Incluir Ata</a>
                </div>
        </div>
	</form>
    
<div id="botao">
<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
</div>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 