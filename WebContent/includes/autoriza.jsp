<%
String vlogin    = (session.getAttribute("login")==null) ? "" : session.getAttribute("login").toString();
String vsenha    = (session.getAttribute("senha")==null) ? "" : session.getAttribute("senha").toString();
String vdominio  = (request.getHeader("Referer")==null) ? "-" : request.getHeader("Referer");

//Se a requisiзгo nгo tiver origem no domнnio do TRE-RJ, ou se o usuбrio nгo foi informado
//a aplicaзгo irб redirecionar o usuбrio para a tela de login
if(vlogin.compareToIgnoreCase("")==0)
{
   //session.invalidate();
   response.sendRedirect("/gecoi.3.0/login/login.jsp?msg=A aplicaзгo foi encerrada. Por favor, entre com o seu usuбrio e senha novamente.");
}
%>