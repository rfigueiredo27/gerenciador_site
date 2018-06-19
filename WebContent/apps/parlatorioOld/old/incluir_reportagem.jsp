<%//@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<!--<a href="/gecoi.3.0/scripts/tinymce.4.5.4/js/tinymce/plugins/filemanager/dialog.php?type=0&editor=mce_0&lang=eng&fldr=" class="btn iframe-btn" type="button">Open Filemanager</a>-->

<!--<link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>-->

<!--
<script src='https://cdn.tinymce.com/4/tinymce.min.js'></script>
<script src='/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js'></script>
<script src='/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tinymce.min.js'></script>
<script src='/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js'></script>
<script src='/gecoi.3.0/scripts/stinymceOLD2/js/tinymce/tinymce.min.js'></script>

<script type="text/javascript" src="/gecoi.3.0/scripts/tinymceOLD2/js/tinymce/tinymce.min.js"></script>
-->


<!--  <script src="/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script> -->
  <script>
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
         "table contextmenu directionality emoticons paste textcolor filemanager",
		 //"autosave"
		 "save"
   ],
   //autosave_interval: "10s",
   //images_upload_base_path: '/gecoi.3.0/webtemp',
   //automatic_uploads: true,
   //images_upload_url: 'postAcceptor.php',
   //images_upload_url: 'uploadImagem.jsp',
   //images_upload_url: { "location": "/gecoi.3.0/webtemp/" },
   save_onsavecallback: function () {$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : document.fincReportagem.mytextarea.value}); },
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

/*
$(document).ready(function(){
		$( "#tabs" ).tabs();		
		$( "#tabs1" ).tabs();		
		$( "#tabs2" ).tabs();		
		$( "#dataAbertura" ).datepicker();
	});
	*/
function atualizaTela()
{
	//parent.tb_remove();
	//carregaPag("/gecoi.3.0/apps/contrato/lista_contrato.jsp?idLicitacao=" + document.fincAnexo.idArquivo.value + "&nProcesso=" + document.fincAnexo.numProcesso.value + "&nPregao=" + document.fincAnexo.numPregao.value + "&descricao=" + document.fincAnexo.descricao.value, "divbusca");
}


function criticaReportagem()
{
	critica_inclusao_reportagem(document.fincReportagem);
}

$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
//	tinymce.init({
    	//selector: '#mytextarea'
//		mode : "textareas"
		//,
/*		theme : "advanced",
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		//content_css : "css/content.css",
*/
		// Drop lists for link/image/media/template dialogs
		/*template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",
*/

/*		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		]
		
		/*,

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}*/
//	});
});


</script>
<%
// vid_conteudo =  135945;
%>

<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens</legend>
<form name="fincReportagem" action="/gecoi.3.0/apps/parlatorio/processa_incluir_reportagem.jsp" method="post" target="rodape" enctype="multipart/form-data">
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vid_conteudo%>" />
<div id="cadastradas_ano">
	<fieldset>
    	<legend>Se&ccedil;&otilde;es</legend>
       	<select name="secao" id="secao">
			<option value="0">-----------</option>
            <%@include file="secoes.jsp"%>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataReportagem" id="dataReportagem" size="10" maxlength="10"/>
        	</fieldset>
	    </div>
<div id="descricao_reportagem">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloReportagem" id="tituloReportagem" />
                <legend>Subt&iacute;tulo</legend>
				<input title="Subt&iacute;tulo da Reportagem" alt="Subt&iacute;tulo da Reportagem" type="text" name="subtituloReportagem" id="subtituloReportagem" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selectione a imagem da TV</legend>
            <input name="tv" type="file" id="tv" onchange="">
        	<!--<div id="campoArquivo"></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>-->
   		  </fieldset>
      </div>
        <div id="editar_arquivo">
      		<fieldset>
        	<legend>Editar Reportagem</legend>
        	<textarea name="mytextarea" id="mytextarea"></textarea>
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	<!--<div id="campoArquivo"></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>-->
   		  </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaReportagem();"  />
      </div>
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="1000" width="1000"></iframe> 
