
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%><%@page
	import="br.jus.trerj.funcoes.ListaAmbiente"%><%@page
	import="br.jus.trerj.modelo.Parametros"%><%@ page
	import="java.io.*,java.sql.*,java.util.*"%>
<%
	String vidArquivo = request.getParameter("idArquivo");
	String vlogin = session.getAttribute("login").toString();
	String vsenha = session.getAttribute("senha").toString();

	String[] tipos = new String[23];
	tipos[0] = "application/msword"; //Microsoft Word document
	tipos[1] = "application/pdf"; //Acrobat (.pdf) file
	tipos[2] = "application/vnd.ms-excel"; //Excel spreadsheet
	tipos[3] = "application/vnd.ms-powerpoint"; //Powerpoint presentation
	tipos[4] = "application/zip"; //Zip archive
	tipos[5] = "audio/basic"; //Sound file in .au or .snd format
	tipos[6] = "audio/x-aiff"; //AIFF sound file
	tipos[7] = "audio/x-wav"; //Microsoft Windows sound file
	tipos[8] = "audio/midi"; //MIDI sound file
	tipos[9] = "text/html"; //HTML document
	tipos[10] = "text/plain"; //Plain text
	tipos[11] = "text/xml"; //XML document
	tipos[12] = "image/gif"; //GIF image
	tipos[13] = "image/jpeg"; //JPEG image
	tipos[14] = "image/png"; //PNG image
	tipos[15] = "image/tiff"; //TIFF image
	tipos[16] = "video/mpeg"; //MPEG video clip
	tipos[17] = "video/quicktime"; //QuickTime video clip
	tipos[18] = "video/avi"; //AVI vídeo
	tipos[19] = "audio/mpeg"; //Áudio MPEG mp3
	tipos[20] = "application/rtf"; //Rich Text Format (RTF)
	tipos[21] = "audio/x-ms-wma"; //Windows Media Audio (WMA)
	tipos[22] = "application/x-shockwave-flash"; //Animação Flash

	String[] extensao = new String[23];
	extensao[0] = "doc"; //Microsoft Word document
	extensao[1] = "pdf"; //Acrobat (.pdf) file
	extensao[2] = "xls"; //Excel spreadsheet
	extensao[3] = "ppt,pps"; //Powerpoint presentation
	extensao[4] = "zip"; //Zip archive
	extensao[5] = "au,snd"; //Sound file in .au or .snd format
	extensao[6] = "aiff"; //AIFF sound file
	extensao[7] = "wav"; //Microsoft Windows sound file
	extensao[8] = "midi"; //MIDI sound file
	extensao[9] = "html"; //HTML document
	extensao[10] = "txt"; //Plain text
	extensao[11] = "xml"; //XML document
	extensao[12] = "gif"; //GIF image
	extensao[13] = "jpeg,jpg"; //JPEG image
	extensao[14] = "png"; //PNG image
	extensao[15] = "tiff"; //TIFF image
	extensao[16] = "mpeg,mpg"; //MPEG video clip
	extensao[17] = "mov"; //QuickTime video clip
	extensao[18] = "avi"; //AVI vídeo
	extensao[19] = "mp3"; //Áudio MPEG
	extensao[20] = "rtf"; //Rich Text Format (RTF)
	extensao[21] = "wma"; //Windows Media Audio (WMA)
	extensao[22] = "swf"; //Animação Flash

	Class.forName("oracle.jdbc.driver.OracleDriver");
	Parametros parametros = new Parametros(
			new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
	Connection con = new ConnectionFactory().getConnection(
			parametros.getBanco(), vlogin, vsenha);
	String query = "select arquivo, nome, dbms_lob.getlength(arquivo) as tamanho, 'arquivos/jsp/download_arquivo.jsp' as lixo from gecoi.arquivo where id_arquivo=? ";
	PreparedStatement pstm = con.prepareStatement(query);
	pstm.setInt(1, Integer.parseInt(vidArquivo));
	ResultSet rs = pstm.executeQuery();

	if (rs.next()) {
		String vnome = rs.getString("nome").toLowerCase();
		String vextensao = vnome.substring(vnome.length() - 3,
				vnome.length());
		String vtamanho = rs.getString("tamanho");
		String vtipo = "";
		String vdownload = (request.getParameter("iddownload") == null) ? ""
				: request.getParameter("iddownload");

		byte[] bytearray = new byte[4096];
		int size = 0;
		InputStream arquivo;
		arquivo = rs.getBinaryStream(1);
		for (int i = 0; i < tipos.length; i++) {
			if (extensao[i].indexOf(vextensao) != -1) {
				vtipo = tipos[i];
			}
		}
		out.clear();
		response.reset();
		out.clear();

		if (vdownload.compareToIgnoreCase("0") == 0) {
			out.clear();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Disposition",
					"attachment; filename=" + vnome);
		} else {
			if (vtipo.compareToIgnoreCase("") == 0) {
				out.clear();
				response.setContentType("application/octet-stream");
				response.addHeader("Content-Disposition",
						"attachment; filename=" + vnome);
			}

			else {
				out.clear();
				response.setContentType(vtipo);
				response.addHeader("Content-Disposition",
						"inline; filename=" + vnome);
			}

		}

		response.addHeader("Content-Length", vtamanho);

		if ((size = arquivo.read(bytearray)) != -1) {
			out.clear();
			response.getOutputStream().write(bytearray);

		}
		out.clear();
		response.flushBuffer();
		arquivo.close();
	}
	
	rs.close();
	con.close();
%>
