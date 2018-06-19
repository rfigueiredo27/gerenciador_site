<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, org.postgresql.Driver" %>
<%@include file="/jsp/conexao_pool_internauta.jsp"%>

<%

String vcod_consulta = request.getParameter("cod_consulta");
String vcategoria = "PJE";
String vsql_consulta = "";

try
{
    Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection(vbanco,vlogin,vsenha);

	String vsql = "SELECT SQL_CONSULTA FROM exterlink.consultas_externas WHERE categoria = ? AND COD_CONSULTA = ? ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setString(1, vcategoria);
	pstm.setString(2, vcod_consulta);
	resultSet = pstm.executeQuery();
	if (resultSet.next())
	{
		vsql_consulta = resultSet.getString("SQL_CONSULTA");        
        
		resultSet.close();
    }
}
catch (Exception ex) {
   out.print("Ocorreu o seguinte erro: " + ex.getMessage()); 
}
finally
{
 if(con!=null && !con.isClosed())
 con.close();	
}

Connection conexao = null;


//==============================POSTGRE=============================//

try
{
    String URL_POSTGRES = "jdbc:postgresql://";
	String IP = "pjebdrj.tse.jus.br:5444";
	String NOME_BANCO = "pje";
	String URL_DA_CONEXAO = URL_POSTGRES + IP + "/" + NOME_BANCO;
	String login = "consulta_tre";
	String senha = "consulta_tre";
	//String driver = "org.postgresql.Driver";
    Statement statement = null;
    ResultSet resultSet = null;
    Class.forName("org.postgresql.Driver");
	//con = DriverManager.getConnection(vbanco,vlogin,vsenha);
	conexao = (Connection)DriverManager.getConnection(URL_DA_CONEXAO , login , senha);

	PreparedStatement pstm = conexao.prepareStatement(vsql_consulta);
	resultSet = pstm.executeQuery();
	
	ResultSetMetaData rsmd = resultSet.getMetaData();  
    
	int numColumns = rsmd.getColumnCount();  
     
    for (int i=1; i<numColumns+1; i++) {  
       String columnName = rsmd.getColumnName(i);  
       String tableName = rsmd.getTableName(i);  
    }  
}
catch (Exception ex) {
	out.print("Ocorreu o seguinte erro: " + ex.getMessage()); 
	//con.rollback();
}
finally
{
    if(conexao!=null && !conexao.isClosed())
       conexao.close();	
}
%>   

