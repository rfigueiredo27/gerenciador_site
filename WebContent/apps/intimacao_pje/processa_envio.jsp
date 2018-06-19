<%@page import="java.sql.*"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="br.jus.trerj.funcoes.IncluirGecoiArquivo"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="be.telio.mediastore.ui.upload.UploadListener"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>




<%
UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);

String vid_arquivo = "";
int vid_area = 2693;
String vdata = multiparts.get(0).getString();
String vprocesso = multiparts.get(1).getString();
String vemail = multiparts.get(2).getString();
String vnome = multiparts.get(3).getString();
String vmensagem = multiparts.get(4).getString();
String vlogin = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();


vmensagem = new String (vmensagem.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String vid_conteudo = "";
String vretorno = "";
//String nomeArquivo = "webtemp\\pje_intimacao-" + session.getAttribute("login").toString() + ".htm";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vnomeArquivo = "pje_intimacao-" + vusuario + ".htm";

String vtitulo = vprocesso+"@@"+vemail+"@@"+vnome;

IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

// salvando a reportagem em arquivo htm
Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());
try
{
	byte[] contentInBytes = vmensagem.getBytes();
	File file = new File(vdiretorio + vnomeArquivo);
	FileOutputStream fop = new FileOutputStream(file);
	fop.write(contentInBytes);
	fop.flush();
	fop.close();
} 
catch (Exception e) 
{
	out.print(e.getMessage());
}


PreparedStatement pstm;
String vsql = "";

try
{
		// gravando o arquivo html
		vretorno = incluir.incluir(vtitulo, vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, "", 1);
		vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
		vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
		
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
		con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
		System.out.println(identificador);
		System.out.println(request.getServletPath());
		//System.out.println(request.getRemoteAddr());
		
		vsql = "select internauta.sendmail(?,?,?,?,?) as em from dual";
		
		
		pstm = con.prepareStatement(vsql);
		pstm.setString(1, "SEINTE");
		pstm.setString(2, "seinte@tre-rj.jus.br");
		pstm.setString(3, vemail);
		pstm.setString(4, "TRE-RJ - Intimação-PJe: "+ vprocesso);
		pstm.setString(5, vmensagem);

		System.out.println(vmensagem);
		System.out.println("vmensagem");		
		ResultSet rs = pstm.executeQuery();
		
		if (rs.next())
			System.out.print(rs.getString("em"));
		
		out.print("<script>top.atualizaTelaReportagem();</script>");
		
		con.close();

		
}
catch (Exception ex)
{
	System.out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}


%>