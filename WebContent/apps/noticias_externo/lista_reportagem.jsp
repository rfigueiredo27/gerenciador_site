<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<link rel="stylesheet" type="text/css"
	href="/gecoi.3.0/apps/noticias_interno/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/noticias_interno/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/noticias_interno/DataTable/js/tabela.js"></script>

<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area1 = 2661;
int vid_area2 = 42;
int vid_area3 = 22;
String vano = (request.getParameter("ano") == null) ? "0" : request.getParameter("ano");
int vambiente = (request.getParameter("ambiente") == null) ? 0 : Integer.parseInt(request.getParameter("ambiente"));
%>
<script>
$(document).ready(tabela_dinamica);//id da tabela e a ordem que será exibido
//.ready(tabela_dinamica('gecoi2',"desc"));//id da tabela e a ordem que será exibido
</script>

<form name="flista">
<div class="dataTables_wrapper">
	<table id="documentos" class="display"><thead>
		<tr>
			<th scope="col" width="10%">Data de Publica&ccedil;&atilde;o</th>
			<th scope="col" width="10%">Local de Publica&ccedil;&atilde;o</th>
			<th scope="col" width="65%">Reportagem</th>
			<th scope="col" width="15%">A&Ccedil;&Otilde;ES</th>
		</tr>
        </thead>
        <tbody>
<% 
request.setCharacterEncoding("ISO-8859-1");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, to_char(data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data, " +
				   "decode(ca.id_area, 2661, 'Internet e Intranet', 42, 'Internet', 22, 'Intranet') as ambiente " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "and to_char(data_inicio_exib, 'yyyy') = ? AND aq.ordem = 0 ";
	if ( (vambiente == 42) || (vambiente == 22) )
		vsql = vsql + "AND ca.id_area in (?) ";
	else
		vsql = vsql + "AND ca.id_area in (?,?,?) ";
	vsql = vsql + "ORDER BY data_inicio_exib desc";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setString(1, vano);
	if ( (vambiente == 42) || (vambiente == 22) )
	{
		pstm.setInt(2, vambiente);
	}
	else
	{
		pstm.setInt(2, vid_area1);
		pstm.setInt(3, vid_area2);
		pstm.setInt(4, vid_area3);
	}
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
				
			out.print("<tr bgcolor=" + vcor + ">");
			out.print("	<td align='left'>" + resultSet.getString("data") + "</td>");
			out.print("	<td align='left'>" + resultSet.getString("ambiente") + "</td>");
			out.print("	<td align='left'>" + resultSet.getString("descricao") + "</td>");
			out.print("	<td align='center'><div class='divAcoes'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da reportagem'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/noticias_interno/manutencao_reportagem.jsp?idConteudo=" + resultSet.getString("id_conteudo") + "&ano=" + vano + "','resultado');\"  title='Manuten&ccedil;&atilde;o da Reportagem'><img id='reportagem" + resultSet.getString("id_arquivo") + "' name='reportagem" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' title='Exclus&atilde;o do reportagem'><img id='excluir" + resultSet.getString("id_arquivo") + "' name='excluir" + resultSet.getString("id_arquivo") + "'  src='/gecoi.3.0/img/excluir_cinza.png' width='22' height='22' onclick=\"excluir('" + resultSet.getString("id_conteudo") + "', '" + resultSet.getString("descricao") + "', top.document.fbusca);\" /></a></div></td>");
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
	</tbody>
    </table>
    </div>
</form>
