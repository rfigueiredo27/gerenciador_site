<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

</head>

<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/pt_BR/sdk.js#xfbml=1&version=v2.10";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<%
String vlink = request.getParameter("link");
String vnome = request.getParameter("nome");
String vtitulo = request.getParameter("titulo");
String vid = request.getParameter("id");
//vlink = "https://www.facebook.com/arquivei/videos/1102549003110680/";
//vlink = "https://www.facebook.com/tastydemais/videos/2031644223779239/";
%>
<p>Inscri&ccedil;&atilde;o: <%=vid%></p>
<p>Nome: <%=vnome%></p>
<p>T&iacute;tulo: <%=vtitulo%></p>
<div class="fb-video" data-href="<%=vlink%>" data-width="500" data-show-text="false">
 <blockquote cite="<%=vlink%>" class="fb-xfbml-parse-ignore">
<!--		<a href="https://www.facebook.com/facebook/videos/10153231379946729/">How to Share With Just Friends</a>
		<p>How to share with just friends.</p>Publicado por <a href="https://www.facebook.com/facebook/">Facebook</a> em Sexta, 5 de dezembro de 2014-->
	</blockquote>
</div>

</body>
</html>