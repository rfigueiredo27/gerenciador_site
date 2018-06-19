<%@include file="/includes/limpa_webtemp.jsp"%>
<%
//String vimagem = (request.getParameter("imagem") == null) ? "/gecoi.3.0/img/adicionar.png" : ("/gecoi.3.0/webtemp/" + request.getParameter("imagem"));
String vimagem = "/gecoi.3.0/img/adicionar.png";
%>

   <!-- usado no curriculo -->
   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/jquery.imgareaselect.pack.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/imgareaselect-default.css" />
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.css" />
   <script type="text/javascript" src="/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/curriculo/scripts/critica_novo_curriculo.js"></script>
<style type="text/css">
	.invisivel { display:none; };  
</style>

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
	/*$('#x2').val(selection.x2);
	$('#y2').val(selection.y2);*/
	$('#w').val(selection.width);
	$('#h').val(selection.height);    
}


$(document).ready(function(){
	$( "#tabs" ).tabs();  
	
	//$("#foto").click(function(){$("#arquivo").click();});
	
	//$('#foto').imgAreaSelect({ x1: 100, y1: 100, x2: 300, y2: 250, resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//habilitaSelecaoFotoInicial();	
		

});

function habilitaSelecaoFotoInicial()
{
	//$('#foto').imgAreaSelect({parent:  'tabs-1', resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	$('#foto').imgAreaSelect({ resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//var ias = $('#foto').imgAreaSelect({instance: true, resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect().update();
	//ias.update();
}

function habilitaSelecaoFoto()
{
	
	if (document.getElementById("nomeArquivo").value != "")
	{
		//$('#foto').imgAreaSelect({ show: true, x1: document.fcurriculo.x1.value, y1 : document.fcurriculo.y1.value, x2: document.fcurriculo.x1.value + document.fcurriculo.w.value, y2 : document.fcurriculo.y1.value + document.fcurriculo.h.value,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
		var ias = $('#foto').imgAreaSelect({ instance: true });
		ias.setSelection(parseInt(document.fcurriculo.x1.value), parseInt(document.fcurriculo.y1.value), parseInt(document.fcurriculo.x1.value) + parseInt(document.fcurriculo.w.value), parseInt(document.fcurriculo.y1.value) + parseInt(document.fcurriculo.h.value), true);
		ias.setOptions({show: true,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview});
		ias.update();
	}
	//var ias = $('#foto').imgAreaSelect({ instance: true, show: true, x1: document.fcurriculo.x1.value, y1 : document.fcurriculo.y1.value, x2: document.fcurriculo.x1.value + document.fcurriculo.w.value, y2 : document.fcurriculo.y1.value + document.fcurriculo.h.value,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect().update();
	//ias.update();
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
    //document.getElementById("divbotaofoto").innerHTML = "<img id='excluir_foto' name='excluir_foto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirFoto();' /><img id='incluir_foto' name='incluir_foto' src='/gecoi.3.0/img/botao_incluir.png' onclick='habilitaSelecaoFotoInicial();$(\"#arquivo\").click();' />";
    document.getElementById("divbotaofoto").innerHTML = "<img id='excluir_foto' name='excluir_foto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirFoto();' /><img id='incluir_foto' name='incluir_foto' src='/gecoi.3.0/img/botao_incluir.png' onclick='desabilitaSelecaoFoto();habilitaSelecaoFotoInicial();$(\"#arquivo\").click();' />";    
    habilitaSelecaoFotoInicial();
}


function abreFoto()
{
	//habilitaSelecaoFotoInicial();
	if (document.getElementById("nomeArquivo").value == "")
		$("#arquivo").click();	
}

function iniciaTexto()
{

	document.getElementById("divtexto").innerHTML = "<textarea id='texto' name='texto' style='width:100%; height:405px;' wrap='virtual'></textarea>";
	
	iniciaTinyMCE();
	
	document.getElementById("divbotaotexto").innerHTML = "<img id='excluir_texto' name='excluir_texto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirTexto();' />";
}

function iniciaTinyMCE()
{
	//alert('1');
	tinyMCE.init({
		// General options
		mode : 'textareas',
		theme : "advanced",
		plugins : "lists,advlink,inlinepopups,print,paste,fullscreen,searchreplace,style,nonbreaking,table",
		convert_urls: false,
		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,charmap,pastetext,removeformat,|,outdent,indent,bullist,link,unlink,tablecontrols,|,undo,redo,|,print,code,|,formatselect",
		theme_advanced_buttons2 : false,
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",

		// Example content CSS (should be your site CSS)
		content_css : "/gecoi.3.0/css/tinymce.css",

        // Style formats
		style_formats : [
			{title : 'Subtítulo', block : 'h2'},
			{title : 'Alerta',  inline : 'span', classes : 'alerta'}
		]

	});

}

function excluirTexto()
{
	document.getElementById("divtexto").innerHTML = "<img name='informacoesImg' id='informacoesImg'  src='<%=vimagem %>' onclick='iniciaTexto();' /><textarea id='texto' name='texto' style='width:100%; height:405px;' wrap='virtual' class='invisivel' ></textarea>";
	document.getElementById("divbotaotexto").innerHTML = "";
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
	$.post("/gecoi.3.0/apps/curriculo/lista_curriculo.jsp", { vtexto: document.fbusca.nome.value, vativo: document.fbusca.ativos.value }, function(resposta) {$("#divbusca").html(resposta);});
}

</script>
<div id='tabs'>
   <ul>
      <li tabindex='1'><a href='#tabs-1' onclick="habilitaSelecaoFoto();" >Incluir novo</a></li>
      <li tabindex='2'><a href='#tabs-2' onclick="desabilitaSelecaoFoto();">Membros cadastrados</a></li>
   </ul>
   <div id='tabs-1'>
   		<form name="fcurriculo" action="/gecoi.3.0/GravaNovoCurriculo" method="post"  target="processa_background" enctype="multipart/form-data">
        	Nome<br>
            <input name="nome" id="nome" type="text" maxlength="1000" />
            Foto
            <div id="divfoto"  > <img name="foto" id="foto"  src="<%=vimagem %>" onclick="abreFoto();" /></div>
            <div id="divbotaofoto"></div>
            Informa&ccedil;&otilde;es
            <div id="divtexto"  >
            	<img name="informacoesImg" id="informacoesImg"  src="<%=vimagem %>" onclick="iniciaTexto();" />
            	 <textarea id='texto' name='texto' style='width:100%; height:405px;' wrap='virtual' class="invisivel" ></textarea> 
            </div>
            <div id="divbotaotexto"></div>
            <input type="file" name="arquivo" id="arquivo" onChange="carregaFoto();" class="invisivel"/>
            <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaCurriculo(this.form);desabilitaSelecaoFoto();"  />
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
   			<input name="nome" id="nome" type="text" maxlength="1000" /><br>
	      	<input type="radio" name="ativos" id="ativos" value="1" />Ativos
	      	<input type="radio" name="ativos" id="ativos" value="0" />Inativos
 	      	<input type="radio" name="ativos" id="ativos" value="todos" checked="checked"/>Todos
   			<input type="button" name="buscar" id="buscar" value="buscar" onclick="listar();" />
   		</form>
   		<div id="divbusca"></div>
   </div>
</div>
