<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.UltimasNoticiasComImagem, br.jus.trerj.funcoes.UltimasNoticiasSemImagem, br.jus.trerj.funcoes.UltimasNoticiasInternet, java.nio.charset.StandardCharsets" %>


<%//@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%

UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);

/*
out.print("<br>0="+multiparts.get(0).getFieldName());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getFieldName());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getFieldName());
out.print("<br>3="+multiparts.get(3).getFieldName());
out.print("<br>4="+multiparts.get(4).getFieldName());
out.print("<br>5="+multiparts.get(5).getFieldName());
out.print("<br>6="+multiparts.get(6).getFieldName());
out.print("<br>7="+multiparts.get(7).getFieldName());
out.print("<br>0="+multiparts.get(0).getString());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getString());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getString());
out.print("<br>3="+multiparts.get(3).getString());
out.print("<br>4="+multiparts.get(4).getString());
out.print("<br>5="+multiparts.get(5).getName());
out.print("<br>6="+multiparts.get(6).getString());
out.print("<br>7="+multiparts.get(7).getString());
*/

long vtamanhoImagem = multiparts.get(3).getSize();
String vid_arquivo = "";
int vid_area = Integer.parseInt(multiparts.get(0).getString());  // vou guardar em observação
vid_area = 1622;
String vdata = multiparts.get(1).getString();
String vtitulo = multiparts.get(2).getString().replaceAll("\"","'");
String varquivoImagem = multiparts.get(3).getName();
String vtipo_arquivo = multiparts.get(4).getString();
String varquivoHtml = multiparts.get(5).getName();

long vtamanhoHtml = multiparts.get(5).getSize();

// o multiparts.get(6).getString(); é um input do tipo file escondido  ??????????????
String vtexto = multiparts.get(7).getString();
vtexto = new String (vtexto.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
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
String vextensao = "";
String varquivoObjeto = "";
try
{
	if (vtipo_arquivo.equals("editar"))
	{
		byte[] contentInBytes = vtexto.getBytes();
		File file = new File(vdiretorio + vnomeArquivo);
		FileOutputStream fop = new FileOutputStream(file);
		fop.write(contentInBytes);
		fop.flush();
		fop.close();
	}
	else
	{
		/*vextensao = varquivoHtml.substring(varquivoHtml.lastIndexOf(".")+1, varquivoHtml.length());
		vnomeArquivo = varquivoHtml.substring(0, varquivoHtml.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivo.lastIndexOf("\\") > -1)
		{
			vnomeArquivo = vnomeArquivo.substring(vnomeArquivo.lastIndexOf("\\")+1);
		}*/
	
		multiparts.get(5).write(new File(vdiretorio + vnomeArquivo));
		//vretorno = incluir.incluir(vid_conteudo, vtitulo, vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(),		
	}
} 
catch (Exception e) 
{
	out.print(e.getMessage());
}

try
{
	//vtamanho = varquivoImagem.getSize(); //tamanho do arquivo
	//Se o arquivo for uma imagem e tiver tamanho maior que 500k
	if (vtamanhoImagem > 500000)
	{
		System.out.print("A Imagem Maior que o Permitido!" );
		out.print("<script>alert('A Imagem Maior que o Permitido!')</script>");
		
		
		
	}
	else if (vtamanhoHtml > 1000000)
	{
		System.out.print("O arquivo tem que ser inferior a 1MB!" );
		System.out.print(vtamanhoHtml);
		out.print("<script>alert('O arquivo tem que ser inferior a 1MB!!')</script>");
		
	}
	else
	{
		// gravando o arquivo html
		vretorno = incluir.incluir(vtitulo, vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, "", 9);
		vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
		vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
		if (vtamanhoImagem > 0)
		{
			// fazendo o upload do arquivo
			vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
			varquivoObjeto = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
			if (varquivoObjeto.lastIndexOf("\\") > -1)
			{
				varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
			}
		
			multiparts.get(3).write(new File(vdiretorio + varquivoObjeto));
			vretorno = incluir.incluir(vid_conteudo, vtitulo, vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, 9, "");
		}
	}
	if ( (vid_area == 22) || (vid_area == 2661) )
	{
		UltimasNoticiasComImagem ultimasNoticiasComImagem = new UltimasNoticiasComImagem();
		vretorno = ultimasNoticiasComImagem.ultimasTV(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 

		UltimasNoticiasSemImagem ultimasNoticiasSemImagem = new UltimasNoticiasSemImagem();
		vretorno = ultimasNoticiasSemImagem.ultimas(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 
	}
	if ( (vid_area == 42) || (vid_area == 2661) )
	{
		UltimasNoticiasInternet ultimasNoticiasInternet = new UltimasNoticiasInternet();
		vretorno = ultimasNoticiasInternet.ultimasTV(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 
	}
	
	//out.print("<script>top.atualizaTelaReportagem();</script>");
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
%>