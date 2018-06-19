<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<script src="/gecoi.3.0/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script>
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
	$("#IncluirHtmlReportagem").html("<textarea name='mytextarea' id='mytextarea' ></textarea>");
	$("#IncluirHtmlFundo").html("<textarea name='mytextarea' id='mytextarea' ></textarea>");
  tinymce.init({ 
  selector: "textarea",
  //selector : "textarea:not(.mceNoEditor)",
 //selector: "textarea.editme",
 //selector: "textarea#alteraReportagem",
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
   save_onsavecallback: function () {$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : document.falteraReportagem.alteraReportagem.value}, function(resposta){$("#rodape").html(resposta);}); },
   image_advtab: true,
   toolbar: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | styleselect forecolor backcolor | link unlink anchor | image media | print preview code restoredraft save",
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

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/parlatorio/lista_reportagem.jsp","listaReportagem");
}


function criticaAlteraReportagem()
{
	critica_alteracao_reportagem(document.falteraReportagem);
}

$(document).ready(function(){
	$( "#dataAlteraReportagem" ).datepicker();
});


</script>
<%
String vselecao = "";
// vid_conteudo =  135945;
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
String vsecao = "";
String vdataPublicacao = "";
String vtituloReportagem = "";
String vsubtituloReportagem = "";
String varquivoImagem = "";
String varquivoHTML = "";
String vidArquivoImagem = "";
String vidArquivoHTML = "";
int vedicao = 0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data, " + 
					"aq.arquivo, aq.ordem, co.observacao, aq.publicado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_conteudo = ? " +
   				   "ORDER BY aq.ordem";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	resultSet = pstm.executeQuery();
	if (resultSet.next())
	{
		do
		{
			String[] vdescricao = resultSet.getString("descricao").split("@@");
			vtituloReportagem = vdescricao[0];
			vsubtituloReportagem = vdescricao[1];
			vdataPublicacao = resultSet.getString("data");
			vsecao = resultSet.getString("observacao");
			vedicao = resultSet.getInt("publicado");
			if (resultSet.getInt("ordem") == 0)
				vidArquivoHTML = resultSet.getString("id_arquivo");
			else
				vidArquivoImagem = resultSet.getString("id_arquivo");
		} while  ( resultSet.next() );
	}
	resultSet.close();
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
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vdiretorio = application.getRealPath("/") + "webtemp";
String vtexto = "";
	
GravarArquivo gravar = new GravarArquivo();
varquivoImagem = gravar.gravarComHora(vidArquivoImagem, vdiretorio, vusuario, vsenha);
// estou colocando a hora no arquivo pois a tag img não estava atualizando e o usuário para depois apagar no limpa_webtemp.jsp
/*Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());
String vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
String vnomeArquivoImagem = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vagora + "." + vextensao;
boolean troquei = new File(varquivoImagem).renameTo(new File(vnomeArquivoImagem));
out.print(troquei);
*/

varquivoHTML = gravar.gravar(vidArquivoHTML, vdiretorio, vusuario, vsenha);
// estou colocando o usuário para depois apagar no limpa_webtemp.jsp
//vextensao = varquivoHTML.substring(varquivoHTML.lastIndexOf(".")+1, varquivoHTML.length());
//String vnomeArquivoHTML = varquivoHTML.substring(0, varquivoHTML.lastIndexOf(".")) + "-" + vagora + "." + vextensao;
//new File(varquivoHTML).renameTo(new File(vnomeArquivoHTML));

if (!varquivoHTML.equals("erro"))
{
	File varquivo = new File(vdiretorio + "/" + varquivoHTML);
	//Preparação para ler o arquivo
	StringBuffer contents = new StringBuffer();
	BufferedReader reader = null;

	reader = new BufferedReader(new FileReader(varquivo));
	String text = null;
 
	// Lê o arquivo, substituindo as quebras de linha pela tag </br>
	while ((text = reader.readLine()) != null) {
	//Se no texto tiver as seguintes tags: <p>, <ul>, <li>, <h1>, <h2>, <h3>
	//não é necessário pular uma linha
	if(text.indexOf("ul>")>0 || text.indexOf("li>")>0 || text.indexOf("p>")>0 || text.indexOf("h1>")>0 || text.indexOf("h2>")>0 || text.indexOf("h3>")>0)
		contents.append(text);
	else
		contents.append(text + "<br>");
	}
	vtexto = contents.toString();
}

%>

<div id="altera_ata">
<fieldset>
	<legend>Altera&ccedil;&atilde;o de Reportagens</legend>
<form name="falteraReportagem" action="/gecoi.3.0/apps/parlatorio/processa_alterar_reportagem.jsp" method="post" target="rodapeAltera" enctype="multipart/form-data">
<div id="edicao_reportagem">
    		<fieldset>
                <legend>Edi&ccedil;&atilde;o do Parlat&oacute;rio</legend>
				<input title="Edi&ccedil;&atilde;o do Parlat&oacute;rio" alt="Edi&ccedil;&atilde;o do Parlat&oacute;rio" type="text" name="edicaoReportagem" id="edicaoReportagem" value="<%=vedicao%>" />
        	</fieldset>
	    </div>
<div id="secao_reportagem">
	<fieldset>
    	<legend>Se&ccedil;&otilde;es</legend>
       	<select name="secaoAlteraReportagem" id="secaoAlteraReportagem">
			<option value="0">-----------</option>
            <%@include file="secoes.jsp"%>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataAlteraReportagem" id="dataAlteraReportagem" size="10" maxlength="10" value="<%=vdataPublicacao%>"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloAlteraReportagem" id="tituloAlteraReportagem" value="<%=vtituloReportagem%>" />
        	</fieldset>
	    </div>
<div id="subtitulo_reportagem">
    		<fieldset>
                <legend>Subt&iacute;tulo</legend>
				<input title="Subt&iacute;tulo da Reportagem" alt="Subt&iacute;tulo da Reportagem" type="text" name="subtituloAlteraReportagem" id="subtituloAlteraReportagem" value="<%=vsubtituloReportagem%>" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selectione a imagem da TV</legend>
            <p>
              <input name="tv" type="file" id="tv" onchange="" >
              <!--<div id="campoArquivo"></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>-->
            </p>
            <p><img src="/gecoi.3.0/webtemp/<%=varquivoImagem%>" /></p>
	      </fieldset>
      </div>
        <div id="editar_arquivo">
      		<fieldset>
        	<legend>Editar Reportagem</legend>
        	<textarea name="alteraReportagem" id="alteraReportagem"><%=vtexto%></textarea>
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	<div id="campoArquivo"></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
   		  </fieldset>
		<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
		<input type="hidden" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraReportagem();"  />
      </div>
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
