<%
String vlogin    = (session.getAttribute("login")==null) ? "" : session.getAttribute("login").toString();
String vsenha    = (session.getAttribute("senha")==null) ? "" : session.getAttribute("senha").toString();
String vdominio  = (request.getHeader("Referer")==null) ? "-" : request.getHeader("Referer");

//Se a requisi��o n�o tiver origem no dom�nio do TRE-RJ, ou se o usu�rio n�o foi informado
//a aplica��o ir� redirecionar o usu�rio para a tela de login
if(vlogin.compareToIgnoreCase("")==0)
{
   //session.invalidate();
   response.sendRedirect("/gecoi.3.0/login/login.jsp?msg=A aplica��o foi encerrada. Por favor, entre com o seu usu�rio e senha novamente.");
}
%>