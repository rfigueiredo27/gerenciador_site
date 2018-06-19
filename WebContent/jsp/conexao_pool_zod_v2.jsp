<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%
//informa ao banco oracle que deve ser utilizado um pool de conexões
Connection con = null;
Statement statement = null;
ResultSet resultSet = null;
int identificador = 4;
ConnectionFactory connectionFactory = new ConnectionFactory();
%>
