<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File, br.jus.trerj.funcoes.GravarArquivo;"%>
<script type="text/javascript" src="/gecoi.3.0/scripts/critica_altera_curriculo.js"></script>

   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
   
   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/jquery.imgareaselect.pack.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/imgareaselect-default.css" />
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.css" />
   
<style type="text/css">
	.invisivel { display:none; };  
</style>

<script>

function carregaFoto()
{	
	var nome = document.getElementById("arquivo").files[0];
	var oFReader = new FileReader();
    
    oFReader.readAsDataURL(document.getElementById("arquivo").files[0]);
    
    oFReader.onload = function (oFREvent) {
        document.getElementById("foto").src = oFREvent.target.result;
    };

    document.getElementById("nomeArquivo").value = document.getElementById("arquivo").value;    
    //habilitaSelecaoFotoInicial();
            
}

function preview(img, selection)
{
	if (!selection.width || !selection.height)
		return;
	var scaleX = 100 / selection.width;
	var scaleY = 100 / selection.height;
	
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	$('#w').val(selection.width);
	$('#h').val(selection.height);    
}

/*$(document).ready(function(){
	
	//$("#foto").click(function(){$("#arquivo").click();});
	
	//$('#foto').imgAreaSelect({ x1: 100, y1: 100, x2: 300, y2: 250, resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	habilitaSelecaoFotoInicial();	
	
});
*/
function habilitaSelecaoFotoInicial()
{
	$('#foto').imgAreaSelect({ enable : true, resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect({ show: true, enable : true, enable: true, resizable: false, handles: false,  x1: 0, y1: 0, x2: 200, y2: 150, maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect().update();
}

/*function abreFoto()
{
	$('#foto').imgAreaSelect({ hide: true, disable: true, remove: true });
	//$('#foto').imgAreaSelect().update();
	if (document.getElementById("nomeArquivo").value == "")
		$("#arquivo").click();	
}
*/
function desabilitaSelecaoFoto()
{
	$('#foto').imgAreaSelect({ hide: true });
}


function excluirFoto()
{
	$("#foto").attr("src", "/gecoi.3.0/img/semfoto.jpg");
	$('#foto').imgAreaSelect({ hide: true, disable: true });
	//$('#foto2').imgAreaSelect().cancelSelection;
	//$('#foto').imgAreaSelect().update();
	document.getElementById("x1").value = "-";
	document.getElementById("y1").value = "-";
	document.getElementById("w").value = "-";
	document.getElementById("h").value = "-";
	document.getElementById("nomeArquivo").value = "";
}

function executar()
{
	/*$.ajaxSetup({
		  url: "ping.php"
		});
	*/
	//$.post("processa_alteracao_curriculo.jsp", {idConteudo : document.fdescricao.idconteudo.value, descricao: document.fdescricao.descricao.value}, function(){});
	//$.post("/gecoi.3.0/AlteraCurriculoImg", {idConteudo : document.fdescricao.idconteudo.value, descricao: document.fdescricao.descricao.value}, function(){});
}

function atualizaTela()
{
	top.listar();
	parent.tb_remove();
}
</script>

<script>
//$(document).ready(function(){
//	$('#foto2').imgAreaSelect({ resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
//});
</script>
<%
String vidConteudo = request.getParameter("id");
String vdiretorio = application.getRealPath("/") + "webtemp";
String vdescricao = request.getParameter("descricao");
String vidArquivoImg = request.getParameter("idArquivoImg");
String vnomeArquivo = request.getParameter("nomeArquivoImg");
String vimagem = "";

GravarArquivo gravarArquivo = new GravarArquivo();
String vnome = gravarArquivo.gravar(vidConteudo, "jpg", vdiretorio, session.getAttribute("login").toString());
if (vnome.equals("erro"))
{
	vimagem = "/gecoi.3.0/img/semfoto.jpg";
}
else
{
	vimagem = "/gecoi.3.0/webtemp/" + vnome;
	//File apagar = new File(getServletContext().getRealPath("/") + "webtemp\\" + vnome);
	//apagar.delete();
}
%>
<!--<form name="fimagem" action="" method="post" target="rodape" enctype="multipart/form-data">-->
 <form name="fimagem" action="/gecoi.3.0/AlteraCurriculoImg" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" id="x1" value="-" name="x1" />
<input type="hidden" id="y1" value="-" name="y1" />
<input type="hidden" value="-" id="w" name="w" />
<input type="hidden" id="h" value="-" name="h" />
<input type="hidden" id="nomeArquivo" name="nomeArquivo" />
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
<input type="hidden" name="idarquivoImg" id="idarquivoImg" value="<%=vidArquivoImg%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="imagem" id="imagem" value="<%=vnome%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
        <div id="divfoto"> <img name="foto" id="foto"  src="<%=vimagem %>" /></div>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Nova Foto" onclick="desabilitaSelecaoFoto();habilitaSelecaoFotoInicial();$('#arquivo').click();" />
           <input type="button" name="excluir" value="Excluir" onclick="excluirFoto();" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaCurriculo(this.form);"  /> 
            <input type="file" name="arquivo" id="arquivo" onChange="carregaFoto();" class="invisivel"/>            
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
