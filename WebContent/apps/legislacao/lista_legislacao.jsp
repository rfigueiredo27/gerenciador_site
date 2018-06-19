<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<link rel="stylesheet" type="text/css"
	href="/gecoi.3.0/apps/legislacao/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/legislacao/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/legislacao/DataTable/js/tabela.js"></script>

<%
String vcor       = "#ECECEC";  // zebra a tabela
String vano = (request.getParameter("ano") == null) ? "0" : request.getParameter("ano");
int vlegislacao = (request.getParameter("legislacao") == null) ? 0 : Integer.parseInt(request.getParameter("legislacao"));
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
			<th scope="col" width="10%">Norma</th>
			<th scope="col" width="65%">Assunto</th>
			<th scope="col" width="15%">A&Ccedil;&Otilde;ES</th>
		</tr>
        </thead>
        <tbody>
<% 
request.setCharacterEncoding("UTF-8");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(data_inicio_exib, 'dd/mm/yyyy') as data, ca.id_area " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo AND aq.ordem = 0 ";
	if (!vano.equals("0"))
		vsql = vsql + "and to_char(data_inicio_exib, 'yyyy') = ?  ";
	if (vlegislacao == 0)
		vsql = vsql + "and ca.id_area in (47,48,53,20,50,33,39,38,45,49,2631,46,2560,1747,90,65,44,2587,36,77,2434,2652,2502,76) ";
	else
		vsql = vsql + "and ca.id_area in (?)";
	vsql = vsql + "ORDER BY aq.descricao ";

	PreparedStatement pstm = con.prepareStatement(vsql);
	int contaParam = 1;
	if (!vano.equals("0"))
		pstm.setString(contaParam++,vano);
	if (vlegislacao != 0)
		pstm.setInt(contaParam++,vlegislacao);
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
			if (resultSet.getInt("id_area") == 50)
			{
				out.print("	<td align='left'>&Iacute;ndice de Normas</td>");
				out.print("	<td align='left'>" + resultSet.getString("descricao") + "</td>");
			}
			else
			{
				String[] adescricao = resultSet.getString("descricao").split("-",2);
				out.print("	<td align='left'>" + adescricao[0] + "</td>");
				out.print("	<td align='left'>" + adescricao[1] + "</td>");
			}
			out.print("	<td align='center'><div class='divAcoes'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da legisla&ccedil;&atilde;o'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/legislacao/manutencao_legislacao.jsp?idConteudo=" + resultSet.getString("id_conteudo") + "&ano=" + vano + "','resultado');\"  title='Manuten&ccedil;&atilde;o da legisla&ccedil;&atilde;o'><img id='legislacao" + resultSet.getString("id_arquivo") + "' name='legislacao" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/legislacao/alterar_arquivo.jsp?id=" + resultSet.getString("id_conteudo") + "&idArquivo=" + resultSet.getString("id_arquivo") + "&descricao=" + resultSet.getString("descricao") + "&anoBusca=" + vano + "&legislacaoBusca=" + vlegislacao + "','resultado');\" title='Substitui&ccedil;&atilde;o do arquivo'><img id='arquivo" + resultSet.getString("id_Conteudo") + "' name='arquivo" + resultSet.getString("id_Conteudo") + "' src='/gecoi.3.0/img/reverter.png' onclick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' title='Exclus&atilde;o do legisla&ccedil;&atilde;o'><img id='excluir" + resultSet.getString("id_arquivo") + "' name='excluir" + resultSet.getString("id_arquivo") + "'  src='/gecoi.3.0/img/excluir_cinza.png' width='22' height='22' onclick=\"excluir('" + resultSet.getString("id_conteudo") + "', '" + resultSet.getString("descricao") + "', top.document.fbusca);\" /></a></div></td>");
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
