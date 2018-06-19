<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("ISO-8859-1");
int vcatalogo = 394;
int vid_conteudo = Integer.parseInt(request.getParameter("idconteudo"));
String vresumo = request.getParameter("resumoFundo");

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "insert into gecoi.conteudo_catalogo values (?,?,To_Char(SYSDATE,'yyyy_mm_dd hh24:mi:ss') || ?) ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	pstm.setInt(2, vcatalogo);
	pstm.setString(3, "@@" + vresumo);
	resultSet = pstm.executeQuery();

	out.print("<script>top.atualizaTelaFundo();</script>");
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