<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%
request.setCharacterEncoding("ISO-8859-1");
int vid_area = 2620;

UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);
String vid_arquivo = "";
int vedicao = Integer.parseInt(multiparts.get(0).getString());  // vou guardar no campo publicado
String vsecao = multiparts.get(1).getString();  // vou guardar em observação
String vdata = multiparts.get(2).getString();
String vtitulo = multiparts.get(3).getString();
String vresumo = multiparts.get(4).getString();
String varquivoImagem = multiparts.get(5).getName();
String vtexto = multiparts.get(6).getString();

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
	// fazendo o upload do arquivo
	String vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
	String varquivoObjeto = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
	if (varquivoObjeto.lastIndexOf("\\") > -1)
	{
		varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
	}
	multiparts.get(5).write(new File(vdiretorio + varquivoObjeto));

	// 
	//incluir(String descricao, String diretorio, String nomeArquivo, int idArea, String vusuario, String vsenha, String dataIni, String dataFim, int ordem, String observacao, int publicado){	
	// gravando o arquivo html
	vretorno = incluir.incluir(vtitulo + "@@" + vresumo, vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vsecao, vedicao);
	vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
	vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
	
	//incluir(String idConteudo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha, int ordem, int publicado, String observacao)
	// gravando o arquivo imagem
	vretorno = incluir.incluir(vid_conteudo, vtitulo + "@@" + vresumo, vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, vedicao, vsecao);
	//vretorno = incluir.incluir(vtitulo + "@@" + vresumo, vdiretorio, varquivoObjeto, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vsecao, vedicao);

	out.print("<script>top.atualizaTela();</script>");
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
%>