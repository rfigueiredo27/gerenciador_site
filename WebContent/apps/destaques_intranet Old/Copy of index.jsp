<%@include file="/includes/limpa_webtemp.jsp"%>
<%
//String vimagem = (request.getParameter("imagem") == null) ? "/gecoi.3.0/img/adicionar.png" : ("/gecoi.3.0/webtemp/" + request.getParameter("imagem"));
String vimagem = "/gecoi.3.0/img/adicionar.png";

%>

	<!-- usado no destaques_intranet -->
	<script type="text/javascript" src="/gecoi.3.0/destaques_intranet/scripts/critica_destaque.js"></script>
     

<script>

function preview(img, selection)
{
	/*
		check if selection are made
	*/
	if (!selection.width || !selection.height)
		return;
	
	/*
		setting scaling variable
	*/
	var scaleX = 100 / selection.width;
	var scaleY = 100 / selection.height;
	
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	$('#w').val(selection.width);
	$('#h').val(selection.height);    
}


$(document).ready(function(){
	$( "#tabs" ).tabs();  	
	$("#dataIni").datepicker();
	$("#dataFim").datepicker();
	  $("#publicado").keypress(function (e) {
		     //if the letter is not digit then display error and don't type anything
		     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
		        //display error message
		        $("#errmsg").html("Digits Only").show().fadeOut("slow");
		               return false;
		    }
		   });
});

function habilitaSelecaoFotoInicial()
{
	//$('#foto').imgAreaSelect({resizable: false, handles: false,  maxWidth: 307, maxHeight: 186,  minWidth: 307, minHeight: 186, onSelectChange: preview });
	var ias = $('#foto').imgAreaSelect({ instance: true });
	//ias.setSelection(parseInt(document.fdestaque.x1.value), parseInt(document.fdestaque.y1.value), parseInt(document.fdestaque.x1.value) + parseInt(document.fdestaque.w.value), parseInt(document.fdestaque.y1.value) + parseInt(document.fdestaque.h.value), true);
	ias.setOptions({resizable: false, handles: false,  maxWidth: 307, maxHeight: 186,  minWidth: 307, minHeight: 186, onSelectChange: preview});
	ias.update();
}

function habilitaSelecaoFoto()
{
	
	if (document.getElementById("nomeArquivo").value != "")
	{
		var ias = $('#foto').imgAreaSelect({ instance: true });
		ias.setSelection(parseInt(document.fdestaque.x1.value), parseInt(document.fdestaque.y1.value), parseInt(document.fdestaque.x1.value) + parseInt(document.fdestaque.w.value), parseInt(document.fdestaque.y1.value) + parseInt(document.fdestaque.h.value), true);
		ias.setOptions({show: true,  resizable: false, handles: false,  maxWidth: 307, maxHeight: 186,  minWidth: 307, minHeight: 186, onSelectChange: preview});
		ias.update();
	}
}

function desabilitaSelecaoFoto()
{
	if (document.getElementById("nomeArquivo").value != "")
		$('#foto').imgAreaSelect({ hide: true });
}

function carregaFoto()
{	
	var nome = document.getElementById("arquivo").files[0];
	var oFReader = new FileReader();
    
    oFReader.readAsDataURL(document.getElementById("arquivo").files[0]);
    
    oFReader.onload = function (oFREvent) {
        document.getElementById("foto").src = oFREvent.target.result;
    };

    document.getElementById("nomeArquivo").value = document.getElementById("arquivo").value;
    document.getElementById("divbotaofoto").innerHTML = "<img id='excluir_foto' name='excluir_foto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirFoto();' /><img id='incluir_foto' name='incluir_foto' src='/gecoi.3.0/img/botao_incluir.png' onclick='desabilitaSelecaoFoto();habilitaSelecaoFotoInicial();$(\"#arquivo\").click();' />";    
    habilitaSelecaoFotoInicial();
}


function abreFoto()
{
	if (document.getElementById("nomeArquivo").value == "")
		$("#arquivo").click();	
}
function excluirFoto()
{
	$('#foto').imgAreaSelect({ hide: true, disable: true });
	document.getElementById("divfoto").innerHTML = "<img name='foto' id='foto'  src='<%=vimagem %>' onclick='habilitaSelecaoFotoInicial();abreFoto();' />";
	document.getElementById("nomeArquivo").value = "";
	document.getElementById("divbotaofoto").innerHTML = "";
	document.getElementById("x1").value = "-";
	document.getElementById("y1").value = "-";
	document.getElementById("w").value = "-";
	document.getElementById("h").value = "-";
	document.getElementById("nomeArquivo").value = "";
}

function listar()
{
	document.getElementById("divbusca").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/destaques_intranet/lista_destaque.jsp", { vtexto: document.fbusca.descricao.value, vativo: document.fbusca.ativos.value }, function(resposta) {$("#divbusca").html(resposta);});
}

function listaSimples()
{
	$.post("/gecoi.3.0/apps/destaques_intranet/lista_destaque_simples.jsp", function(resposta) {$("#divListaSimples").html(resposta);});
}

</script>
<div id='tabs'>
   <ul>
      <li tabindex='1'><a href='#tabs-1' onclick="habilitaSelecaoFoto();listaSimples();" >Incluir novo</a></li>
      <li tabindex='2'><a href='#tabs-2' onclick="desabilitaSelecaoFoto();">Banners cadastrados</a></li>
   </ul>
   <div id='tabs-1'>
   		<form name="fdestaque" action="/gecoi.3.0/GravaNovoDestaque" method="post"  target="processa_background" enctype="multipart/form-data">
        	Descri&ccedil;&atilde;o<br>
            <input name="descricao" id="descricao" type="text" maxlength="1000" /><br>
        	Link (opcional)<br>
            Digite: <input name="link" id="link" type="text" maxlength="1000" /> OU<br>
            Escolha um anexo: <input type="text" name="descricaoAnexo" id="descricaoAnexo" /><input type="file" name="anexo" id="anexo" /><br>
        	Data in&iacute;cio da publica&ccedil;&atilde;o<br>
            <input name="dataIni" id="dataIni" type="text" maxlength="10" /><br>
        	Data fim da publica&ccedil;&atilde;o<br>
            <input name="dataFim" id="dataFim" type="text" maxlength="10" /><br>
        	Ordem<br>        	
            <input name="publicado" id="publicado" type="text" maxlength="1" value="1" /><br>
            <div id="divListaSimples"></div>
            <br>
            Banner<br>
            <div id="divfoto" > <img name="foto" id="foto"  src="<%=vimagem %>" onclick="abreFoto();" /></div>
            <div id="divbotaofoto"></div>
            <input type="file" name="arquivo" id="arquivo" onChange="carregaFoto();" class="invisivel"/>
            <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaDestaque(this.form);desabilitaSelecaoFoto();"  />
     		<input type="hidden" id="x1" value="-" name="x1" />
     		<input type="hidden" id="y1" value="-" name="y1" />
     		<input type="hidden" value="-" id="w" name="w" />
     		<input type="hidden" id="h" value="-" name="h" />
     		<input type="hidden" id="nomeArquivo" name="nomeArquivo" />
        </form>
   </div> 
  
   <div id="tabs-2">
   		<form name="fbusca" method="post" target="divbusca" >
   			Busca por
   			<input name="descricao" id="descricao" type="text" maxlength="1000" /><br>
	      	<input type="radio" name="ativos" id="ativos" value="1" />Ativos
	      	<input type="radio" name="ativos" id="ativos" value="0" />Inativos
 	      	<input type="radio" name="ativos" id="ativos" value="todos" checked="checked"/>Todos
   			<input type="button" name="buscar" id="buscar" value="buscar" onclick="listar();" />
   		</form>
   		<div id="divbusca"></div>
   </div>
</div>
<script>
	listaSimples();
</script>