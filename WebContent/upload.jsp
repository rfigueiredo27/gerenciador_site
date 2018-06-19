<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="/gecoi.3.0/scripts/browser-detect.min.js"></script>
<script>
	alert(BrowserDetect.OS);
	alert(BrowserDetect.browser);
	alert(BrowserDetect.version);
	alert(navigator.appName);
	navigator.
	 /*if (navigator.userAgent.search("MSIE") & gt; = 0) {
	        alert("IE");
	    }*/
</script>

</head>
<body>
<!-- <form action="processa_upload.jsp" method="post" enctype="multipart/form-data">-->
<form action="processa_upload.jsp" method="post" >
<input name="tv" type="file" id="tv" onchange="alert(this.value);" multiple="multiple" >
<!-- webkitdirectory -->
<input type="submit" name="gravar" id="gravar" value="Gravar" />
</form>
</body>
</html>