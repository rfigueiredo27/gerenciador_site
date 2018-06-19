<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<script src="/gecoi.3.0/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script>
  <script>
	$("#IncluirHtmlReportagem").html("<textarea name='mytextarea' id='mytextarea' ></textarea>");
	$("#IncluirHtmlFundo").html("<textarea name='mytextarea' id='mytextarea' ></textarea>");
  tinymce.init({ 
	selector: "textarea",
	//selector: "textarea#AlteraHtmlFundo",
	//mode : "specific_textareas",
	//editor_selector : "mceEditor",
	//mode : "exact",
	//elements : "AlteraHtmlFundo",
	
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
   save_onsavecallback: function () {$.post("/gecoi.3.0/apps/global/salvar_tinymce.jsp", {texto : document.falteraFundo.mytextarea.value}, function(resposta){$("#rodape").html(resposta);}); },
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
	carregaPag("/gecoi.3.0/apps/parlatorio/lista_fundo.jsp","listaFundo");
}


function criticaAlteraFundo()
{
	critica_alteracao_fundo(document.falteraFundo);
}

$(document).ready(function(){
	$( "#dataAlteraFundo" ).datepicker();
});


</script>
<%
request.setCharacterEncoding("ISO-8859-1");
String vselecao = "";
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
String vsecao = "";
String vdataPublicacao = "";
String vtituloFundo = "";
String vresumoFundo = "";
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
			vtituloFundo = vdescricao[0];
			vresumoFundo = vdescricao[1];
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

varquivoHTML = gravar.gravar(vidArquivoHTML, vdiretorio, vusuario, vsenha);

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
	<legend>Altera&ccedil;&atilde;o de Reportagens do Tipo Fundo do Ba&uacute;</legend>
	<form name="falteraFundo" action="/gecoi.3.0/apps/parlatorio/processa_alterar_fundo.jsp" method="post" target="rodapeAltera" enctype="multipart/form-data">
  <div id="edicao_fundo">
    		<fieldset>
                <legend>Edi&ccedil;&atilde;o do Parlat&oacute;rio</legend>
				<input title="Edi&ccedil;&atilde;o do Parlat&oacute;rio" alt="Edi&ccedil;&atilde;o do Parlat&oacute;rio" type="text" name="edicaoFundo" id="edicaoFundo" value="<%=vedicao%>" />
        	</fieldset>
	    </div>
<div id="secao_fundo">
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
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataAlteraFundo" id="dataAlteraFundo" size="10" maxlength="10" value="<%=vdataPublicacao%>"/>
        	</fieldset>
	    </div>
<div id="titulo_fundo">
    		<fieldset>
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Fundo" alt="T&iacute;tulo da Fundo" type="text" name="tituloAlteraFundo" id="tituloAlteraFundo" value="<%=vtituloFundo%>" />
        	</fieldset>
	    </div>
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="<%=vresumoFundo%>" height="100" width="100" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selectione a imagem da TV</legend>
            <p>
              <input name="banner" type="file" id="banner" onchange="" >
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
        	<legend>Editar Fundo</legend>
            <h3></h3>
        	<textarea name="AlteraHtmlFundo" id="AlteraHtmlFundo" ><%=vtexto%></textarea>
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
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraFundo();"  />
      </div>
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
