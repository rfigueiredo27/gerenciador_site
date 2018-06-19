<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<!--
<script type="text/javascript" src="/intra_nova/scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/intra_nova/scripts/jquery-migrate-1.2.1.js"></script>   
   -->
<!--
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css"/>
-->
<!--
<link rel="stylesheet" href="/intra_nova/scripts/jquery_ui/jquery-ui.css" />  
<script type="text/javascript" src="/intra_nova/scripts/jquery_ui/jquery-ui.js"></script> 
   -->


<!--<script type="text/javascript" src="/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>-->

<style type="text/css">
#preview {
	overflow:hidden;
}
</style>

<script src="/gecoi.3.0/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script>


<script src="/gecoi.3.0/apps/parlatorio/scripts/criticas.js" charset="UTF-8"> </script>


<script>

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

  /*
  tinymce.init({ 
  selector:'textarea' ,
  plugins: [
    'advlist autolink lists link image charmap print preview anchor',
    'searchreplace visualblocks code fullscreen',
    'insertdatetime media table contextmenu paste code filemanager'
  ]
    });
*/
/*tinymce.init({
  selector: 'textarea',  // change this value according to your HTML
  file_browser_callback: function(field_name, url, type, win) {
    win.document.getElementById(field_name).value = 'my browser value';
  }
});
*/

  tinymce.init({ 
 selector: "textarea",
    theme: "modern",
    //width: 100%,
    height: 400,
    subfolder:"",
    plugins: [
         "advlist autolink link image lists charmap print preview hr anchor pagebreak",
         "searchreplace wordcount visualblocks visualchars code insertdatetime media nonbreaking",
         "table contextmenu directionality emoticons paste textcolor ",
		 //filemanager",
		 //"autosave"
		 "save"
   ],
   //autosave_interval: "10s",
   //images_upload_base_path: '/gecoi.3.0/webtemp',
   //automatic_uploads: true,
   //images_upload_url: 'postAcceptor.php',
   //images_upload_url: 'uploadImagem.jsp',
   //images_upload_url: { "location": "/gecoi.3.0/webtemp/" },
   save_onsavecallback: function () {$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : document.fincReportagem.mytextarea.value}, function(resposta){$("#rodape").html(resposta);}); },
   image_advtab: true,
   toolbar: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | styleselect forecolor backcolor | link unlink anchor | image media | print preview code restoredraft save",
   //file_browser_callback: function(field_name, url, type, win) {
    //win.document.getElementById(field_name).value = 'my browser value';
  //}
	//file_picker_callback: function(callback, value, meta) {
    //    imageFilePicker(callback, value, meta);
    //}  
file_picker_callback: function(callback, value, meta) {
      if (meta.filetype == 'image') {
        $('#upload').trigger('click');
        $('#upload').on('change', function() {
          var file = this.files[0];
          var reader = new FileReader();
          reader.onload = function(e) {
            callback(e.target.result, {
              alt: ''
            });
          };
          reader.readAsDataURL(file);
        });
      }
    },
    templates: [{
      title: 'Test template 1',
      content: 'Test 1'
    }, {
      title: 'Test template 2',
      content: 'Test 2'
    }]
 }); 

var imageFilePicker = function (callback, value, meta) {               
    tinymce.activeEditor.windowManager.open({
        title: 'Image Picker',
        url: '/gecoi.3.0',
        width: 650,
        height: 550,
        buttons: [{
            text: 'Insert',
            onclick: function () {
                //.. do some work
                tinymce.activeEditor.windowManager.close();
            }
        }, {
            text: 'Close',
            onclick: 'close'
        }],
    }, {
        oninsert: function (url) {
            callback(url);
            console.log("derp");
        },
    });
};

</script>

<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
Calendar c = Calendar.getInstance();
String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
String vsecao = "";
String vselecao = "";
/*
String visivel_aberto = "";
String visivel_novo = "";
int vid_conteudo = 0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT co.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND Nvl(co.observacao,' ') <> 'PUBLICADO' ";

	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1,vid_area);   
	  
	resultSet = pstm.executeQuery();		  
	if(resultSet.next())
	{
		visivel_aberto = "visible";
		visivel_novo = "hidden";
		vid_conteudo = resultSet.getInt("id_conteudo");
	}
	else
	{
		visivel_aberto = "hidden";
		visivel_novo = "visible";
	}
	resultSet.close();
	out.print(vid_conteudo);
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
*/
%>
<div id="conteudo" >
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="atualizaPreview();" title="P&aacute;gina Principal" id="">P&aacute;gina Principal</a></li>
            <li><a href='#tabs-2' onclick="" title="Parlat&oacute;rio" id="">Parlat&oacute;rio</a></li>
            <li><a href='#tabs-3' onclick="" title="Reportagens">Reportagens</a></li>
            <li><a href='#tabs-4' onclick="" title="Do Fundo do Ba&uacute;">Do Fundo do Ba&uacute;</a></li>
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
                    	<%@include file="incluir_fundo.jsp"%>
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
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 