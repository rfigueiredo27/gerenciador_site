<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<script>
$(document).ready(function(){
});


function criticaAnexo()
{
	//if (critica_altera_registro(document.fReferencia))
	//{
		$.post("/gecoi.3.0/apps/global/processa_alteracao_referencia.jsp", {idConteudo: document.fReferencia.idconteudo.value, 
																					idArquivo : document.fReferencia.idarquivo.value, 
																					idReferencia : document.fReferencia.idReferencia.value,
																					idReferenciaAnterior : document.fReferencia.idReferenciaAnterior.value
																					},
				function(){
					//carregaPag("/gecoi.3.0/apps/registro_preco/seccon/lista_registro.jsp?idLicitacao=" + pLicitacao + "&nPregao=" + pnPregao + "&nProcesso=" + pnProcesso,"divbusca");
					parent.listarContrato();
				});
	//}
}

function listarReferencia(f)
{
	document.getElementById("divbuscaReferencia").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/global/lista_referencia.jsp", { vtexto: f.textoReferencia.value, vano: f.anoReferencia.value }, function(resposta) {$("#divbuscaReferencia").html(resposta);});
}

</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdescricaoContrato = request.getParameter("descricaoContrato");
String vnProcesso = request.getParameter("nProcesso");
String vnPregao = request.getParameter("nPregao");
String vidReferencia = request.getParameter("idReferencia");
String vidReferenciaAnterior = request.getParameter("idReferencia");
%>
<h1>Altera&ccedil;&atilde;o da refer&ecirc;ncia do contrato</h1>
<form name="fReferencia" action="" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idReferencia" id="idReferencia" value="<%=vidReferencia%>"/>
<input type="hidden" name="idReferenciaAnterior" id="idReferenciaAnterior" value="<%=vidReferenciaAnterior%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	Descrição <br>
        	<a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=<%=vidConteudo %>&idArquivo=<%=vidArquivo %>" target="_blank"> <%=vdescricaoContrato %> </a>
        </td>
      </tr>
      <tr>
        <td>
        	Nº do Processo: <div id="divnumProcesso"><%=vnProcesso %></div>
        </td>
      </tr>
	  <tr>
	  	<td>
	  		Número do Pregão: <div id="divnumPregao"><%=vnPregao %></div>
	  	</td>
	  </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="parent.listarContrato();" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  /> 
        </td>
      </tr>
  </table>
  <jsp:useBean id="listaReferencia" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
  <c:set var="anosReferencia" value="${listaReferencia.getAnos(sessionScope['login'], sessionScope['senha'])}" />
  <form name="fbuscaReferencia" method="post" target="divBuscaReferencia" >
			<p>Selecione o ano da licitação:</p>
			<select name="anoReferencia">
        		<option>-----------</option>
        		<c:forEach var="anoReferencia" items="${anosReferencia}">
        			<option value="${anoReferencia}">${anoReferencia}</option>
        		</c:forEach>
        	</select>
           
        	<p>Palavra Chave</p>
        	<input name="textoReferencia" type="text" size="35" maxlength="150" />
        	<input type="button" name="buscarReferencia" id="buscarReferencia" value="buscar" onclick="listarReferencia(this.form);" />
  </form>
  <div id="divbuscaReferencia"></div>
</form>
