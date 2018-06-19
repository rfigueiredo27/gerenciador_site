<%@page import="br.jus.trerj.funcoes.GravarArquivo"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.*"%>

<script>
	
$(document).ready(function(){	
	top.inicia_editor('EditarHtml');
});

    function valida_arquivo(f)
    {
	    $("#vtexto").val($('#EditarHtml').summernote('code'));
		while($("#vtexto").val().indexOf(String.fromCharCode(8220))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8220),"&quot;"));	
		while($("#vtexto").val().indexOf(String.fromCharCode(8221))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8221),"&quot;"));
		while($("#vtexto").val().indexOf(String.fromCharCode(8216))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8216),"'"));
		while($("#vtexto").val().indexOf(String.fromCharCode(8217))>0)
			$("#vtexto").val($("#vtexto").val().replace(String.fromCharCode(8217),"'"));

        f.submit();
		zera_contador();
    }

</script>

<%

String vselecao = "";
// vid_conteudo =  135945;
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
int vid_arquivo = Integer.parseInt(request.getParameter("idArquivo"));

String varquivoHTML = "";
String vidArquivoHTML = "";
String vid_area = "";
String vDescricao = "";
try
{
	//Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				Connection con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data, " + 
					"aq.arquivo, aq.ordem, ca.id_area " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_conteudo = ? and aq.ordem = 0 " +
   				   "ORDER BY aq.ordem";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	ResultSet resultSet = pstm.executeQuery();
	if (resultSet.next())
	{
		do
		{
			vid_area = resultSet.getString("id_area");
			vidArquivoHTML = resultSet.getString("id_arquivo");
			vDescricao = resultSet.getString("descricao");
		} while (resultSet.next());
	}
	resultSet.close();
	pstm.close();
	con.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
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
<form name="arquivo" action="/gecoi.3.0/apps/gecoi_arquivos/processa_edicao_arquivo.jsp" method="post" target="rodape">
	<div id="editar_arquivo" style="text-align: left;">
		<h3>Editar Arquivo</h3>
		<div id="EditarHtml"><%=vtexto%></div>
	</div>
	<div style="display: none">
		<textarea name="vtexto" id="vtexto"></textarea>
	</div>
    <input type="hidden" name="idarquivo" value="<%=vidArquivoHTML%>" />
    <input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
    <input type="hidden" id="descricao" name="descricao" value="<%=vDescricao%>" />
    <input type="hidden" id="idArea" name="idArea" value="<%=vid_area%>" />
        
		<div id="botao">
		<input type="button" name="save" value="Grava alteracoes" onclick="valida_arquivo(this.form);" />
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
		</div>
	</form>
	<div id="mensagem_caixa"></div>
	<!--Usado para processar o arquivo-->
	<iframe name="rodape" frameborder="0" allowtransparency="yes"
		height="500" width="500"></iframe>
	<script>
	</script>
