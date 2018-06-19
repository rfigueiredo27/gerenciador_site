<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<style>
legend
{
	margin-bottom:0px;
	border-bottom: none;
	width: auto;
}
</style>
<script>
function criticaAlteraReportagem()
{
	critica_alteracao_reportagem(document.falteraReportagem);
}

$(document).ready(function(){
	//$( "#dataAlteraReportagem" ).datepicker();
	$('#data_inicio').datepicker();
	$('#data_fim').datepicker();
	top.inicia_editor('AlteraHtmlReportagem');
});
</script>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
String vselecao = "";
// vid_conteudo =  135945;
int vid_conteudo = 0;
String vano = "";
String vambiente = "";
String vdataInicio = "";
String vdataFim = "";
String vtituloReportagem = "";
String varquivoImagem = "";
String varquivoHTML = "";
String vidArquivoImagem = "-";
String vidArquivoHTML = "";
int vid_area = 2471;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio, "+ 
					"to_char(ca.data_fim_exib, 'dd/mm/yyyy') as data_fim," + 
					"aq.arquivo, aq.ordem, ca.id_area " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area = ? " +
   				   "ORDER BY aq.ordem";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	resultSet = pstm.executeQuery();
	if (resultSet.next())
	{
		do
		{
			vtituloReportagem = resultSet.getString("descricao");
			vdataInicio = resultSet.getString("data_inicio");
			vdataFim = resultSet.getString("data_fim");
			vidArquivoHTML = resultSet.getString("id_arquivo");
			vid_conteudo = resultSet.getInt("id_conteudo");
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

varquivoHTML = gravar.gravar(vidArquivoHTML, vdiretorio, vusuario, vsenha);

if (!varquivoHTML.equals("erro"))
{
	File varquivo = new File(vdiretorio + "/" + varquivoHTML);
	//PreparaÃ§Ã£o para ler o arquivo
	StringBuffer contents = new StringBuffer();
	BufferedReader reader = null;

	reader = new BufferedReader(new FileReader(varquivo));
	String text = null;
 
	// LÃª o arquivo, substituindo as quebras de linha pela tag </br>
	while ((text = reader.readLine()) != null) {
	//Se no texto tiver as seguintes tags: <p>, <ul>, <li>, <h1>, <h2>, <h3>
	//nÃ£o Ã© necessÃ¡rio pular uma linha
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
	<legend>Manuten&ccedil;&atilde;o de Popup Internet</legend>
<form name="falteraReportagem" action="/gecoi.3.0/apps/popup/processa_alterar_reportagem.jsp" method="GET" target="rodapeAltera">

	<div id="data_publicacao">
    		<fieldset>
        <!-- campo 1 -->
                <legend>Data In&iacute;cio</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data Inicio" type="text" name="data_inicio" id="data_inicio" size="10" maxlength="10" value="<%=vdataInicio%>" required="required"/>
        	</fieldset>
     </div>
     <div id="data_publicacao">
    		<fieldset>
        <!-- campo 2 -->
                <legend>Data Fim</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data Fim" type="text" name="data_fim" id="data_fim" size="10" maxlength="10" value="<%=vdataFim%>" required="required"/>
        	</fieldset>
	    </div>
<div id="titulo_reportagem">
    		<fieldset>
        <!-- campo 3 -->
                <legend>T&iacute;tulo</legend>
				<input title="T&iacute;tulo da Reportagem" alt="T&iacute;tulo da Reportagem" type="text" name="tituloAlteraReportagem" id="tituloAlteraReportagem" value="<%=vtituloReportagem%>" required="required"/>
        	</fieldset>
	    </div>
        <div class="editar_arquivo">
      		<fieldset>
        	<legend>Editar Popup</legend>
             <div id="AlteraHtmlReportagem"><%=vtexto%></div>
             <!-- campo 4 -->
            	<textarea name="vtexto_altera" id="vtexto_altera" style="display:none"></textarea>
          </fieldset>
          <!-- campo 5 -->
		<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
        <!-- campo 6 -->
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
      </div>
      <div id="botao">
        	<!-- <input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" /> -->
         	<!--<input type="submit" name="gravar" id="gravar" value="Gravar" /> -->
            <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraReportagem();"  />
      </div>
</form>
</fieldset>
</div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
