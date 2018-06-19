<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, java.nio.charset.StandardCharsets" %>
<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<!-- CKEditor -->
<script src="/gecoi.3.0/scripts/ckeditor/ckeditor.js"></script>
<script>
function atualizaTela(pano)
{
	carregaPag("/gecoi.3.0/apps/prestacao_contas/lista.jsp?ano=" + pano,"resultado");
}


function criticaAlteraReportagem()
{
	critica_alteracao_reportagem(document.falteraReportagem);
}

</script>
<%

String vselecao = "";
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
String vano = request.getParameter("ano");
String edital = "";
String ano = "";
String prestacao = "";
String partido = "";
String vid_area = "";
String varquivoHTML = "";
String vidArquivoHTML = "";
int vedicao = 0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, to_char(data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data " +
            "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
            "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
            "AND aq.ordem = 0 AND aq.id_conteudo = ?";
PreparedStatement pstm = con.prepareStatement(vsql);
pstm.setInt(1, vid_conteudo);
resultSet = pstm.executeQuery();

if ( resultSet.next() )
{
	do 
	{
		String descricao[] = resultSet.getString("descricao").split("@@");
		edital = descricao[0];
		ano = descricao[1];
		prestacao = descricao[2];
		partido = descricao[3];
		vidArquivoHTML = resultSet.getString("id_arquivo");
		} while (resultSet.next());
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


//Parte que lê o arquivo HTML
GravarArquivo gravar = new GravarArquivo();
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vdiretorio = application.getRealPath("/") + "webtemp";
String vtexto = "";

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

<div id="altera_dados_prestacao">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados Prestação de Conta </legend>
<form name="faltera" action="/gecoi.3.0/apps/prestacao_contas/processa_alterar.jsp" method="post" target="rodapeAltera" enctype="multipart/form-data">
<div id="edital_ano">
		<fieldset>
			<legend>Edital/Ano</legend>
			<input title="Numero do Edital" alt="Numero do Edital" type="number" name="edital" id="edital" value="<%=edital%>"/><span id="personalizado">&nbsp;/</span>
			<input title="Ano do Edital" alt="Ano do Edital" type="number" name="ano" id="ano" value="<%=vano%>" required/>
		</fieldset>
	</div>
	
	<div id="prestacao_contas">
		<fieldset>
			<legend>Prestação de Contas</legend>
			<input title="Prestacao de contas" alt="Prestacao de contas" type="text" name="prestacao" id="prestacao" value="<%=prestacao%>" required/>
		</fieldset>
	</div>
	
	<div id="partido_politico">
		<fieldset>
			<legend>Partido Político</legend>
			<input title="Partido" alt="PPartido" type="text" name="partido" id="partido" value="<%=partido%>" />
		</fieldset>
	</div>
	
	<div id="editar_arquivo">
		<fieldset>
			<legend>Alteração do Texto<br></legend>
			<textarea name="vtexto_altera" id="vtexto_altera" required="required"><%=vtexto %></textarea>
			<script>
				//ClassicEditor.create(document.querySelector('#ckeditor_editor' )).then( editor => {console.log( editor );}).catch( error => {console.error( error );} );
            	CKEDITOR.replace('vtexto_altera');
            </script>
		</fieldset>
	</div>
	
	<input type="hidden" id="idArquivoHTML" name="idArquivoHTML" value="<%=vidArquivoHTML%>" />
	
	<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
	
	<div id="campoArquivo"></div>
	<div id="progressBar" style="display: none;">
		<div id="theMeter">
			<div id="progressBarText"></div>
			<div id="progressBarBox">
				<div id="progressBarBoxContent"></div>
			</div>
		</div>
	</div>
	<div id="botao">
		<input type="submit" name="gravar" id="gravar" value="Gravar" />
	</div>
</form>
</fieldset>
</div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="500" width="500"></iframe> 
