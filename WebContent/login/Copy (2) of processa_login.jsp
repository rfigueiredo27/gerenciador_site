<%@page import="br.jus.trerj.funcoes.ConectaGecoi"%>
<%
//Recebe os parâmetros do formulário
String vlogin = request.getParameter("name")==null ? "" : request.getParameter("name");
String vsenha = request.getParameter("password")==null ? "" : request.getParameter("password");

ConectaGecoi conectaGecoi = new ConectaGecoi();
String vmsg = conectaGecoi.conecta(vlogin, vsenha);
out.println(vmsg);
if (vmsg.equals("sucesso"))
{
	session.setAttribute("login",vlogin);
	session.setAttribute("senha",vsenha);
}
%>