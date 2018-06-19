<%@ page language="java" import="java.sql.*,java.io.*, java.util.*" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<%
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 13;
vid_area = 1622;
int vidConteudoAnt = 0;
int vidArquivoCapa = 0;
int vidArquivoWord = 0;
int vidArquivoPdf = 0;
String vedicao = "";
String vdata = "";
String vcaminho = "";
String vidConteudo = "";
String vdescricaoAnt = "";
%>

<h2>Selecione o Parlat&oacute;rio</h2>
<form name="flista">
	<table id="tb_gecoi"><thead>
		<tr>
			<th scope="col" >Edi&ccedil;&atilde;o</th>
			<th scope="col" >Publica&ccedil;&atilde;o</th>
			<th scope="col" >Caminho do Flipbook</th>
			<th scope="col"  colspan="4">A&Ccedil;&Otilde;ES</th>
		</tr></thead>
<% 

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT upper(aq.nome) as nome, aq.descricao, aq.id_arquivo, aq.id_conteudo, aq.ordem, " +
				   "to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data, co.observacao, aq.publicado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=?  " +
   				   "ORDER BY aq.publicado desc, aq.ordem ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		vidConteudoAnt = resultSet.getInt("id_conteudo");
		do 
		{
			if (vidConteudoAnt == resultSet.getInt("id_conteudo"))
			{
				if (resultSet.getInt("ordem") == 0)
					vidArquivoPdf = resultSet.getInt("id_arquivo");
				else
					if (resultSet.getInt("ordem") == 1)
						vidArquivoWord = resultSet.getInt("id_arquivo");
					else
						vidArquivoCapa = resultSet.getInt("id_arquivo");
				vedicao = resultSet.getString("publicado");
				vdata = resultSet.getString("data");
				vcaminho = resultSet.getString("observacao");
				vidConteudo = resultSet.getString("id_conteudo");
				vdescricaoAnt = resultSet.getString("descricao");
			}
			else
			{
				vidConteudoAnt = resultSet.getInt("id_conteudo");
				String[] vdescricao = vdescricaoAnt.split("@@");
				if (vcor.equals(""))
					vcor="#ECECEC";
				else
					vcor="";    
					
				out.print("<tr bgcolor=" + vcor + ">");
				out.print("	<td align='center'>" + vedicao + "</td>");
				out.print("	<td align='left'>" + vdata + "</td>");
				out.print("	<td align='left'>" + vcaminho + "</td>");
				if (vidArquivoCapa > 0)
					out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoCapa + "' target='_blank' title='Visualiza&ccedil;&atilde;o da Capa do Parlat&oacute;rio'><img id='capa" + vidArquivoCapa + "' name='capa" + vidArquivoCapa + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
				else
					out.print("	<td></td>");
				if (vidArquivoPdf > 0)
					out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoPdf + "' target='_blank' title='Visualiza&ccedil;&atilde;o do Arquivo em PDF'><img id='pdf" + vidArquivoPdf + "' name='pdf" + vidArquivoPdf + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
				else
					out.print("	<td></td>");
				if (vidArquivoWord > 0)
					out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoWord + "' target='_blank' title='Visualiza&ccedil;&atilde;o do Arquivo em WORD'><img id='word" + vidArquivoWord + "' name='word" + vidArquivoWord + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
				else
					out.print("	<td></td>");
				out.print("<td><a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/parlatorio/manutencao_parlatorio.jsp?idConteudo=" + vidConteudo + "','listaParlatorio');\"  title='Manuten&ccedil;&atilde;o da Reportagem Fundo do Ba&uacute;'><img id='reportagem" + vidArquivoPdf + "' name='reportagem" + vidArquivoPdf + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a></td>");
				out.print("</tr>");
				vidArquivoPdf = 0;
				vidArquivoWord = 0;
				vidArquivoCapa = 0;
				vedicao = "";
				vdata = "";
				vcaminho = "";
				vidConteudo = "";
				vdescricaoAnt = "";				
				if (resultSet.getInt("ordem") == 0)
					vidArquivoPdf = resultSet.getInt("id_arquivo");
				else
					if (resultSet.getInt("ordem") == 1)
						vidArquivoWord = resultSet.getInt("id_arquivo");
					else
						vidArquivoCapa = resultSet.getInt("id_arquivo");
				vedicao = resultSet.getString("publicado");
				vdata = resultSet.getString("data");
				vcaminho = resultSet.getString("observacao");
				vidConteudo = resultSet.getString("id_conteudo");
				vdescricaoAnt = resultSet.getString("descricao");
			}
		}while (resultSet.next());
		String[] vdescricao = vdescricaoAnt.split("@@");
		if (vcor.equals(""))
			vcor="#ECECEC";
		else
			vcor="";    
					
		out.print("<tr bgcolor=" + vcor + ">");
		out.print("	<td align='center'>" + vedicao + "</td>");
		out.print("	<td align='left'>" + vdata + "</td>");
		out.print("	<td align='left'>" + vcaminho + "</td>");
		if (vidArquivoCapa > 0)
			out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoCapa + "' target='_blank' title='Visualiza&ccedil;&atilde;o da Capa do Parlat&oacute;rio'><img id='capa" + vidArquivoCapa + "' name='capa" + vidArquivoCapa + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
		else
			out.print("	<td></td>");
		if (vidArquivoPdf > 0)
			out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoPdf + "' target='_blank' title='Visualiza&ccedil;&atilde;o do Arquivo em PDF'><img id='pdf" + vidArquivoPdf + "' name='pdf" + vidArquivoPdf + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
		else
			out.print("	<td></td>");
		if (vidArquivoWord > 0)
			out.print("	<td><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + vidArquivoWord + "' target='_blank' title='Visualiza&ccedil;&atilde;o do Arquivo em WORD'><img id='word" + vidArquivoWord + "' name='word" + vidArquivoWord + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a></td>");
		else
			out.print("	<td></td>");
		out.print("<td><a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/parlatorio/manutencao_parlatorio.jsp?idConteudo=" + vidConteudo + "','listaParlatorio');\"  title='Manuten&ccedil;&atilde;o da Reportagem Fundo do Ba&uacute;'><img id='reportagem" + vidArquivoPdf + "' name='reportagem" + vidArquivoPdf + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a></td>");
		out.print("</tr>");
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
