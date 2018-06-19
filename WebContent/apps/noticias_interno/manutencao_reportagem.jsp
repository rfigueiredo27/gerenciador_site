<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, java.nio.charset.StandardCharsets" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<script>
function escolhe_edicao_alterar(pescolha)
{
	if (pescolha == "U")
	{
		$("#alterar_html").show();
		$("#altera_editar_arquivo").hide();
	}
	else
	{
		$("#altera_editar_arquivo").show();
		$("#alterar_html").hide();
	}
}

function atualizaTela(pano)
{
	carregaPag("/gecoi.3.0/apps/noticias_interno/lista_reportagem.jsp?ano=" + pano,"resultado");
}


function criticaAlteraReportagem()
{
	critica_alteracao_reportagem(document.falteraReportagem);
}

$(document).ready(function(){
	//$( "#dataAlteraReportagem" ).datepicker();
	$('#dataAlteraReportagem').datetimepicker({
		controlType: 'select',
		timeFormat: 'HH:mm',
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
		changeYear: true																	
	});
	top.inicia_editor('AlteraHtmlReportagem');
});


</script>
<%

String vselecao = "";
// vid_conteudo =  135945;
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
String vano = request.getParameter("ano");
String vambiente = "";
String vdataPublicacao = "";
String vtituloReportagem = "";
String varquivoImagem = "";
String varquivoHTML = "";
String vidArquivoImagem = "-";
String vidArquivoHTML = "";
String vid_area = "";
int vedicao = 0;
//Prepara as variáveis para o acesso ao banco
Connection conexao = null;
PreparedStatement stm;
ResultSet rs;

try
{
	//Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
	   conexao = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data, " + 
					"aq.arquivo, aq.ordem, ca.id_area, " +
					"decode(ca.id_area, 2661, 'Internet e Intranet', 42, 'Internet', 22, 'Intranet') as ambiente " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_conteudo = ? " +
   				   "ORDER BY aq.ordem";
	PreparedStatement pstm = conexao.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	rs = pstm.executeQuery();
	if (rs.next())
	{
		do
		{
			vambiente = rs.getString("ambiente");
			vtituloReportagem = rs.getString("descricao");
			//out.print(resultSet.getString("descricao"));
			//vtituloReportagem = new String (vtituloReportagem.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
			vdataPublicacao = rs.getString("data");
			vid_area = rs.getString("id_area");
			if (rs.getInt("ordem") == 0)
				vidArquivoHTML = rs.getString("id_arquivo");
			else
				vidArquivoImagem = rs.getString("id_arquivo");
		} while (rs.next());
	}
	rs.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(conexao!=null && !conexao.isClosed())
		conexao.close();
}
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vdiretorio = application.getRealPath("/") + "webtemp";
String vtexto = "";
	
GravarArquivo gravar = new GravarArquivo();
if (!vidArquivoImagem.equals("-"))
	varquivoImagem = gravar.gravarComHora(vidArquivoImagem, vdiretorio, vusuario, vsenha);

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
<form name="falteraReportagem" action="/gecoi.3.0/apps/noticias_interno/processa_alterar_reportagem.jsp" method="post" target="rodapeAltera" enctype="multipart/form-data">
<div id="secao_reportagem">
	<fieldset>
    	<legend>Ambiente da Publica&ccedil;&atilde;o</legend>
        <!-- campo 0 -->
       	<select name="ambienteAlteraReportagem" id="ambienteAlteraReportagem" >
			<option value="0">-----------</option>
            <%
				String vescolhido = "";
				if (vid_area.equals("2661"))
					vescolhido = "selected='selected'";
			%>
            <option value="2661" <%=vescolhido%>>Internet e Intranet</option>
            <%
				vescolhido = "";
				if (vid_area.equals("42"))
					vescolhido = "selected='selected'";
			%>
            <option value="42" <%=vescolhido%>>Internet</option>
            <%
				vescolhido = "";
				if (vid_area.equals("22"))
					vescolhido = "selected='selected'";
			%>
            <option value="22" <%=vescolhido%>>Intranet</option>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
        <!-- campo 1 -->
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataAlteraReportagem" id="dataAlteraReportagem" size="10" maxlength="10" value="<%=vdataPublicacao%>"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
        <!-- campo 2 -->
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloAlteraReportagem" id="tituloAlteraReportagem" value="<%=vtituloReportagem%>" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selectione a imagem da TV</legend>
            <p>
        <!-- campo 3 -->
              <input name="tv" type="file" id="tv" onchange="" >
            </p>
            <%
            if (!vidArquivoImagem.equals("-"))
            	out.print("<p><img src='/gecoi.3.0/webtemp/" + varquivoImagem + "' /></p>");
			%>
	      </fieldset>
      </div>
      <div class="tipo_arquivo">
      	<fieldset>
        	<legend>Como deseja publicar a reportagem? </legend>
        <!-- campo 4 -->
            <input type="radio" value="upload" id="AlteraTipoArquivo" name="AlteraTipoArquivo" onclick="escolhe_edicao_alterar('U');" />Upload de um arquivo HTM</select>
            <input type="radio" value="editar" id="AlteraTipoArquivo" name="AlteraTipoArquivo" onclick="escolhe_edicao_alterar('E');" checked="checked" />Editar a reportagem</select>
        </fieldset>
      </div>
        <div id="alterar_html" class="incluir_html invisivel">
      		<fieldset>
        	<legend>Selecione o arquivo da reportagem em HTML</legend>
            <!-- campo 5 -->
            <input name="AlteraHtml" type="file" id="AlteraHtml" onchange="">
            <!-- campo 6 -->
   		  </fieldset>
      </div>
        <div class="editar_arquivo" id="altera_editar_arquivo">
      		<fieldset>
        	<legend>Editar Reportagem</legend>
             <div id="AlteraHtmlReportagem"><%=vtexto%></div>
             <!-- campo 7 -->
            	<textarea name="vtexto_altera" id="vtexto_altera" style="display:none"></textarea>
             <!-- campo 8 -->
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	
   		  </fieldset>
          <!-- campo 9 -->
		<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
        <!-- campo 10 -->
		<input type="text" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
        <!-- campo 11 -->
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
        <!-- campo 12 -->
		<input type="hidden" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
        <!-- campo 13 -->
		<input type="hidden" id="ano" name="ano" value="<%=vano%>" />
      </div>
      	<div id="campoArquivo2"></div>
			<div id="progressBar2" style="display: none;">
				<div id="theMeter2">
            		<div id="progressBarText2"></div>
                	<div id="progressBarBox2">
                		<div id="progressBarBoxContent2"></div>
               		</div>
            	</div>
        </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela(<%=vano%>);" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraReportagem();"  />
      </div>
</form>
</fieldset>
</div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="500" width="500"></iframe> 
