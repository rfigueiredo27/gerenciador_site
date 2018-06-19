<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%
try{
  //guarda nas variáveis os dados da página e do usuário que está acessando
  //serão utilizados pelo identifica_sessao.jsp
  String vpagina    = request.getServletPath();
  String vcliente   = request.getRemoteAddr();
  String vaplicacao = "Internet";

  Class.forName("oracle.jdbc.driver.OracleDriver");
  //con = DriverManager.getConnection(vbanco, vlogin, vsenha);
  con = ConnectionFactory.getConnection(identificador);
  
  statement = con.createStatement();
  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_module(module_name => '" + vaplicacao + "', action_name => '" + vpagina + "'); end;");
  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_client_info('" + vcliente + "'); end;");
  statement.close();
}
catch( SQLException sqlex){
    out.println("Não foi possível conectar ao banco. Por favor tente mais tarde.");  
}
catch (Exception ex)
{
   ////////////////////////////////////////////////////////////////////////////////////////////
   out.println("Não foi possível conectar ao banco. Ocorreu o seguinte erro: " + ex.toString());
  ///////////////////////////////////////////////////////////////////////////////////////////
}
finally
{
    if(con!=null && !con.isClosed())
       con.close();
}
%>