<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

  <script>
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
request.setCharacterEncoding("ISO-8859-1");
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
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data, " + 
					"aq.arquivo, aq.ordem, ca.id_area, " +
					"decode(ca.id_area, 2661, 'Internet e Intranet', 42, 'Internet', 22, 'Intranet') as ambiente " +
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
			vambiente = resultSet.getString("ambiente");
			vtituloReportagem = resultSet.getString("descricao");
			vdataPublicacao = resultSet.getString("data");
			vid_area = resultSet.getString("id_area");
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
       	<select name="ambienteAlteraReportagem" id="ambienteAlteraReportagem" onchange="trocaReportagem(this.value);">
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
        <div class="editar_arquivo">
      		<fieldset>
        	<legend>Editar Reportagem</legend>
             <div id="AlteraHtmlReportagem"><%=vtexto%></div>
             <!-- campo 6 -->
            	<textarea name="vtexto_altera" id="vtexto_altera" style="display:none"></textarea>
             <!-- campo 7 -->
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	
   		  </fieldset>
          <!-- campo 8 -->
		<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
        <!-- campo 9 -->
		<input type="hidden" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
        <!-- campo 10 -->
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
        <!-- campo 11 -->
		<input type="hidden" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
        <!-- campo 12 -->
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
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
