<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File, br.jus.trerj.funcoes.GravarArquivo;"%>
<script>
$(document).ready(function(){
		$( "#dataIni" ).datepicker();
		$( "#dataFim" ).datepicker();
		//$( document ).tooltip();  
	});

function critica(f)
{
	  var msg = "";
	  if (!EhData(f.dataIni.value))
	  {
	     msg = msg + "- A VIGÊNCIA não é válida.\n";
	  }
	  if (!EhData(f.dataFim.value))
	  {
	     msg = msg + "- A VIGÊNCIA não é válida.\n";
	  }
	  if (msg.replace(/^\s*|\s*$/g,"")=="")
	  {
		  $.post("/gecoi.3.0/apps/popup_metas/processa.jsp", {idConteudo: document.fpopup.idconteudo.value, dataIni: document.fpopup.dataIni.value, dataFim: document.fpopup.dataFim.value, metas: document.fpopup.metasEscolhidas.value }, function() {})
		  .done(function() {alert("A popup foi atualizada com sucesso.")});
	  }
	  else
	  {
	     alert("Ocorreram os seguintes erros:\n\n" + msg);
		 return false;
	  }
}

function escolheMeta(meta)
{
	if (meta.checked)
	{
		if (document.fpopup.metasEscolhidas.value == "")
		{
			document.fpopup.metasEscolhidas.value = meta.value;
		}
		else
		{
			document.fpopup.metasEscolhidas.value = document.fpopup.metasEscolhidas.value + "," + meta.value;
		}
	}
	else
	{
		var aMetas = document.fpopup.metasEscolhidas.value.split(",");
		document.fpopup.metasEscolhidas.value = "";
		for (i = 0; i < aMetas.length; i++)
		{
			if (aMetas[i] != meta.value)
			{
				if (document.fpopup.metasEscolhidas.value == "")
				{
					document.fpopup.metasEscolhidas.value = aMetas[i];
				}
				else
				{
					document.fpopup.metasEscolhidas.value = document.fpopup.metasEscolhidas.value + "," + aMetas[i];
				}
			}
		}
	}
	
	atualizaTexto();
}

function atualizaTexto()
{
	$.post("/gecoi.3.0/apps/popup_metas/atualiza_texto.jsp", {dataFim: document.fpopup.dataFim.value, metas: document.fpopup.metasEscolhidas.value, ano: document.fpopup.ano.value, mesExt: document.fpopup.mesExt.value}, 
			function(resultado) {$("#divimagem").html(resultado);})
			// Teste para alterar o tamanho.  Será usado no Gecoi Rodizio 
			/*.done(function(){
							$("#divMetas2").css("margin-top", "25px");
							$("#divMetas2").css("margin-left", "40px");
							$("#divMetas2").css("margin-right", "40px");
							$("#divMetas2").css("text-align", "center");
							$("#divMetas2").css("font-weight", "bold");
							$("#divMetas2").css("line-height", "20px");
							$("#divMetas2").css("font-size", document.fpopup.tamanho.value + "px");
							$("#divMetas2").html("ZE 999 voc&ecirc; ainda n&atilde;o enviou todos os dados.  Assim que envi&aacute;-los essa janela n&atilde;o ir&aacute; mais aparecer.");})
			*/
			;
	
	
}

</script>

<%
String vdiretorio = application.getRealPath("/") + "webtemp";
//String vidArquivo = "53956"; //desenv
String vidArquivo = "96140"; //producao
GravarArquivo gravarArquivo = new GravarArquivo();
String vnome = gravarArquivo.gravar(vidArquivo, vdiretorio, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
String vimagem = "/gecoi.3.0/webtemp/" + vnome;
%>
<style>
#divimagem {background-image:url("<%=vimagem %>");
			background-repeat:no-repeat;
			position:absolute;
			width:450px;
			height:347px;
			z-index:1;
			left: 449px;
			top: 272px;
			}
	
#divMetas1 p{
	margin-top:130px;
	margin-left:10px;
	margin-right:10px;
	text-align:center;
	font-size:24px;
	font-family:Arial, Helvetica, sans-serif;
	line-height:35px;
}

#divMetas2 p{
	margin-top:25px;
	margin-left:40px;
	margin-right:40px;
	text-align:center;
	font-weight:bold;
	line-height: 20px;
	font-size: 16px;
}

</style>

<jsp:useBean id="lista" class="br.jus.trerj.controle.popup_metas.Lista" />
<c:set var="popup" value="${lista.getListaPopup(sessionScope['login'], sessionScope['senha'])}" />
	<form name="fpopup" action="" method="post"  >
		<input type="hidden" name="idconteudo" id="idconteudo" value="${popup.idConteudo }" />
		<!-- <input type="hidden" name="nomeArquivo" id="nomeArquivo" value="${popup.nomeArquivo }" />
		<c:set var="idConteudo" value="${popup.idConteudo }" scope="page"/>
		<c:set var="teste" value="${popup.idArquivo }" scope="session" />-->
		Data Inicial: <input title="Data inicial" alt="Data inicial" type="text" name="dataIni" id="dataIni" size="10" maxlength="10" value="${popup.dataIni}" onchange="atualizaTexto();" />
		Data Final: <input title="Data final" alt="Data final" type="text" name="dataFim" id="dataFim" size="10" maxlength="10" value="${popup.dataFim}" onchange="atualizaTexto();" />
		<!-- Input de teste para alterar o tamanho.  Será usado no Gecoi Rodizio -->
        <!-- <input type="text" name="tamanho" id="tamanho" value="16" />  -->
		<br>
		Metas: <input type="checkbox" value="999" checked="checked" onclick="escolheMeta(this);" />Produtividade dos Magistrados
		<c:set var="items" value="${lista.getMetas(sessionScope['login'], sessionScope['senha'])}" />
		<c:set var="conta" value="0"/>
		<c:choose>
			<c:when test="${!empty items}">
				<c:forEach var="metas" items="${items}" >
					<c:set var="conta" value="${conta + 1 }"/>
					<input type="checkbox" value="${metas }" onclick="escolheMeta(this);" />Meta ${metas }  
					<c:if test="${conta > 10 }">
						<br>
						<c:set var="conta" value="0"/>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:out value="Não tem registros" />
			</c:otherwise>
		</c:choose>
		<br>
		<div id="divimagem">
			<div id="divMetas1" ><p>Dia <bold>${popup.dataFim}</bold> &eacute; o &uacute;ltimo dia para responder a produtividade dos magistrados de ${popup.mesExt} de ${popup.ano}!</p></div>
			<div id="divMetas2" ><p>ZE 000 voc&ecirc; ainda n&atilde;o enviou todos os dados.  Assim que envi&aacute;-los essa janela n&atilde;o ir&aacute; mais aparecer.</p></div>
		</div>
		<input type="hidden" name="metasEscolhidas" id="metasEscolhidas" value="999"/>
		<input type="hidden" name="ano" id="ano" value="${popup.ano}"/>
		<input type="hidden" name="mesExt" id="mesExt" value="${popup.mesExt}"/>
		<input type="button" name="grava" id="grava" value="Gravar dados" onClick="critica(document.fpopup);" />
  	</form>
