<%@page import="br.jus.trerj.funcoes.GravarArquivo, java.io.*,java.util.*"%>
<%
	String vidArquivo = request.getParameter("idarquivo");
	String vusuario = session.getAttribute("login").toString();
	String vdiretorio = application.getRealPath("/") + "webtemp";
	//out.print(application.getContextPath()); //gecoi.3.0
	//out.print(request.getLocalName()); //gecoi.3.0
	//out.print(request.getServerName()); //localhost
	
	GravarArquivo gravar = new GravarArquivo();
	//String vlink = gravar.gravar(vidArquivo, vdiretorio, vusuario);
	//vlink = "/gecoi.3.0/webtemp/" + vlink;
	//String vextensao = "jpg";
	//String vextensao = vlink.substring(vlink.length()-3, vlink.length());
	
	
	//String varquivo = request.getParameter("idarquivo");

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
	tipos[18] = "video/avi";                     //AVI vídeo
	tipos[19] = "audio/mpeg";  	                 //Áudio MPEG mp3
	tipos[20] = "application/rtf"; 	             //Rich Text Format (RTF)
	tipos[21] = "audio/x-ms-wma";  	             //Windows Media Audio (WMA)
	tipos[22] = "application/x-shockwave-flash"; //Animação Flash

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
	extensao[18] = "avi";       //AVI vídeo
	extensao[19] = "mp3";  	    //Áudio MPEG
	extensao[20] = "rtf";  	    //Rich Text Format (RTF)
	extensao[21] = "wma";  	    //Windows Media Audio (WMA)
	extensao[22] = "swf";       //Animação Flash
/*
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + vbanco,vlogin,vsenha);

	String query = "select arquivo, nome, dbms_lob.getlength(arquivo) as tamanho, 'arquivos/jsp/download_arquivo.jsp' as lixo from gecoi.arquivo where id_arquivo=" + varquivo;        

	Statement st = con.createStatement();

	ResultSet rs = st.executeQuery(query);
	rs.next();

	String vnome     = rs.getString("nome").toLowerCase();
	String vextensao = vnome.substring(vnome.length()-3, vnome.length());
	String vtamanho  = rs.getString("tamanho");
	String vdownload = (request.getParameter("iddownload")==null) ? "" : request.getParameter("iddownload");


	byte[] bytearray = new byte[4096];
	int size=0;
	InputStream arquivo; 
	arquivo = rs.getBinaryStream(1);
*/
	//tipo do arquivo
	String vtipo     = "";
	for (int i=0; i<tipos.length; i++)
	{
	     if( extensao[i].indexOf(vextensao) != -1 )
		 {
			 vtipo = tipos[i];
		 }
	}

	response.reset();

/*	if (vdownload.compareToIgnoreCase("0")==0)
	{
	   response.setContentType("application/octet-stream");
	   response.addHeader("Content-Disposition","attachment; filename=" + vnome);
	}
	else
	{
	  if (vtipo.compareToIgnoreCase("")==0)
	    {
	      response.setContentType("application/octet-stream");
	      //response.addHeader("Content-Disposition","attachment; filename=" + vnome);
	      response.addHeader("Content-Disposition","attachment; filename=" + vlink);
	    }
		
	  else
	    {
	      response.setContentType(vtipo);
	      //response.addHeader("Content-Disposition","inline; filename=" + vnome);
	      response.addHeader("Content-Disposition","inline; filename=" + vlink);
	    }

	//}


	  //response.setContentType("jpeg");//Pesquise os mime-types para saber o tipo correto
	 // File arquivo = new File(vlink);
	  /*InputStream in = new FileInputStream(arquivo);
	  ByteArrayOutputStream byteOut = new ByteArrayOutputStream(arquivo.length());
	  byte[] buffer = new byte[4096]; // some large number - pick one
	  //for (int size; ((size = in.read(buffer)) != -1; )
	  int lidos;		
	  while ((lidos = in.read(buffer))!= -1)
	    byteOut.write(buffer, 0, lidos);
	  ByteArrayInputStream bain = new ByteArrayInputStream(byteOut.toByteArray());
	  */
	  
	/*  
	  InputStream ins = new FileInputStream(arquivo);
      BufferedInputStream bfins = new BufferedInputStream(ins);
      int fileSize = (int)arquivo.length();
      byte[] blob = new byte[fileSize];
      int bytes_read = 0;
      int offset = 0;

      while ((bytes_read = bfins.read(blob, 0, fileSize)) != -1) {
          offset += bytes_read;
      }
      bfins.close();
      ByteArrayInputStream bins = new ByteArrayInputStream(blob);
      */
      
      
	  /*ByteArrayInputStream bain = new ByteArrayInputStream(arquivo.length());
	  
	  OutputStream outp = response.getOutputStream();
	  byte[] buffer = new byte[2048];//Buffer para leitura
	  //buffer = new byte[2048];//Buffer para leitura
	  int lidos;
	  //lidos = 0;
	  while ((lidos = bain.read(buffer))!= -1)
	  {
	  	outp.write(buffer,0,lidos);//Transfere imagem
	  	outp.flush();
	  }
	  bain.close();
	  outp.close();//Fecha streams
	  */

	/*//File arquivo = new File(vlink);
	long vtamanho = arquivo.length();
	byte[] bytearray = new byte[4096];
	int size=0;
	
	response.addHeader("Content-Length", ""+vtamanho);
	while((size=bins.read(bytearray))!= -1 ) 
	{
	   response.getOutputStream().write(bytearray,0,size);
	}
	    
	response.flushBuffer();
	bfins.close();
	*/
	/*arquivo.close();
	rs.close();
	con.close();
*/
/*System.out.println("1");
response.setContentType("jpeg");
	InputStream in = null;
	System.out.println(in);
	in = gravar.arquivoStream(vidArquivo);
	System.out.println("2");
	int size=0;
	byte[] bytearray = new byte[4096];
	System.out.println("3");	
	//size=in.read(bytearray);
	System.out.println(in);
	System.out.println(bytearray);
	//in.read(bytearray);
	while((size=in.read(bytearray))!= -1 ) 
	{
		System.out.println("44");
   		response.getOutputStream().write(bytearray,0,size);
   		System.out.println("4");   		
	}
	System.out.println("5");
	response.flushBuffer();
	in.close();
	System.out.println("6");    */
  	//resultSet.close();
	//conexao.close();
	
%>
