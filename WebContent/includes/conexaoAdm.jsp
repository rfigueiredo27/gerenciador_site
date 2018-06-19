<%
//Prepara as variáveis para o acesso ao banco
Connection con = null;
Statement statement =  null;
PreparedStatement pstm = null;
ResultSet resultSet = null;
String vsql = "";
String vbanco = "";
String vmsg = "";
String vraiz = "/gecoi.3.0";

try {
  //informa ao banco oracle que deve ser utilizado um pool de conexões
  vbanco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";

  if (vlogin.compareToIgnoreCase("")!=0)
  {	
     //seleciona os dados no banco
     Class.forName("oracle.jdbc.driver.OracleDriver");
     con = DriverManager.getConnection(vbanco,vlogin,vsenha);
  }

  //guarda nas variáveis os dados da página e do usuário que está acessando
  //serão utilizados pelo identifica_sessao.jsp
  String vpagina    = request.getServletPath();
  String vcliente   = request.getRemoteAddr();
  String vaplicacao = "gecoi.3.0";
  
  if (vlogin.compareToIgnoreCase("")!=0)
  {	
     statement = con.createStatement();
     statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_module(module_name => '" + vaplicacao + "', action_name => '" + vpagina + "'); end;");
     statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_client_info('" + vcliente + "'); end;");
     statement.close();
  }

}
catch (SQLException ex){

  vmsg = "Ocorreu um erro no Banco: " + ex.getMessage();
  
  if(ex.getMessage().indexOf("ORA-01017")==0)
     vmsg = "Acesso negado, usuário/senha inválidos.";

  if(ex.getMessage().indexOf("ORA-28000")==0)
     vmsg = "Acesso negado, usuário bloqueado.";
  
  if(ex.getMessage().indexOf("Listener")==0)
     vmsg = "A conexão com o banco falhou (TSN listener), favor reportar o erro à Seção de Administração de Banco de Dados - SEABAD.";	   
}
finally
{
  if(con!=null && !con.isClosed())
     con.close();
} 
%>