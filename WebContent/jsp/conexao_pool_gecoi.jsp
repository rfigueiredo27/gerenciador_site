<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%
//informa ao banco oracle que deve ser utilizado um pool de conexões
Connection con = null;
Statement statement = null;
ResultSet resultSet = null;
int identificador = 1;



//producao
//String vbanco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";
ConnectionFactory connectionFactory = new ConnectionFactory();

///////////////////////////////////////////////

//producao
/*String vbanco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";
String vlogin =	"gecoi_consulta";
String vsenha = "snhgc";
*/
//////////////////////////////////////////////////////////

//desenv
//vbanco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rjdbs03.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=ursa)))";

String vraiz  = "site/";

%>
<%@include file="/jsp/identifica_sessao.jsp"%>