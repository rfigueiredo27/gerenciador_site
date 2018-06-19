<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>
function atualizaTela(f)
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo_sem_licitacao.jsp?descricao=" + f.descricao.value + "&idConteudo=" + f.idConteudo.value + "&nProcesso=" + f.nProcesso.value + "&nContrato=" + f.nContrato.value + "&dataPublicacao=" + f.dataPublicacao.value + "&idArea=" + f.idArea.value, "divbusca2");
}

function criticaAditivo(f)
{
	if (critica_altera_outros_termos_sem_licitacao(f))
	{
		$.post("/gecoi.3.0/apps/contrato/processa_alteracao_dados_outros_termos_sem_licitacao.jsp", {idConteudo: f.idConteudo.value, 
																				idArquivo : f.idArquivo.value, 
																				descricao: f.termo.value, 
																				numProcesso: f.nProcesso.value, 
																				numContrato: f.nContrato.value,
																				ordem: f.ordem.value
																				},
				function(){
							atualizaTela(f);
				});
	}
}

</script>
<%
String vnContrato = request.getParameter("nContrato");
String vnProcesso = request.getParameter("nProcesso");

String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdescTermo = request.getParameter("descTermo");
String vdataPublicacao = request.getParameter("dataPublicacao");
String vidArea = request.getParameter("idArea");
int vordem = Integer.parseInt(request.getParameter("ordem"));

%>
<h1>Altera&ccedil;&atilde;o dos dados do termo</h1>
<form name="fdescAditivo" action=""> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="ordem" id="ordem" value="<%=vordem %>" />
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
       				<option value="Apostilamento ao ${outro.descricao }" >Apostilamento ao ${outro.descricao }</option>
       			</c:forEach>
       		</select>        		
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela(this.form);" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAditivo(this.form);"  /> 
        </td>
      </tr>
  </table>
  <input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao%>"/>
  <input type="hidden" name="idArea" id="idArea" value="<%=vidArea%>"/>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
