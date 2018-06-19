<%@ page language="java" import="java.sql.*,java.io.*, java.util.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<link rel="stylesheet" type="text/css" href="/gecoi.3.0/scripts/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript" src="/gecoi.3.0/scripts/DataTable/js/jquery.dataTables.js"></script>
<noscript><p>Seu navegador não suporta a execução de scripts ou está que está função desabilitada.</p></noscript>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/inscricoes_cre/scripts/tabela.js"></script>
<noscript><p>Seu navegador não suporta a execução de scripts ou está que está função desabilitada.</p></noscript>

<%
String vcor       = "#ECECEC";  // zebra a tabela
%>

<h2>Selecione a reportagem do tipo fundo do ba&uacute;</h2>
<div class='dataTables_wrapper'>
	<table id='tabela_dinamica' class='display'><thead>
		<tr>
			<th scope="col" >Inscri&ccedil;&atilde;o</th>
			<th scope="col" >Nome</th>
			<th scope="col" >T&iacute;tulo</th>
			<th scope="col" >Data da Inscri&ccedil;&atilde;o</th>
			<th scope="col" >Identidade</th>
			<th scope="col" >CPF</th>
			<th scope="col" >Telefone</th>
			<th scope="col" >Celular</th>
			<th scope="col" >E-Mail</th>
			<th scope="col" >V&iacute;deo</th>
		</tr></thead><tbody>
<% 

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "Select id_video, to_char(dt_inscricao,'dd/mm/yyyy') as dt_inscricao, inscricao, nome, titulo_eleitor, tipo_identdd, numero_identdd, cpf, telefone, celular, email, link_video " +
				"from convide.videos order by id_video ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	//pstm.setInt(1, vid_area);
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
				out.print("	<td align='left'>" + resultSet.getString("id_video") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("nome") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("titulo_eleitor") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("dt_inscricao") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("tipo_identdd") + " - " + resultSet.getString("numero_identdd") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("cpf") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("telefone") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("celular") + "</td>");
				out.print("	<td align='left'>" + resultSet.getString("email") + "</td>");
				out.print("<td><a href='/gecoi.3.0/apps/inscricoes_cre/mostra_video.jsp?link=" + resultSet.getString("link_video") + "&id=" + resultSet.getString("id_video") + "&nome=" + resultSet.getString("nome") + "&titulo=" + resultSet.getString("titulo_eleitor") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da reportagem'><img id='arquivo" + resultSet.getString("id_video") + "' name='arquivo" + resultSet.getString("id_video") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
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
