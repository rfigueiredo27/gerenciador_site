<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
int vid_catalogo = 394;
%>

<h2>Selecione a reportagem do tipo fundo do ba&uacute;</h2>
<form name="flista">
	<table id="tb_gecoi"><thead>
		<tr>
			<th scope="col" width="5%" >Edi&ccedil;&atilde;o</th>
			<th scope="col" width="15%">Se&ccedil;&atilde;o</th>
			<th scope="col" width="32%">Reportagem</th>
			<th scope="col" width="37%">Resumo</th>
			<th scope="col" width="12%" colspan="3">A&Ccedil;&Otilde;ES</th>
		</tr></thead>
<% 
request.setCharacterEncoding("ISO-8859-1");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, co.observacao, aq.publicado, cc.descricao as resumo " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.conteudo_catalogo cc " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND aq.ordem = 0 " +
				   "and aq.id_conteudo = cc.id_conteudo and cc.id_catalogo = ? " +
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
			String[] vresumo = resultSet.getString("resumo").split("@@");
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
				
			out.print("<tr bgcolor=" + vcor + ">");
			out.print("	<td align='center'>" + resultSet.getString("publicado") + "</td>");
			out.print("	<td align='left'>" + resultSet.getString("observacao") + "</td>");
			out.print("	<td align='left'>" + vdescricao[0] + " - " + vdescricao[1] + "</td>");
			out.print("	<td align='left'>" + vresumo[1] + "</td>");
			out.print("	<td align='center'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da reportagem Fundo do Ba&uacute;'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
			out.print("<td align='center'><a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/parlatorio/manutencao_fundo.jsp?idConteudo=" + resultSet.getString("id_conteudo") + "&resumo=" + resultSet.getString("resumo") + "','listaFundo');\"  title='Manuten&ccedil;&atilde;o da Reportagem Fundo do Ba&uacute;'><img id='reportagem" + resultSet.getString("id_arquivo") + "' name='reportagem" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a></td>");
			out.print("<td align='center'><a href='#' title='Exclus&atilde;o do Fundo do Ba&uacute;'><img id='excluir" + resultSet.getString("id_arquivo") + "' name='excluir" + resultSet.getString("id_arquivo") + "'  src='/gecoi.3.0/img/excluir_cinza.png' width='22' height='22' onclick=\"excluirFundo('" + resultSet.getString("id_conteudo") + "', '" + vdescricao[0] + " - " + vdescricao[1] + "', 'Fundo');\" /></a></td>");
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
	</table>
</form>
