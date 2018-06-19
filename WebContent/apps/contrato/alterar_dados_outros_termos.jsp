<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList;"%>

<script>
$(document).ready(function(){
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
});

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

%>

<div id="altera_arquivo">
	<fieldset>
		<legend>Altera&ccedil;&atilde;o dos dados do Termos</legend>
<form name="fdescAditivo" action="/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idConteudo=<%=vidConteudo %>" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="ordem" id="ordem" value="<%=vordem %>" />
<input type="hidden" name="nContrato" id="nContrato" value="<%=vnContrato %>"/>
<input type="hidden" name="nProcesso" id="nProcesso" value="<%=vnProcesso %>"/>

<c:set var="descTermo" value="<%=vdescTermo %>" ></c:set>
		<div id="numero">
            <div id="numero_pregao">
     				<p>N&uacute;mero Contrato: <br /><strong><%=vnContrato%></strong></p>
				</div>
				<div id="numero_processo">
        			<p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
				</div>
            </div>
            <div id="vigencia_aditivo">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <div id="outros_termos">
    		<fieldset>
                <legend>Termo</legend>
       			<select name="termo" id="termo">
       				<option value="0">----</option>
               		 <%
						vselecao = "";
						if (vdescTermo.equals("Cancelamento do contrato " + vnContrato))
						vselecao = "selected='selected'";
					%>
       					<option <%=vselecao%> value="Cancelamento do contrato <%=vnContrato %>">Cancelamento do contrato <%=vnContrato %></option>
               		<%
						vselecao = "";
						if (vdescTermo.equals("Suspensão do contrato " + vnContrato))
						vselecao = "selected='selected'";
					%>
       					<option <%=vselecao%> value="Suspensão do contrato <%=vnContrato %>">Suspensão do contrato <%=vnContrato %></option>
               		<%
						vselecao = "";
						if (vdescTermo.equals("Apostilamento do contrato " + vnContrato))
						vselecao = "selected='selected'";
					%>
       					<option <%=vselecao%> value="Apostilamento do contrato <%=vnContrato %>">Apostilamento do contrato <%=vnContrato %></option>
       				<c:set var="idConteudo" value="<%=vidConteudo %>" scope="page" />
       					<jsp:useBean id="lista" class="br.jus.trerj.controle.contrato.ListaContratos" />
       					<c:set var="outros" value="${lista.getListaOutrosTermos(idConteudo, sessionScope['login'], sessionScope['senha'])}" />
       					<c:forEach var="outro" items="${outros}" >
       						<c:set var="selecao" value=""></c:set>
       						<c:set var="atual" value="Apostilamento ao ${outro.descricao}"></c:set>
       						<c:if test="${ descTermo == atual}" >
       							<c:set var="selecao" value="selected='selected'"></c:set>
       				</c:if>
       				<option ${selecao} value="Apostilamento ao ${outro.descricao }">Apostilamento ao ${outro.descricao }</option>
       			</c:forEach>
       		</select> 
            </fieldset>
     </div>       		
          <div id="botao">
           <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/contrato/lista_aditivo.jsp?idLicitacao=<%=vidLicitacao %>&descricao=<%=vdescricao %>&idConteudo=<%=vidConteudo %>&nProcesso=<%=vnProcesso %>&nPregao=<%=vnPregao %>&nContrato=<%=vnContrato %>&dataPublicacao=<%=vdataPublicacao %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAditivo(<%=vidLicitacao %>, '<%=vdescricao %>', <%=vidConteudo %>, '<%=vnProcesso %>', '<%=vnPregao %>' , '<%=vnContrato %>' , '<%=vdataPublicacao %>');"  /> 

         </div>
         
  <input type="hidden" name="idLicitacao" id="idLicitacao" value="<%=vidLicitacao%>"/>
  <input type="hidden" name="nPregao" id="nPregao" value="<%=vnPregao%>"/>
  <input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 