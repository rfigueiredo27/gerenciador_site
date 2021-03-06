<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>



<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/parlatorio/css/parlatorio.css" />
<script src="/gecoi.3.0/apps/parlatorio/scripts/criticas.js" charset="UTF-8"> </script>
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="/gecoi.3.0/scripts/summernote/summernote.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/summernote/summernote.js"></script>





<style type="text/css">
#preview {
	overflow:hidden;
}

</style>
<script>

function excluir(vidConteudo, vdescricao, vaba)
{
	if (confirm("Deseja realmente excluir " + vdescricao + " do parlat\u00f3rio?" ) == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar(vaba);});
}

function excluirFundo(vidConteudo, vdescricao, vaba)
{
	if (confirm("Deseja realmente excluir " + vdescricao + " do parlat\u00f3rio?" ) == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_catalogo.jsp", {idConteudo : vidConteudo, idCatalogo : 394}, function(){top.listar(vaba);});
}

function listar(vaba)
{
	document.getElementById("lista" + vaba).innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/parlatorio/lista_" + vaba.toLowerCase() + ".jsp", function(resposta) {$("#lista" + vaba).html(resposta);});
}


$(document).ready(function(){
		$( "#tabs" ).tabs();		
		$( "#tabs2" ).tabs();		
		$( "#tabs3" ).tabs();		
		$( "#tabs4" ).tabs();		
		$( "#dataAbertura" ).datepicker();
		$( "#dataReportagem" ).datepicker();
		$( "#dataFundo" ).datepicker();
		$( "#dataParlatorio" ).datepicker();		
		atualizaPreview();
	});

function atualizaPreview()
{
	carregaPag("/intra_nova/noticias_publicacoes/parlatorio/on_line/parlatorio_online.jsp","preview");
}

function FormataData(Campo,teclapres)
{
	var tecla = teclapres.keyCode;
	vr = Campo.value;
	
	vr = vr.replace( ".", "" );
	vr = vr.replace( "/", "" );
	vr = vr.replace( "/", "" );
	tam = vr.length + 1;

    if (!isNaN(vr))
	{
	   if ( tecla != 9 && tecla != 8 )
       {
 	      if ( tam > 2 && tam < 5 )
			 Campo.value = vr.substr( 0, tam - 2  ) + '/' + vr.substr( tam - 2, tam );
		
		  if ( tam >= 5 && tam <= 8 )
			 Campo.value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 2 ) + '/' + vr.substr( 4, 4 ); 
	 
       }
	}
}

function SoNumero(event, campo)
{ 

	// verifica o evento ativado (IE ou FF) 
	var tecla = window.event ? event.keyCode : event.which; 

	// verifica a parte numérica do teclado 
	if(tecla > 44 && tecla < 58 || tecla > 95 && tecla < 106 || tecla == 08) 
	{ 
		// quando só numero 
		return false; 
	} 
	else 
	{ 

		// quando letra
		// retorna alerta 
		//window.alert("somente números") 

		// pega o texto do input 
		valor_input = campo.value; 

		// pega o tamanho do texto do input e retira um (letra) 
		tamanho_input = campo.value.length-1; 

		// armazena em escreve sem a letra 
		escreve = valor_input.substring(0,tamanho_input);

		// escreve no input sem a letra 
		campo.value = escreve; 
		return false; 
	} 
} 

function inicia_editor(campo){
	$('#'+campo).summernote({
		minHeight: 600,
		disableResize: true,
		placeholder: "Texto da reportagem...",
		//airMode: true,
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    //['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
			['insert', ['link', 'picture', 'video']],
		    ['imagesize', ['imageSize100', 'imageSize50', 'imageSize25']],
		    //['float', ['floatLeft', 'floatRight', 'floatNone']],
		    ['remove', ['removeMedia']],
			['view', ['fullscreen', 'codeview']],
			['table', ['table']]
		]
  	});
}

</script>

<%
request.setCharacterEncoding("ISO-8859-1");
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
Calendar c = Calendar.getInstance();
//String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yyyy");
String vhoje = ft.format(c.getTime());
String vsecao = "";
String vselecao = "";
%>
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="atualizaPreview();" title="P&aacute;gina Principal" id="">P&aacute;gina Principal</a></li>
            <li><a href='#tabs-2' onclick="" title="Parlat&oacute;rio" id="">Parlat&oacute;rio</a></li>
            <li><a href='#tabs-3' onclick="inicia_editor('IncluirHtmlReportagem')" title="Reportagens">Reportagens</a></li>
            <li><a href='#tabs-4' onclick="carregaPag('/gecoi.3.0/apps/parlatorio/lista_reportagem_fundo.jsp', 'novo_fundo');" title="Do Fundo do Ba&uacute;">Do Fundo do Ba&uacute;</a></li>
            <li><a href='#tabs-5' onclick="" title="Relat&oacute;rios">Relat&oacute;rios</a></li>
        </ul>
        <div id="tabs-1">
        	<div id="preview">
            <!--<img src="/gecoi.3.0/img/PreviewParlatorio.jpg" />-->
            <%//@include file="pagina_principal.jsp"%>
            </div>
        </div>
        <div id='tabs-2'>
            <div id='tabs2'>
                <ul>
                    <li><a href='#tabs-21' onclick="" title="Novas" id="">Novas</a></li>
                    <li><a href='#tabs-22' onclick="carregaPag('/gecoi.3.0/apps/parlatorio/lista_parlatorio.jsp', 'listaParlatorio');" title="Alterar">Alterar</a></li>
                </ul>
                <div id='tabs-21'>
                	<div id="novo_parlatorio">
                    	<%@include file="incluir_parlatorio.jsp"%>
                	</div> 
                </div>
                <div id='tabs-22'>
                	<div id="listaParlatorio">
                	</div> 
                </div>
            </div>
        </div>
        <div id="tabs-3">
            <div id='tabs3'>
                <ul>
                    <li><a href='#tabs-31' onclick="" title="Novas" id="">Novas</a></li>
                    <li><a href='#tabs-32' onclick="carregaPag('/gecoi.3.0/apps/parlatorio/lista_reportagem.jsp', 'listaReportagem');" title="Alterar">Alterar</a></li>
                </ul>
                <div id='tabs-31'>
                	<div id="nova_reportagem">
                    	<%@include file="incluir_reportagem.jsp"%>
                	</div> 
                </div>
                <div id='tabs-32'>
                	<div id="listaReportagem">
                    	<%//@include file="lista_reportagem.jsp"%>
                	</div> 
                </div>
            </div>
        </div>
        <div id="tabs-4">
            <div id='tabs4'>
                <ul>
                    <li><a href='#tabs-41' onclick="" title="Novos" id="">Novos</a></li>
                    <li><a href='#tabs-42' onclick="carregaPag('/gecoi.3.0/apps/parlatorio/lista_fundo.jsp', 'listaFundo');" title="Alterar">Alterar</a></li>
                </ul>
                <div id='tabs-41'>
                	<div id="novo_fundo">
                    	<%//@include file="incluir_fundo.jsp"%>
                        <%//@include file="incluir_fundo.jsp"%>
                	</div> 
                </div>
                <div id='tabs-42'>
                	<div id="listaFundo"></div> 
                </div>
            </div>
        </div>
        <div id="tabs-5">
        	<%//@include file="relatorios.jsp"%>
        </div>
    </div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 