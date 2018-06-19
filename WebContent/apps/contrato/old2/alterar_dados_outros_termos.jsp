<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>
function criticaAditivo(pidLicitacao, pdescricao, pidConteudo, pnProcesso, pnPregao, pnContrato, pdataPublicacao)
{
	if (critica_altera_outros_termos(document.fdescAditivo))
	{
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_outros_termos.jsp", {idConteudo: document.fdescAditivo.idconteudo.value, 
																				idArquivo : document.fdescAditivo.idarquivo.value, 
																				descricao: document.fdescAditivo.termo.value, 
																				numProcesso: document.fdescAditivo.nProcesso.value, 
																				numContrato: document.fdescAditivo.nContrato.value,
																				ordem: document.fdescAditivo.ordem.value
																				},
				function(){
					carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + pidLicitacao + "&descricao=" + pdescricao + "&idConteudo=" + pidConteudo + "&nProcesso=" + pnProcesso + "&nPregao=" + pnPregao + "&nContrato=" + pnContrato + "&dataPublicacao=" + pdataPublicacao,"divbusca");
				});
	}
}

</script>
<%
String vnContrato = request.getParameter("nContrato");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");

String vidLicitacao = request.getParameter("idLicitacao");
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdescTermo = request.getParameter("descTermo");
String vdataPublicacao = request.getParameter("dataPublicacao");
int vordem = Integer.parseInt(request.getParameter("ordem"));
String vselecao = "";
out.print(vdescTermo);

%>
<h1>Altera&ccedil;&atilde;o dos dados do Termos</h1>
<form name="fdescAditivo" action="/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idConteudo=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="ordem" id="ordem" value="<%=vordem %>" />
<c:set var="descTermo" value="<%=vdescTermo %>" ></c:set>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Nº do Contrato:
        	<input type="text" name="nContrato" id="nContrato" value="<%=vnContrato %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>
        	Nº do Processo:
        	<input type="text" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
      	<td>Termo</td>
        <td>
       		<select name="termo" id="termo">
       			<option value="0">----</option>
       			<option value="Cancelamento do contrato <%=vnContrato %>">Cancelamento do contrato <%=vnContrato %></option>
       			<option value="Suspensão do contrato <%=vnContrato %>">Suspensão do contrato <%=vnContrato %></option>
       			<option value="Apostilamento do contrato <%=vnContrato %>">Apostilamento do contrato <%=vnContrato %></option>
       			<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
       			<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
       			<c:set var="outros" value="${lista.getListaOutrosTermos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
       			<c:forEach var="outro" items="${outros}" >
       				<option value="Apostilamento ao ${outro.descricao }" ${selecao }>Apostilamento ao ${outro.descricao }</option>
       			</c:forEach>
       		</select>        		
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=<%=vidLicitacao %>&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>&nContrato=<%=vnContrato %>&dataPublicacao=<%=vdataPublicacao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAditivo(<%=vidLicitacao %>, '<%=vdescricao %>', <%=vidConteudo %>, '<%=vnProcesso %>', '<%=vnPregao %>' , '<%=vnContrato %>' , '<%=vdataPublicacao %>');"  /> 
        </td>
      </tr>
  </table>
  <input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao%>"/>
  <input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
  <input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
