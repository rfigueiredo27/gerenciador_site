<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<script>
$(document).ready(function(){
});


function criticaAnexo(pidArquivo)
{
	//if (critica_altera_registro(document.fReferencia))
	//{
		$.post("/gecoi.3.0/apps/global/processa_alteracao_referencia.jsp", {idConteudo: document.fReferencia.idconteudo.value, 
																					idArquivo : document.fReferencia.idarquivo.value, 
																					idReferencia :  pidArquivo,
																					idReferenciaAnterior : document.fReferencia.idReferenciaAnterior.value,
																					origem : "contrato"
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
	$.post("/gecoi.3.0/apps/global/lista_referencia.jsp", { vtexto: f.textoReferencia.value, vano: f.anoReferencia.value }, function(resposta) {$("#divbuscaReferencia").html(resposta);zera_contador();});
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
<div id="altera_referencia">
<fieldset>
	<legend>Altera&ccedil;&atilde;o da refer&ecirc;ncia do contrato</legend>
    <div id="numero_referencia">
    	<div id="descricao_referencia">
    		<p>Descri&ccedil;&atilde;o:<strong> <a href="/gecoi.3.0/apps/global/visualizar_arquivo.jsp?idConteudo=<%=vidConteudo %>&idArquivo=<%=vidArquivo %>" target="_blank"><%=vdescricaoContrato %></a></strong></p>
    	</div>
    	<div id="numero_processo">
        	<p>N&uacute;mero do processo: <br /><strong><%=vnProcesso%></strong></p>
		</div>
		<div id="numero_pregao">
        	<p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnPregao%></strong></p>
		</div>
	</div>
<form name="fReferencia" action="" method="post"> 
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idReferencia" id="idReferencia" value="<%=vidReferencia%>"/>
<input type="hidden" name="idReferenciaAnterior" id="idReferenciaAnterior" value="<%=vidReferenciaAnterior%>"/>
           
           <!--<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />-->
  <jsp:useBean id="listaReferencia" class="br.jus.trerj.controle.licitacao.ListaLicitacao"/>
  <c:set var="anosReferencia" value="${listaReferencia.getAnos(sessionScope['login'], sessionScope['senha'])}" />
  <form name="fbuscaReferencia" method="post" target="divBuscaReferencia" >
  		<div id="ano">
  			<fieldset>
        		<legend>Selecione o ano da licitação</legend>
				<select name="anoReferencia">
        			<option>-----------</option>
        			<c:forEach var="anoReferencia" items="${anosReferencia}">
        			<option value="${anoReferencia}">${anoReferencia}</option>
        			</c:forEach>
        		</select>
            </fieldset>
    	</div>
        <div id="palavra">
        	<fieldset>
        		<legend>Palavra Chave</legend>
        		<input name="textoReferencia" type="text" size="35" maxlength="150" />
            </fieldset>
    	</div>
        <div id="botao"> 
            <input type="button" name="cancelar" value="Cancelar" onclick="parent.listarContrato();" />
        	<input type="button" name="buscarReferencia" id="buscarReferencia" value="buscar" onclick="listarReferencia(this.form);" />
        </div>
  </form>
  
  <div id="divbuscaReferencia"></div>
</form>
</fieldset>
</div>

