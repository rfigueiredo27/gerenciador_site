<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
   
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
   
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<script>

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=" + document.fincAnexo.idLicitacao.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + 
				"&nPregao=" + document.fincAnexo.numPregao.value + "&descricao=" + document.fincAnexo.descricaoContrato.value + "&idConteudo=" + document.fincAnexo.idConteudo.value + 
				"&nContrato=" + document.fincAnexo.nContrato.value + "&dataPublicacao="  + document.fincAnexo.dataPublicacao.value, "divbusca");
	
}


function criticaAnexo()
{
	critica_inclusao_outros_termos(document.fincAnexo);
}


</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
String vcontrato = request.getParameter("nContrato");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("dataPublicacao");
String[] voutros = request.getParameter("outros").split("_");

%>
<h1>Inclus&atilde;o de Outros Termos</h1>
<form name="fincAnexo" action="/gecoi.3.0/IncluirOutrosTermos" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idConteudo" id="idConteudo" value="<%=vidConteudo%>"/>
<c:set var="idLicitacao" value="<%=vidLicitacao %>" />

<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
<c:set var="idConteudo" value="<%=vidConteudo %>" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>N�mero do Processo:</td>
        <td>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso %>" readonly="readonly" />
        </td>
      </tr>
	 <tr><td>Contrato</td>
        <td>
        	<input type="text" name="contrato" id="contrato" value="<%=vcontrato %>" readonly="readonly" />
        </td>
      </tr>
      <tr>
      	<td>Termo</td>
        <td>
       		<select name="descricao" id="descricao">
       			<option value="0">----</option>
       			<option value="Cancelamento do contrato <%=vcontrato %>">Cancelamento do contrato <%=vcontrato %></option>
       			<option value="Suspens�o do contrato <%=vcontrato %>">Suspens�o do contrato <%=vcontrato %></option>
       			<option value="Apostilamento do contrato <%=vcontrato %>">Apostilamento do contrato <%=vcontrato %></option>
       			<%
       			for (int i = 1; i < voutros.length; i++)
       			{
       				out.print("<option value='Apostilamento ao " + voutros[i] + "'>Apostilamento ao " + voutros[i] + "</option>");
       			}
       			%>
       		</select>        		
        </td>
      <tr>
        <td>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
        	<input type="button" name="cancelar" value="Cancelar" onclick="parent.atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
        </td>
      </tr>
  </table>
  <input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao %>" />
  <input type="hidden" name="descricaoContrato" id="descricaoContrato" value="<%=vdescricao %>" />
  <input type="hidden" name="nContrato" id="nContrato" value="<%=vcontrato %>" />
  <input type="hidden" name="dataPublicacao" id="dataPublicacao" value="<%=vdataPublicacao %>" />
  <input type="hidden" name="numPregao" id="numPregao" value="<%=vnumPregao %>" />
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
