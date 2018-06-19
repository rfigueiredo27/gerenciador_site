<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
%>

<h2>Selecione a reportagem para inclu&iacute;-la na TV</h2>
<form name="flista">
	<table id="tb_gecoi"><thead>
		<tr>
			<th scope="col" width="15%">Se&ccedil;&atilde;o</th>
			<th scope="col" width="70%">Reportagem</th>
			<th scope="col" width="10%" colspan="2">A&Ccedil;&Otilde;ES</th>
			<th scope="col" width="5%">Selecionado</th>
		</tr></thead>
<% 

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

/*	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, Decode(ordem, 1 , 999, ordem) AS ordem " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND Nvl(co.observacao,' ') <> 'PUBLICADO' and aq.ordem > 0 " +
   				   "ORDER BY ordem, aq.descricao";*/
	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, " +
				   "(SELECT id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = aq.id_arquivo) AS selecionado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND Nvl(co.observacao,' ') <> 'PUBLICADO' and aq.ordem = 1 " +
   				   "ORDER BY aq.descricao";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			String[] vdescricao = resultSet.getString("descricao").split("@@");
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
				
			out.print("<tr bgcolor=" + vcor + ">");
			out.print("	<td align='left'>" + vdescricao[0] + "</td>");
			out.print("	<td align='left'>" + vdescricao[1] + "</td>");
			out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da not&iacute;cia'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
			out.print("<td><a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/parlatorio/manutencao_item_tv.jsp?reportagem=" + resultSet.getString("descricao") + "&idarquivo=" + resultSet.getString("id_arquivo") + "&idconteudo=" + resultSet.getString("id_conteudo") + "','divtv');\"  title='Manuten&ccedil;&atilde;o da TV'><img id='tv" + resultSet.getString("id_arquivo") + "' name='tv" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a></td>");
			out.print("<td>");
			if (resultSet.getInt("selecionado") > 0)
				out.print("<img src='/gecoi.3.0/img/checked.jpg' width='22' height='22' />");
			out.print("</td>");
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
<div id="divbusca"></div>
