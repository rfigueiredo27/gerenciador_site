<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>



<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/noticias_interno/css/noticias.css" />
<script src="/gecoi.3.0/apps/noticias_interno/scripts/criticas.js" charset="UTF-8"> </script>
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="/gecoi.3.0/scripts/summernote/summernote.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/summernote/summernote.js"></script>

   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> 
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />



<style type="text/css">
#preview {
	overflow:hidden;
}

</style>
<script>

function excluir(vidConteudo, vdescricao, f)
{
	if (confirm("Deseja realmente excluir a not\u00edcia " + vdescricao + "?" ) == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar(f);});
}

function listar(f)
{
	document.getElementById("resultado").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/noticias_interno/lista_reportagem.jsp", {ano: f.ano.value, ambiente : f.ambienteAlteraReportagem.value}, function(resposta) {$("#resultado").html(resposta);zera_contador();});
}


$(document).ready(function(){
		$( "#tabs" ).tabs();		
		//$( "#dataReportagem" ).datepicker();
		$('#dataReportagem').datetimepicker({
			controlType: 'select',
			timeFormat: 'HH:mm',
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true																	
		});
		inicia_editor('IncluirHtmlReportagem');
	});

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
request.setCharacterEncoding("UTF-8");
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
Calendar c = Calendar.getInstance();
//String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
String vhoje = ft.format(c.getTime());
String vselecao = "";
//carregaPag('/gecoi.3.0/apps/noticias_interno/lista_reportagem.jsp', 'listaReportagem');
%>
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="" title="" id="">Incluir nova</a></li>
            <li><a href='#tabs-2' onclick="" title="" id="">Not&iacute;cias Cadastradas</a></li>
        </ul>
        <div id="tabs-1">
                	<div id="nova_reportagem">
                    	<%@include file="incluir_reportagem.jsp"%>
                	</div> 
        </div>
        <div id="tabs-2">
                	<div id="listaReportagem">
                    	<%@include file="busca_reportagem.jsp"%>
                	</div> 
        </div>
    </div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 