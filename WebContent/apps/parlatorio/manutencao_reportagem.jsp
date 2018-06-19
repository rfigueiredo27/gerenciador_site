<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

  <script>
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
	top.inicia_editor('AlteraHtmlReportagem');
});


</script>
<%
request.setCharacterEncoding("ISO-8859-1");
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
        <!-- campo 0 -->
                <legend>Edi&ccedil;&atilde;o</legend>
				<input title="Edi&ccedil;&atilde;o do Parlat&oacute;rio" alt="Edi&ccedil;&atilde;o do Parlat&oacute;rio" type="text" name="edicaoReportagem" id="edicaoReportagem" value="<%=vedicao%>" />
        	</fieldset>
	    </div>
<div id="secao_reportagem">
	<fieldset>
    	<legend>Se&ccedil;&otilde;es</legend>
        <!-- campo 1 -->
       	<select name="secaoAlteraReportagem" id="secaoAlteraReportagem">
			<option value="0">-----------</option>
            <%@include file="secoes.jsp"%>
 		</select>
	</fieldset>
</div>
<div id="data_publicacao">
    		<fieldset>
        <!-- campo 2 -->
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataAlteraReportagem" id="dataAlteraReportagem" size="10" maxlength="10" value="<%=vdataPublicacao%>"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
        <!-- campo 3 -->
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloAlteraReportagem" id="tituloAlteraReportagem" value="<%=vtituloReportagem%>" />
        	</fieldset>
	    </div>
<div id="subtitulo_reportagem">
    		<fieldset>
        <!-- campo 4 -->            
                <legend>Subt&iacute;tulo</legend>
				<input title="Subt&iacute;tulo da Reportagem" alt="Subt&iacute;tulo da Reportagem" type="text" name="subtituloAlteraReportagem" id="subtituloAlteraReportagem" value="<%=vsubtituloReportagem%>" />
        	</fieldset>
	    </div>
        <div id="incluir_tv">
      		<fieldset>
        	<legend>Selectione a imagem da TV</legend>
            <p>
        <!-- campo 5 -->
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
             <div id="AlteraHtmlReportagem"><%=vtexto%></div>
             <!-- campo 7 -->
            	<textarea name="vtexto_altera" id="vtexto_altera" style="display:none"></textarea>
             <!-- campo 8 -->
            <input name="image" type="file" id="upload" class="hidden" onchange="">
        	<div id="campoArquivo6"></div>
			<div id="progressBar6" style="display: none;">
				<div id="theMeter6">
            		<div id="progressBarText6"></div>
                	<div id="progressBarBox6">
                		<div id="progressBarBoxContent6"></div>
               		</div>
            	</div>
         	</div>
   		  </fieldset>
          <!-- campo 9 -->
		<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
        <!-- campo 10 -->
		<input type="hidden" id="idArquivoImagem" name="idArquivoImagem" value="<%=vidArquivoImagem%>" />
        <!-- campo 11 -->
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraReportagem();"  />
      </div>
</form>
</fieldset>
</div>

<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
