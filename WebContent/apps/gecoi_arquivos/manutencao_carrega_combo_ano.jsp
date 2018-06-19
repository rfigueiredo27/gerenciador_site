
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>


<%
String vmsg  = "";  //mensagem para o usuário
String vsql  = "";  //instrução da consulta ao banco
String varea = "";  //id da área

//Se algum dado foi enviado
Enumeration e = request.getParameterNames();
if(e.hasMoreElements())
{
   //Recebe os parâmetros do formulário
   varea   =  request.getParameter("id");
      
   //Prepara as variáveis para o acesso ao banco
   Connection con;
   PreparedStatement pstm;
   ResultSet resultSet;
   
   try
   {
	 //Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);
   
     //seleciona os anos que tem arquivos cadastrados
     vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano FROM gecoi.conteudo c, gecoi.conteudo_area ca " +
            "WHERE c.id_conteudo=ca.id_conteudo AND ca.id_area=?" + 
			"order by 1 desc" ;

		  
     pstm = con.prepareStatement(vsql);
     pstm.setString(1,varea);
     resultSet = pstm.executeQuery();
     out.println("<select name='ano'>");
	 
	 if ( resultSet.next() )
     {
		do
		{
	       out.println("<option value='" + resultSet.getString("ano") + "'>" + resultSet.getString("ano") + "</option>");
		}while(resultSet.next());
	 }
	 else
	 {
	    out.println("<option>Não há arquivos</option>");
	 }

     out.println("</select>");

     resultSet.close(); 
 	 con.close();

   }
   catch (Exception ex)
   {
      out.println("<select name='ano'>");
      out.println("<option>"+ex.getMessage()+"</option>");
      out.println("</select>");
   }
}
%>

