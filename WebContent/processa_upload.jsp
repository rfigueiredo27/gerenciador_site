<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="br.jus.trerj.funcoes.*, java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, 
    org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,
    be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, 
    org.springframework.web.multipart.MultipartFile, org.springframework.webflow.execution.RequestContext "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Calendar c = Calendar.getInstance();
out.print("começo: "+c.getTime()+"<br>");


/*
UploadListener listener = new UploadListener(request, 30);
c = Calendar.getInstance();
out.print("passo 1: "+c.getTime()+"<br>");

FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
c = Calendar.getInstance();
out.print("passo 2: "+c.getTime()+"<br>");

ServletFileUpload upload = new ServletFileUpload(factory);
c = Calendar.getInstance();
out.print("passo 3: "+c.getTime()+"<br>");

List<FileItem> multiparts = null;
c = Calendar.getInstance();
out.print("passo 4: "+c.getTime()+"<br>");
*/
//multiparts = upload.parseRequest(request);

/*//File f = new File(multiparts.get(0).getName());
String nomearquivo = "";
nomearquivo = "sala_de_aula.jpg";
nomearquivo = "eclipse-jee-kepler-SR2-win32.zip";
File f = new File("d:\\temp\\" + nomearquivo);
UploadArquivo uploadArquivo = new UploadArquivo();
uploadArquivo.enviar(f);*/


//MultipartFile file = RequestContext().getRequestParameters().getRequiredMultipartFile("files[]");

/*if (file.getSize() > 0) { // writing file to a directory
File upLoadedfile = new File(uploadFolder+file.getOriginalFilename());

upLoadedfile.createNewFile();
FileOutputStream fos = new FileOutputStream(upLoadedfile);
fos.write(file.getBytes());
fos.close(); //setting the value of fileUploaded variable
*/
/*
c = Calendar.getInstance();
out.print("criar classe: "+c.getTime()+"<br>");
UploadArquivo uploadArquivo = new UploadArquivo();
//uploadArquivo.enviar(file);
c = Calendar.getInstance();
out.print("chamar classe: "+c.getTime()+"<br>");
//uploadArquivo.enviar(multiparts.get(0).getInputStream(), multiparts.get(0).getName());
//InputStream is = new FileInputStream("d:\\temp\\Café com Projetos_reduzido1.mp4");
InputStream is = new FileInputStream("d:\\temp\\eclipse-jee-kepler-SR2-win32.zip");
//uploadArquivo.enviar(is, "eclipse-jee-kepler-SR2-win32.zip");
c = Calendar.getInstance();
out.print("terminei"+c.getTime());

*/
/*
out.print(request.getParameterValues("tv")[0].lastIndexOf("\\"));
out.print(request.getParameterValues("tv")[0]);
String nomeArquivo = "";
UploadArquivo uploadArquivo = new UploadArquivo();
for (int i = 0; i < request.getParameterValues("tv").length; i++)
{
	
	nomeArquivo = request.getParameterValues("tv")[i].toString();
	nomeArquivo = nomeArquivo.substring(nomeArquivo.lastIndexOf("\\")+1);
	//out.print("<br>"+nomeArquivo);
	//uploadArquivo.enviar(new FileInputStream(request.getParameterValues("tv")[i].toString()), nomeArquivo);
	//out.print("<br>"+request.getParameterValues("tv")[i]);
}*/

UploadArquivo uploadArquivo = new UploadArquivo();
uploadArquivo.enviar(new FileInputStream("\\\\10.3.194.55\\d:\\temp\\1.jpg"), "1.jpg");
%>
</body>
</html>