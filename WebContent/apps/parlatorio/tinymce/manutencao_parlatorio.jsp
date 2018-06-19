<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar,java.sql.*,java.io.*, java.util.*"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<script>

function atualizaTela()
{
	carregaPag("/gecoi.3.0/apps/parlatorio/lista_parlatorio.jsp","listaParlatorio");
}


function criticaParlatorio()
{
	critica_alteracao_parlatorio(document.faltparlatorio);
}

$(document).ready(function(){
});

<%
request.setCharacterEncoding("ISO-8859-1");
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
int vid_area = 13;
vid_area = 1622;
int vidConteudoAnt = 0;
int vidArquivoCapa = 0;
int vidArquivoPdf = 0;
String vedicao = "";
String vdata = "";
String vcaminho = "";
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT upper(aq.nome) as nome, aq.descricao, aq.id_arquivo, aq.id_conteudo, aq.ordem, " +
				   "to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data, co.observacao, aq.publicado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_conteudo = ?  " +
   				   "ORDER BY aq.publicado desc, aq.ordem ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			if (resultSet.getInt("ordem") == 0)
				vidArquivoPdf = resultSet.getInt("id_arquivo");
			else
				vidArquivoCapa = resultSet.getInt("id_arquivo");
			vedicao = resultSet.getString("publicado");
			vdata = resultSet.getString("data");
			vcaminho = resultSet.getString("observacao");
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
%>
</script>

    <form name="faltparlatorio" action="/gecoi.3.0/apps/parlatorio/processa_alterar_parlatorio.jsp" method="post" target="rodapeAltera" enctype="multipart/form-data">
        <div id="edicao_reportagem">
      		<fieldset>
        	<legend>Edi&ccedil;&atilde;o</legend>
    		<input type="text" name="edicao" id="edicao" value="<%=vedicao%>" onkeyup="SoNumero(event, this)" />
            </fieldset>
        </div>
        <div id="data_publicacao">
      		<fieldset>
        	<legend>Data da publica&ccedil;&atilde;o</legend>
    		<input title="Data da publica&ccedil;&atilde;o" alt="Data da publica&ccedil;&atilde;o" type="text" name="dataAlteraParlatorio" id="dataAlteraParlatorio" value="<%=vdata%>" size="10" maxlength="10" />
            </fieldset>
        </div>
        <div id="caminho_flipbook">
      		<fieldset>
        	<legend>Caminho do Flipbook</legend>
            <input type="text" name="caminho" id="caminho" value="<%=vcaminho%>"/>
            </fieldset>
        </div>
        <div id="arquivo_pdf">
      		<fieldset>
        	<legend>Arquivo PDF</legend>
            <input name="pdf" type="file" id="pdf" onchange="" >
            <% 
			if (vidArquivoPdf > 0) 
	            out.print("<a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoPdf + "' target='_blank' title='Visualiza&ccedil;&atilde;o do arquivo em PDF'><img id='arquivopdf' name='arquivopdf' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
            %>
            </fieldset>
        </div>
        <div id="imagem_capa">
      		<fieldset>
        	<legend>Imagem da Capa</legend>
            <input name="capa" type="file" id="capa" onchange="" >
            <% 
			if (vidArquivoCapa > 0) 
            	out.print("<a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoCapa + "' target='_blank' title='Visualiza&ccedil;&atilde;o da capa do Parlat&oacute;rio'><img id='arquivocapa' name='arquivocapa' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			%>
            </fieldset>
        </div>
   		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
   		<input type="hidden" id="idArquivoPdf" name="idArquivoPdf" value="<%=vidArquivoPdf%>" />
   		<input type="hidden" id="idArquivoCapa" name="idArquivoCapa" value="<%=vidArquivoCapa%>" />
      <div id="botao">
			<div id="campoArquivo4"></div>
			<div id="progressBar4" style="display: none;">
				<div id="theMeter4">
            		<div id="progressBarText4"></div>
                	<div id="progressBarBox4">
                		<div id="progressBarBoxContent4"></div>
               		</div>
            	</div>
         	</div>
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaParlatorio();"  />
      </div>
    </form>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="500" width="1000"></iframe> 