<%@ page language="java" import="java.sql.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>
<%
int vid_catalogo = 394;

String vid_conteudo = request.getParameter("idConteudo");

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
	String vsql = "delete from gecoi.conteudo_catalogo WHERE id_conteudo = ? and id_catalogo = ?";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1,Integer.parseInt(vid_conteudo));
	pstm.setInt(2,vid_catalogo);
	pstm.executeQuery();
	
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