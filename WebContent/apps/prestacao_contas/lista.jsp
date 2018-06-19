<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<link rel="stylesheet" type="text/css" href="/gecoi.3.0/apps/prestacao_contas/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/prestacao_contas/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/prestacao_contas/DataTable/js/tabela.js"></script>

<%
String vano = (request.getParameter("ano") == null) ? "0" : request.getParameter("ano");
vano = "2018";
int varea = 2694;

%>

<form name="flista">
<div class="dataTables_wrapper">
	<table id="documentos" class="display"><thead>
		<tr>
			<th scope="col" width="10%">Edital</th>
			<th scope="col" width="30%">Prestação de Contas</th>
			<th scope="col" width="30%">Partido</th>
			<th scope="col" width="15%">A&Ccedil;&Otilde;ES</th>
			<th scope="col" width="15%">Arquivo(s) PDF</th>
		</tr>
        </thead>
        <tbody>
<% 
request.setCharacterEncoding("UTF-8");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, to_char(data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "and to_char(data_inicio_exib, 'yyyy') = ? AND aq.ordem = 0 AND ca.id_area=? ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setString(1, vano);
	pstm.setInt(2, varea);
	resultSet = pstm.executeQuery();

	if ( resultSet.next() )
	{
		do 
		{
			String descricao[] = resultSet.getString("descricao").split("@@");
			String edital = descricao[0];
			String ano = descricao[1];
			String prestacao = descricao[2];
			String partido = descricao[3];
			
			String edital_completo = edital+"/"+ano;
				
			out.print("<tr>");
			out.print("	<td align='left'>" + edital + "</td>");
			out.print("	<td align='left'>" + prestacao  + "</td>");
			out.print("	<td align='left'>" + partido + "</td>");
			
			out.print("	<td align='center'><div class='divAcoes'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + resultSet.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o do texto'><img id='arquivo" + resultSet.getString("id_arquivo") + "' name='arquivo" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/prestacao_contas/manutencao.jsp?idConteudo=" + resultSet.getString("id_conteudo") + "&ano=" + vano + "','resultado');\"  title='Alteração dos dados principais'><img id='reportagem" + resultSet.getString("id_arquivo") + "' name='prestacao" + resultSet.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' title='Exclus&atilde;o da Prestação de Conta'><img id='excluir" + resultSet.getString("id_arquivo") + "' name='excluir" + resultSet.getString("id_arquivo") + "'  src='/gecoi.3.0/img/excluir_cinza.png' width='22' height='22' onclick=\"excluir('" + resultSet.getString("id_conteudo") + "', '" + edital + "', top.document.fbusca);\" /></a></div></td>");
						
			out.print("<td align='left'><a href='#' class='btn btn-default' onclick=\"carregaPag('/gecoi.3.0/apps/prestacao_contas/alterar_anexo.jsp?idConteudo=" + resultSet.getString("id_conteudo") + "&ano=" + vano + "&edital=" + edital_completo +"','resultado');\"  title='Alteração do(s) Arquivo(s) PDF'>Acessar</a></td>");
			
			
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
