<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%

request.setCharacterEncoding("ISO-8859-1");
int vidcatalogo = 394;
int vid_conteudo = Integer.parseInt(request.getParameter("idconteudo"));
String vresumo = request.getParameter("resumoAlteraFundo");
String vdata = request.getParameter("dataResumo");

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "update gecoi.conteudo_catalogo set descricao = ? where id_conteudo = ? and id_catalogo = ? ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setString(1, vdata + "@@" + vresumo);
	pstm.setInt(2, vid_conteudo);
	pstm.setInt(3, vidcatalogo);
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