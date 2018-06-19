<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>


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
int vid_area4 = 2662;
vid_area4 = 1622;
String vano = (request.getParameter("ano") == null) ? "0" : request.getParameter("ano");
int vambiente = (request.getParameter("ambiente") == null) ? 0 : Integer.parseInt(request.getParameter("ambiente"));

%>
<script>
$(document).ready(tabela_dinamica);//id da tabela e a ordem que ser√° exibido
//.ready(tabela_dinamica('gecoi2',"desc"));//id da tabela e a ordem que ser√° exibido
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
request.setCharacterEncoding("UTF-8");

//Prepara as vari·veis para o acesso ao banco
Connection conexao = null;
PreparedStatement stm;
ResultSet rs;

try
{
	//Configurando a conex„o com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
	   conexao = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao, to_char(data_inicio_exib, 'dd/mm/yyyy hh24:mi') as data, " +
				   "decode(ca.id_area, 2661, 'Internet e Intranet', 42, 'Internet', 22, 'Intranet', 2662, 'Internet Externo') as ambiente " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "and to_char(data_inicio_exib, 'yyyy') = ? AND aq.ordem = 0 ";
	if ( (vambiente == 42) || (vambiente == 22) || (vambiente == 2662) )
		vsql = vsql + "AND ca.id_area in (?) ";
	else
		vsql = vsql + "AND ca.id_area in (?,?,?,?) ";
	vsql = vsql + "ORDER BY data_inicio_exib desc";
	PreparedStatement pstm = conexao.prepareStatement(vsql);
	pstm.setString(1, vano);
	if ( (vambiente == 42) || (vambiente == 22) || (vambiente == 2662) )
	{
		pstm.setInt(2, vambiente);
	}
	else
	{
		pstm.setInt(2, vid_area1);
		pstm.setInt(3, vid_area2);
		pstm.setInt(4, vid_area3);
		pstm.setInt(5, vid_area4);
	}
	rs = pstm.executeQuery();

	if ( rs.next() )
	{
		do 
		{
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
				
			out.print("<tr bgcolor=" + vcor + ">");
			out.print("	<td align='left'>" + rs.getString("data") + "</td>");
			out.print("	<td align='left'>" + rs.getString("ambiente") + "</td>");
			out.print("	<td align='left'>" + rs.getString("descricao") + "</td>");
			out.print("	<td align='center'><div class='divAcoes'><a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + rs.getString("id_arquivo") + "' target='_blank' title='Visualiza&ccedil;&atilde;o da reportagem'><img id='arquivo" + rs.getString("id_arquivo") + "' name='arquivo" + rs.getString("id_arquivo") + "' src='/gecoi.3.0/img/consulta.png' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' onclick=\"carregaPag('/gecoi.3.0/apps/noticias_interno/manutencao_reportagem.jsp?idConteudo=" + rs.getString("id_conteudo") + "&ano=" + vano + "','resultado');\"  title='Manuten&ccedil;&atilde;o da Reportagem'><img id='reportagem" + rs.getString("id_arquivo") + "' name='reportagem" + rs.getString("id_arquivo") + "' src='/gecoi.3.0/img/texto.jpg' onClick='' width='22' height='22' /></a>");
			
			out.print("<a href='#' title='Exclus&atilde;o do reportagem'><img id='excluir" + rs.getString("id_arquivo") + "' name='excluir" + rs.getString("id_arquivo") + "'  src='/gecoi.3.0/img/excluir_cinza.png' width='22' height='22' onclick=\"excluir('" + rs.getString("id_conteudo") + "', '" + rs.getString("descricao").replaceAll("'"," ").replaceAll("\""," ") + "', top.document.fbusca);\" /></a></div></td>");
			out.print("</tr>");
		}while (rs.next());
	}
	rs.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(conexao!=null && !conexao.isClosed())
		conexao.close();
}
%>
	</tbody>
    </table>
    </div>
</form>
