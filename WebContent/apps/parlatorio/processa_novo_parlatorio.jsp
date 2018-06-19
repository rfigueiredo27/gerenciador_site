<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("ISO-8859-1");
int vid_area = 2604;
String vdata = (request.getParameter("data") == null ? "" : request.getParameter("data"));
int vedicao = (request.getParameter("edicao") == null ? 0 : Integer.parseInt(request.getParameter("edicao")));
String retorno = "";

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "{call gecoi.g_proc_inc_arq_cont_inexist(?, ?, ?, ?, ";  // parametros do conteudo
	//vsql = vsql + "?, Sysdate, Add_Months(SYSDATE, 1), ";// parametros do conteudo_area
	vsql = vsql + "?, to_date(?, 'dd/mm/yyyy'), to_date(?, 'dd/mm/yyyy'), ";// parametros do conteudo_area
	//vsql = vsql + "?, ?, ?, ?)}"; // parametros do arquivo
	vsql = vsql + "Empty_Blob(), ?, ?, ?)}"; // parametros do arquivo
 	
	CallableStatement cs;
	cs = con.prepareCall(vsql);
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
	// variáveis da inclusão de conteudo
	cs.setString(2,"Edição nº " + vedicao + " do Jornal Parlatório"); //descricao
	cs.setString(3,""); //observacao
	//cs.setString(4,session.getAttribute("login").toString()); //usuario
	cs.setString(4,"gdebossa"); //usuario

	// variáveis da inclusão de conteudo_area
	cs.setInt(5, vid_area); //vid_area
	cs.setString(6, vdata); //data_inicio_exib
	cs.setString(7, vdata.substring(0,6) + (Integer.parseInt(vdata.substring(6,10)) + 1)); //data_fim_exib
					
	// variáveis da inclusão de arquivo
	/*File arquivo = new File(application.getRealPath("/") + "apps\\parlatorio\\vazio.txt");
	FileInputStream fis = new FileInputStream(arquivo);
	cs.setBinaryStream(8, fis, (int)arquivo.length());*/
	cs.setString(8,"");//extensao
	cs.setInt(9,0);//ordem
	cs.setInt(10,0);//publicado

	cs.execute();
	    			
	retorno = cs.getString(1);
	con.commit();
	out.print(retorno);
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