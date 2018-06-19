<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%
int vid_area = 13;  
vid_area = 1622;

UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);
String vid_arquivo = "";
int vedicao = Integer.parseInt(multiparts.get(0).getString());  // vou guardar no campo publicado
String vdata = multiparts.get(1).getString();
String vcaminho = multiparts.get(2).getString();
String varquivoPdf = multiparts.get(3).getName();
String varquivoWord = multiparts.get(4).getName();
String varquivoCapa = multiparts.get(5).getName();

String vid_conteudo = "";
String vretorno = "";
//String nomeArquivo = "webtemp\\reportagem-" + session.getAttribute("login").toString() + ".htm";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

String vextensao = "";
String varquivoObjeto = "";
String vnomeArquivo = "";

try
{
	if (!varquivoPdf.equals(""))
	{
		// fazendo o upload do arquivo Pdf
		vnomeArquivo = varquivoPdf;
		vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
		varquivoObjeto = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (varquivoObjeto.lastIndexOf("\\") > -1)
		{
			varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
		}
		multiparts.get(2).write(new File(vdiretorio + varquivoObjeto));
		vretorno = incluir.incluir("Edição nº " + vedicao + " do Jornal Parlatório", vdiretorio, varquivoObjeto, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vcaminho, vedicao);
		vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
		vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
	}
	if (!varquivoWord.equals(""))
	{
		// fazendo o upload do arquivo word
		vnomeArquivo = varquivoWord;
		vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
		varquivoObjeto = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (varquivoObjeto.lastIndexOf("\\") > -1)
		{
			varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
		}
		multiparts.get(3).write(new File(vdiretorio + varquivoObjeto));
		if (vid_conteudo.equals(""))
		{
			vretorno = incluir.incluir("Edição nº " + vedicao + " do Jornal Parlatório - word", vdiretorio, varquivoObjeto, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 1, vcaminho, vedicao);
			vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
			vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
		}
		else
		{
			vretorno = incluir.incluir(vid_conteudo, "Edição nº " + vedicao + " do Jornal Parlatório - word", vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, vedicao, vcaminho);
		}
	}
	if (!varquivoCapa.equals(""))
	{
		// fazendo o upload do arquivo da capa
		vnomeArquivo = varquivoCapa;
		vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
		varquivoObjeto = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (varquivoObjeto.lastIndexOf("\\") > -1)
		{
			varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
		}
		multiparts.get(4).write(new File(vdiretorio + varquivoObjeto));
		if (vid_conteudo.equals(""))
		{
			vretorno = incluir.incluir("Edição nº " + vedicao + " do Jornal Parlatório", vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "",2, vcaminho, vedicao);
			vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
			vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
		}
		else
		{
			vretorno = incluir.incluir(vid_conteudo, "Edição nº " + vedicao + " do Jornal Parlatório", vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 2, vedicao, vcaminho);
		}
	}

	//out.print("<script>top.atualizaTela();</script>");
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
%>