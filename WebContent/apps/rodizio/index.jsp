<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/includes/limpa_webtemp.jsp"%>
<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File, br.jus.trerj.funcoes.GravarArquivo;"%>
<script>
$(document).ready(function(){
		$( "#tabs" ).tabs();
		//$( document ).tooltip();  
		  $("input[name*='tamanho']").keypress(function (e) {
			     //if the letter is not digit then display error and don't type anything
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			        //display error message
			        $("#errmsg").html("Digits Only").show().fadeOut("slow");
			               return false;
			    }
			   });
		  $("input[name*='topo']").keypress(function (e) {
			     //if the letter is not digit then display error and don't type anything
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			        //display error message
			        $("#errmsg").html("Digits Only").show().fadeOut("slow");
			               return false;
			    }
			   });
		  $("input[name*='altura']").keypress(function (e) {
			     //if the letter is not digit then display error and don't type anything
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			        //display error message
			        $("#errmsg").html("Digits Only").show().fadeOut("slow");
			               return false;
			    }
			   });
	});

function critica(f)
{
	/*
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
		  $.post("/gecoi.3.0/apps/popup_metas/processa.jsp", {idConteudo: document.finternet.idconteudo.value, dataIni: document.finternet.dataIni.value, dataFim: document.finternet.dataFim.value, metas: document.finternet.metasEscolhidas.value }, function() {})
		  .done(function() {alert("A popup foi atualizada com sucesso.")});
	  }
	  else
	  {
	     alert("Ocorreram os seguintes erros:\n\n" + msg);
		 return false;
	  }*/
	  $.post("/gecoi.3.0/apps/rodizio/processa_banner.jsp", {titulo: f.tituloInternet.value, 
		  													texto: f.textoInternet.value, 
		  													tamanhoTitulo: f.tamanhoInternet1.value, 
		  													tamanhoTexto: f.tamanhoInternet2.value,
		  													topoTitulo: f.topoInternet1.value,
		  													topoTexto: f.topoInternet2.value,
		  													alturaTitulo: f.alturaInternet1.value,
		  													alturaTexto: f.alturaInternet2.value,
		  													local: "internet"
		  													}, function() {});	  
}

function critica2(f)
{
	  $.post("/gecoi.3.0/apps/rodizio/processa_banner.jsp", {titulo: f.tituloIntranet.value, 
		  													texto: f.textoIntranet.value, 
		  													tamanhoTitulo: f.tamanhoIntranet1.value, 
		  													tamanhoTexto: f.tamanhoIntranet2.value,
		  													topoTitulo: f.topoIntranet1.value,
		  													topoTexto: f.topoIntranet2.value,
		  													alturaTitulo: f.alturaIntranet1.value,
		  													alturaTexto: f.alturaIntranet2.value,
		  													local: "intranet"
		  													}, function() {});	  
}

function aumenta(campo)
{
	campo.value = parseInt(campo.value) + 1;
	atualizaTexto();
}

function diminui(campo)
{
	if (parseInt(campo.value) > 0)
	{
		campo.value = parseInt(campo.value) - 1;
		atualizaTexto();
	}
}

function aumenta2(campo)
{
	campo.value = parseInt(campo.value) + 1;
	atualizaTexto2();
}

function diminui2(campo)
{
	if (parseInt(campo.value) > 0)
	{
		campo.value = parseInt(campo.value) - 1;
		atualizaTexto2();
	}
}

function atualizaTexto()
{
	//$.post("/gecoi.3.0/apps/rodizio/atualiza_texto_internet.jsp", {dataFim: document.finternet.dataFim.value, metas: document.finternet.metasEscolhidas.value}, 
	//		function(resultado) {$("#divimagem").html(resultado);})
			// Teste para alterar o tamanho.  Será usado no Gecoi Rodizio 
			/*.done(function(){
							$("#divMetas2").css("margin-top", "25px");
							$("#divMetas2").css("margin-left", "40px");
							$("#divMetas2").css("margin-right", "40px");
							$("#divMetas2").css("text-align", "center");
							$("#divMetas2").css("font-weight", "bold");
							$("#divMetas2").css("line-height", "20px");
							$("#divMetas2").css("font-size", document.finternet.tamanho.value + "px");
							$("#divMetas2").html("ZE 999 voc&ecirc; ainda n&atilde;o enviou todos os dados.  Assim que envi&aacute;-los essa janela n&atilde;o ir&aacute; mais aparecer.");})
			*/
	//		;

	$("#divTituloInternet").css("margin-top", document.finternet.topoInternet1.value + "px");
	$("#divTituloInternet").css("line-height", document.finternet.alturaInternet1.value + "px");
	$("#divTituloInternet").css("font-size", document.finternet.tamanhoInternet1.value + "px");
	$("#divTituloInternet").html(document.finternet.tituloInternet.value);
	
	$("#divTextoInternet").css("margin-top", document.finternet.topoInternet2.value + "px");
	$("#divTextoInternet").css("line-height", document.finternet.alturaInternet2.value + "px");
	$("#divTextoInternet").css("font-size", document.finternet.tamanhoInternet2.value + "px");
	$("#divTextoInternet").html(document.finternet.textoInternet.value);
	
	//$("#divTituloInternet").css("border", "dotted");
	//$("#divTextoInternet").css("border", "dotted");
	
}

function atualizaTexto2()
{
	$("#divTituloIntranet").css("margin-top", document.fintranet.topoIntranet1.value + "px");
	$("#divTituloIntranet").css("line-height", document.fintranet.alturaIntranet1.value + "px");
	$("#divTituloIntranet").css("font-size", document.fintranet.tamanhoIntranet1.value + "px");
	$("#divTituloIntranet").html(document.fintranet.tituloIntranet.value);
	
	$("#divTextoIntranet").css("margin-top", document.fintranet.topoIntranet2.value + "px");
	$("#divTextoIntranet").css("line-height", document.fintranet.alturaIntranet2.value + "px");
	$("#divTextoIntranet").css("font-size", document.fintranet.tamanhoIntranet2.value + "px");
	$("#divTextoIntranet").html(document.fintranet.textoIntranet.value);
	
	//$("#divTituloIntranet").css("border", "dotted");
	//$("#divTextoIntranet").css("border", "dotted");
	
}
</script>

<%

// usado para copiar do gecoi
String vdiretorio = application.getRealPath("/") + "webtemp";
GravarArquivo gravarArquivo = new GravarArquivo();

String vidArquivo = "54191"; //desenv
//String vidArquivo = ""; //producao
String vnome = gravarArquivo.gravar(vidArquivo, vdiretorio, session.getAttribute("login").toString());
String vimagemInternet = "/gecoi.3.0/webtemp/" + vnome;
///gecoi.3.0/apps/rodizio/img/magistrados_vazio_inter.gif

vidArquivo = "54192"; //desenv
//vidArquivo = ""; //producao
vnome = gravarArquivo.gravar(vidArquivo, vdiretorio, session.getAttribute("login").toString());
String vimagemIntranet = "/gecoi.3.0/webtemp/" + vnome;
///gecoi.3.0/apps/rodizio/img/magistrados_vazio_intra.gif

%>
<style>
#divimagemInternet {background-image:url("<%=vimagemInternet%>");
			background-repeat:no-repeat;
			position:absolute;
			width:247px;
			height:57px;
			z-index:1;
			left: 449px;
			top: 200px;
			}
	
#divTituloInternet{
	margin-top:1px;
	margin-left:55px;
	margin-right:5px;
	text-align:center;
	font-size:13px;
	font-weight:bold;
	font-family:Arial, Helvetica, sans-serif;
	line-height:15px;
	padding:0px;
}

#divTextoInternet{
	padding:0px;
	margin-top:0px;
	margin-left:55px;
	margin-right:5px;
	text-align:center;
	font-weight:bold;
	line-height: 30px;
	font-size: 13px;
}

#divimagemIntranet {background-image:url("<%=vimagemIntranet%>");
			background-repeat:no-repeat;
			position:absolute;
			width:308px;
			height:188px;
			z-index:1;
			left: 449px;
			top: 200px;
			}
	
#divTituloIntranet{
	margin-top:45px;
	margin-left:87px;
	margin-right:5px;
	text-align:center;
	font-size:15px;
	font-weight:bold;
	font-family:Arial, Helvetica, sans-serif;
	line-height:30px;
	padding:0px;
}

#divTextoIntranet{
	padding:0px;
	margin-top:0px;
	margin-left:87px;
	margin-right:5px;
	text-align:center;
	font-weight:bold;
	line-height: 30px;
	font-size: 15px;
}
</style>

<div id='tabs'>
	<ul>
		<li tabindex='1'><a href='#tabs-1' onclick="">Banner Internet</a></li>
		<li tabindex='2'><a href='#tabs-2' onclick="">Banner Intranet</a></li>
	</ul>
	<div id='tabs-1'>
		<h1>Banner da Internet</h1>
		<form name="finternet" action="" method="post"  >
			Título 1
        	<input type="text" name="tituloInternet" id="tituloInternet" value="RODÍZIO DE MAGISTRADOS" onchange="atualizaTexto();" /><br>
        	Tamanho
        	<input type="text" name="tamanhoInternet1" id="tamanhoInternet1" value="13" /><a href="#" onclick="aumenta(document.finternet.tamanhoInternet1)">+</a><a href="#" onclick="diminui(document.finternet.tamanhoInternet1)">-</a><br>
        	Topo
        	<input type="text" name="topoInternet1" id="topoInternet1" value="1" /><a href="#" onclick="aumenta(document.finternet.topoInternet1)">+</a><a href="#" onclick="diminui(document.finternet.topoInternet1)">-</a><br>
        	Altura
        	<input type="text" name="alturaInternet1" id="alturaInternet1" value="15" /><a href="#" onclick="aumenta(document.finternet.alturaInternet1)">+</a><a href="#" onclick="diminui(document.finternet.alturaInternet1)">-</a><br>
			<br>
			Título 2
        	<input type="text" name="textoInternet" id="textoInternet" value="Lista de Designados atualizado em 05/04/2016" onchange="atualizaTexto();" /><br>
        	Tamanho
        	<input type="text" name="tamanhoInternet2" id="tamanhoInternet2" value="13" /><a href="#" onclick="aumenta(document.finternet.tamanhoInternet2)">+</a><a href="#" onclick="diminui(document.finternet.tamanhoInternet2)">-</a><br>
        	Topo
        	<input type="text" name="topoInternet2" id="topoInternet2" value="0" /><a href="#" onclick="aumenta(document.finternet.topoInternet2)">+</a><a href="#" onclick="diminui(document.finternet.topoInternet2)">-</a><br>
        	Altura
        	<input type="text" name="alturaInternet2" id="alturaInternet2" value="12" /><a href="#" onclick="aumenta(document.finternet.alturaInternet2)">+</a><a href="#" onclick="diminui(document.finternet.alturaInternet2)">-</a><br>
			<br>
			<div id="divimagemInternet">
				<div id="divTituloInternet" >Titulo1</div>
				<div id="divTextoInternet" >Titulo2</div>
			</div>
			<input type="button" name="atualiza" id="atualiza" value="Atualizar Banner" onClick="atualizaTexto();" />
			<input type="button" name="grava" id="grava" value="Gravar dados" onClick="critica(document.finternet);" />
  		</form>
  	</div>
  	<div id='tabs-2'>
  		<h1>Banner da Intranet</h1>
		<form name="fintranet" action="" method="post"  >
			Título 1
        	<input type="text" name="tituloIntranet" id="tituloIntranet" value="RODÍZIO DE MAGISTRADOS" onchange="atualizaTexto2();" /><br>
        	Tamanho
        	<input type="text"  name="tamanhoIntranet1" id="tamanhoIntranet1" value="15" /><a href="#" onclick="aumenta2(document.fintranet.tamanhoIntranet1)">+</a><a href="#" onclick="diminui2(document.fintranet.tamanhoIntranet1)">-</a><br>
        	Topo
        	<input type="text" name="topoIntranet1" id="topoIntranet1" value="45" /><a href="#" onclick="aumenta2(document.fintranet.topoIntranet1)">+</a><a href="#" onclick="diminui2(document.fintranet.topoIntranet1)">-</a><br>
        	Altura
        	<input type="text" name="alturaIntranet1" id="alturaIntranet1" value="30" /><a href="#" onclick="aumenta2(document.fintranet.alturaIntranet1)">+</a><a href="#" onclick="diminui2(document.fintranet.alturaIntranet1)">-</a><br>
			<br>
			Título 2
        	<input type="text" name="textoIntranet" id="textoIntranet" value="Lista de Designados atualizado em 05/04/2016" onchange="atualizaTexto2();" /><br>
        	Tamanho
        	<input type="text" name="tamanhoIntranet2" id="tamanhoIntranet2" value="15" /><a href="#" onclick="aumenta2(document.fintranet.tamanhoIntranet2)">+</a><a href="#" onclick="diminui2(document.fintranet.tamanhoIntranet2)">-</a><br>
        	Topo
        	<input type="text" name="topoIntranet2" id="topoIntranet2" value="0" /><a href="#" onclick="aumenta2(document.fintranet.topoIntranet2)">+</a><a href="#" onclick="diminui2(document.fintranet.topoIntranet2)">-</a><br>
        	Altura
        	<input type="text" name="alturaIntranet2" id="alturaIntranet2" value="30" /><a href="#" onclick="aumenta2(document.fintranet.alturaIntranet2)">+</a><a href="#" onclick="diminui2(document.fintranet.alturaIntranet2)">-</a><br>
			<br>
			<div id="divimagemIntranet">
				<div id="divTituloIntranet" >Titulo1</div>
				<div id="divTextoIntranet" >Titulo2</div>
			</div>
			<input type="button" name="atualiza" id="atualiza" value="Atualizar Banner" onClick="atualizaTexto2();" />
			<input type="button" name="grava" id="grava" value="Gravar dados" onClick="critica2(document.fintranet);" />
  		</form>  	
  	</div>
</div>