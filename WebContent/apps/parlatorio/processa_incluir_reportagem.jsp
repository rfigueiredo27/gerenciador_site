<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload" %>


<%//@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("ISO-8859-1");
int vid_area = 2604;

UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);
long vtamanhoImagem = multiparts.get(5).getSize();

String vid_arquivo = "";
int vedicao = Integer.parseInt(multiparts.get(0).getString());  // vou guardar no campo publicado
String vsecao = multiparts.get(1).getString();  // vou guardar em observação
String vdata = multiparts.get(2).getString();
String vtitulo = multiparts.get(3).getString();
String vsubtitulo = multiparts.get(4).getString();
String varquivoImagem = multiparts.get(5).getName();


//String vtexto = multiparts.get(6).getString();
// o multiparts.get(6).getString(); é um input do tipo file escondido  ??????????????
String vtexto = multiparts.get(7).getString();
String vid_conteudo = "";
String vretorno = "";
//String nomeArquivo = "webtemp\\reportagem-" + session.getAttribute("login").toString() + ".htm";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vnomeArquivo = "reportagem-" + vusuario + ".htm";
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

// salvando a reportagem em arquivo htm
Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());
try
{
	byte[] contentInBytes = vtexto.getBytes();
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

try
{
	//vtamanho = varquivoImagem.getSize(); //tamanho do arquivo
	out.print(vtamanhoImagem );
	//Se o arquivo for uma imagem e tiver tamanho maior que 500k
	//if (vtamanhoImagem > 500)
	//{
		out.print("A Imagem Maior que o Permitido!" );
		
	//}
	//else
	//{
		out.print("entrei!" );

	// fazendo o upload do arquivo
/*	String vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
	String varquivoObjeto = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
	if (varquivoObjeto.lastIndexOf("\\") > -1)
	{
		varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
	}
	multiparts.get(5).write(new File(vdiretorio + varquivoObjeto));

	// gravando o arquivo html
	vretorno = incluir.incluir(vtitulo + "@@" + vsubtitulo, vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vsecao, vedicao);
	vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
	vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
	
	// gravando o arquivo imagem
	vretorno = incluir.incluir(vid_conteudo, vtitulo + "@@" + vsubtitulo, vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, vedicao, vsecao);
	//out.print(vretorno);
	out.print("<script>top.atualizaTelaReportagem();</script>");*/
	//}
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
/*finally
{
	if(con!=null && !con.isClosed())
		con.close();
}*/

%>