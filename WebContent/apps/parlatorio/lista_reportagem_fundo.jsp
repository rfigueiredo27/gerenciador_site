<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/gecoi.3.0/scripts/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/scripts/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/scripts/DataTable/js/start_table.js"></script>
<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
int vid_catalogo = 394; // catálogo do fundo do baú
//int vid_conteudo = Integer.parseInt((request.getParameter("idconteudo")==null) ? "0" : request.getParameter("idconteudo"));
%>
<script>
$(document)
.ready(tabela_dinamica('gecoi3',"desc"));//id da tabela e a ordem que será exibido
</script>
<h2>Selecione a reportagem para inclus&atilde;o no Fundo do Ba&uacute;</h2>
<form name="flista">
	<div class="dataTables_wrapper">
	<table id="gecoi3" class="display"><thead>
		<tr>
			<th scope="col" width="5%">Edi&ccedil;&atilde;o</th>
			<th scope="col" width="15%">Se&ccedil;&atilde;o</th>
			<th scope="col" width="65%">Reportagem</th>
			<th scope="col" width="15%">A&Ccedil;&Otilde;ES</th>
		</tr></thead>
        <tbody>
<% 
request.setCharacterEncoding("ISO-8859-1");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, co.observacao, aq.publicado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND aq.ordem = 0 " +
				   "and aq.id_conteudo not in (select id_conteudo from gecoi.conteudo_catalogo where id_catalogo = ?) " +
   				   "ORDER BY aq.publicado desc, aq.descricao";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	pstm.setInt(2, vid_catalogo);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			String[] vdescricao = resultSet.getString("descricao").split("@@");
			//String vtitulo =   vdescricao[0] + " - " + vdescricao[1] ;
				String vtitulo =    new String((vdescricao[0] + " - " + vdescricao[1]).getBytes("UTF-8"), "ISO-8859-1") ;
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
				
			out.print("<tr bgcolor=" + vcor + ">");
			out.print("	<td align='center'>" + resultSet.getString("publicado") + "</td>");
			out.print("	<td align='left'>" + resultSet.getString("observacao") + "</td>");
			out.print("	<td align='left'>" + vdescricao[0] + " - " + vdescricao[1] + "</td>");
			out.print("	<td align='center'><div class='divAcoes'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da reportagem'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/parlatorio/incluir_fundo.jsp?titulo=" + vtitulo + "&idConteudo=" + resultSet.getString("id_conteudo") + "','novo_fundo');\"  title='Inclus&atilde;o do Fundo do Ba&uacute;'><img id='reportagem" + resultSet.getString("id_arquivo") + "' name='reportagem" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/marcado.png' onClick='' width='22' height='22' /></a><div></td>");
			out.print("</tr>");
		}while (resultSet.next());
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
	<tbody>
    </table>
</form>
