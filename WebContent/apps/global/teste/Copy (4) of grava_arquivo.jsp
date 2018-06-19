<%@ page import="java.io.*,java.sql.*,java.util.*" %>

<%
String vbanco = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rjdbs03.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=ursa)(SERVER=SHARED)))";
String varquivo = request.getParameter("idarquivo");

String [] tipos = new String [23];
tipos[0] = "application/msword";             //Microsoft Word document
tipos[1] = "application/pdf";                //Acrobat (.pdf) file
tipos[2] = "application/vnd.ms-excel";       //Excel spreadsheet
tipos[3] = "application/vnd.ms-powerpoint";  //Powerpoint presentation
tipos[4] = "application/zip";                //Zip archive
tipos[5] = "audio/basic";                    //Sound file in .au or .snd format
tipos[6] = "audio/x-aiff";                   //AIFF sound file
tipos[7] = "audio/x-wav";                    //Microsoft Windows sound file
tipos[8] = "audio/midi";                     //MIDI sound file
tipos[9] = "text/html";                      //HTML document
tipos[10] = "text/plain";                    //Plain text
tipos[11] = "text/xml";                      //XML document
tipos[12] = "image/gif";                     //GIF image
tipos[13] = "image/jpeg";                    //JPEG image
tipos[14] = "image/png";                     //PNG image
tipos[15] = "image/tiff";                    //TIFF image
tipos[16] = "video/mpeg";                    //MPEG video clip
tipos[17] = "video/quicktime";               //QuickTime video clip
tipos[18] = "video/avi";                     //AVI v�deo
tipos[19] = "audio/mpeg";  	                 //�udio MPEG mp3
tipos[20] = "application/rtf"; 	             //Rich Text Format (RTF)
tipos[21] = "audio/x-ms-wma";  	             //Windows Media Audio (WMA)
tipos[22] = "application/x-shockwave-flash"; //Anima��o Flash

String [] extensao = new String [23];
extensao[0] = "doc";        //Microsoft Word document
extensao[1] = "pdf";        //Acrobat (.pdf) file
extensao[2] = "xls";        //Excel spreadsheet
extensao[3] = "ppt,pps";    //Powerpoint presentation
extensao[4] = "zip";        //Zip archive
extensao[5] = "au,snd";     //Sound file in .au or .snd format
extensao[6] = "aiff";       //AIFF sound file
extensao[7] = "wav";        //Microsoft Windows sound file
extensao[8] = "midi";       //MIDI sound file
extensao[9] = "html";       //HTML document
extensao[10] = "txt";       //Plain text
extensao[11] = "xml";       //XML document
extensao[12] = "gif";       //GIF image
extensao[13] = "jpeg,jpg";  //JPEG image
extensao[14] = "png";       //PNG image
extensao[15] = "tiff";      //TIFF image
extensao[16] = "mpeg,mpg";  //MPEG video clip
extensao[17] = "mov";       //QuickTime video clip
extensao[18] = "avi";       //AVI v�deo
extensao[19] = "mp3";  	    //�udio MPEG
extensao[20] = "rtf";  	    //Rich Text Format (RTF)
extensao[21] = "wma";  	    //Windows Media Audio (WMA)
extensao[22] = "swf";       //Anima��o Flash

Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + vbanco,"internauta","internauta");

String query = "select arquivo, nome, dbms_lob.getlength(arquivo) as tamanho, 'arquivos/jsp/download_arquivo.jsp' as lixo from gecoi.arquivo where id_arquivo=" + varquivo;        

Statement st = con.createStatement();

ResultSet rs = st.executeQuery(query);
rs.next();

String vtamanho  = rs.getString("tamanho");
String vtipo     = "";
String vdownload = (request.getParameter("iddownload")==null) ? "" : request.getParameter("iddownload");
String vnome     = rs.getString("nome").toLowerCase();
String vextensao = vnome.substring(vnome.length()-3, vnome.length());


byte[] bytearray = new byte[4096];
int size=0;
InputStream arquivo; 
arquivo = rs.getBinaryStream(1);

//tipo do arquivo
for (int i=0; i<tipos.length; i++)
{
     if( extensao[i].indexOf(vextensao) != -1 )
	 {
		 vtipo = tipos[i];
	 }
}
System.out.println(vtipo);
response.reset();
System.out.println("1");
if (vdownload.compareToIgnoreCase("0")==0)
{
   response.setContentType("application/octet-stream");
   response.addHeader("Content-Disposition","attachment; filename=" + vnome);
}
else
{
  if (vtipo.compareToIgnoreCase("")==0)
    {
      response.setContentType("application/octet-stream");
      response.addHeader("Content-Disposition","attachment; filename=" + vnome);
    }
	
  else
    {
      response.setContentType(vtipo);
      response.addHeader("Content-Disposition","inline; filename=" + vnome);   
    }

}
System.out.println("2");
response.addHeader("Content-Length", vtamanho);
System.out.println("3");
while((size=arquivo.read(bytearray))!= -1 ) 
{
   response.getOutputStream().write(bytearray,0,size);
}
System.out.println("4");
response.flushBuffer();
arquivo.close();
rs.close();
con.close();
System.out.println("5");

%>
