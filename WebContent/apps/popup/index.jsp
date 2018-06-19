<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>

<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/noticias_interno/css/noticias.css" />
<script src="/gecoi.3.0/apps/popup/scripts/criticas.js" charset="UTF-8"> </script>
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
<script type="text/javascript">

$(document).ready(function(){
		$( "#tabs" ).tabs();		
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
response.setContentType("text/html; charset=UTF-8");
%>
<div id='tabs'>
     <ul>
         <li><a href='#tabs-1' onclick="" title="" id="">Popup Internet</a></li>
     </ul>
     <div id="tabs-1">
         <div id="nova_reportagem">
           	<%@include file="manutencao_reportagem.jsp"%>
         </div> 
     </div>        
</div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 