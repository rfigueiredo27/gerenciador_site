<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload" %>


<%//@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("UTF-8");

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
out.print("<br>8="+multiparts.get(8).getFieldName());
out.print("<br>9="+multiparts.get(9).getFieldName());
out.print("<br>0="+multiparts.get(0).getString());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getString());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getString());
out.print("<br>3="+multiparts.get(3).getString());
out.print("<br>4="+multiparts.get(4).getString());
out.print("<br>5="+multiparts.get(5).getString());
out.print("<br>6="+multiparts.get(6).getName());
out.print("<br>7="+multiparts.get(7).getString());
out.print("<br>8="+multiparts.get(8).getString());
out.print("<br>9="+multiparts.get(9).getName());
*/
/*
0=tipoLegislacao
1=dataLegislacao
2=tipoNorma
3=num_norma
4=ano_norma
5=assuntoLegislacao
6=arquivo

*/
String vid_arquivo = "";
int vid_area = Integer.parseInt(multiparts.get(0).getString());  
String vdata = multiparts.get(1).getString();
String vnorma = multiparts.get(2).getString();
String vnumero_norma = multiparts.get(3).getString();
String vano_norma = multiparts.get(4).getString();
String vassunto = multiparts.get(5).getString();
String varquivo = multiparts.get(6).getName();
String vdescricao_aux = multiparts.get(7).getString();
int ultimo = 7; // ultimo campo antes do anexo
int totalAnexo = (multiparts.size()-ultimo-1)/2; // (todos os campos - ultimo campo fixo - 1) / 2 porque são 2 campos por anexo
String vnomeArquivo = "";
String vdescricao2 = "";

String vdescricao = "";
if ( (vid_area == 47) || (vid_area == 48) || (vid_area == 53) )
	vdescricao = vnorma + vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
else
	if (vid_area == 50) 
		vdescricao = vdescricao_aux;
	else
		vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
/*if ( (vid_area == 47) || (vid_area == 48) || (vid_area == 53) )
	//vdescricao = vnorma + " nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vnorma + vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vid_area == 20) || (vid_area == 36) || (vid_area == 2434) )
	//vdescricao = "Resolução nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vid_area == 50) 
	//vdescricao = "Índice dos Atos da Presidência do TRE-RJ.";
	vdescricao = vdescricao_aux;
if (vid_area == 33) 
	//vdescricao = "Ato nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vid_area == 39) 
	//vdescricao = "Ato VP nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vid_area == 38)
	//vdescricao = "Ato Conjunto nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vid_area == 45) || (vid_area == 49) || (vid_area == 2631) || (vid_area == 46) || (vid_area == 2560) || (vid_area == 76) || (vid_area == 77) || (vid_area == 2652) )
	//vdescricao = "Portaria nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vid_area == 1747) || (vid_area == 90) || (vid_area == 2587) )
	//vdescricao = "Instrução Normativa nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vid_area == 65) || (vid_area == 44) )
	//vdescricao = "Ordem de Serviço nº" + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vid_area == 2502) 
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
*/
vid_area=1622; // teste

String vid_conteudo = "";
String vretorno = "";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

// salvando a reportagem em arquivo htm
Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());

try
{
	// fazendo o upload do arquivo
	String vextensao = varquivo.substring(varquivo.lastIndexOf(".")+1, varquivo.length());
	String varquivoObjeto = varquivo.substring(0, varquivo.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
	if (varquivoObjeto.lastIndexOf("\\") > -1)
	{
		varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
	}
	multiparts.get(6).write(new File(vdiretorio + varquivoObjeto));
			
	// gravando o arquivo
	vretorno = incluir.incluir(vdescricao, vdiretorio, varquivoObjeto, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, "", 9);
	vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
	vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
	for(int i=1; i <= totalAnexo; i++){
		vdescricao2 = (multiparts.get(++ultimo)).getString();
		vnomeArquivo = (multiparts.get(++ultimo)).getName();
		//upload no anexo
		vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".") + 1, vnomeArquivo.length());
		varquivoObjeto = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + vextensao;
		if (varquivoObjeto.lastIndexOf("\\") > -1)
		{
			varquivoObjeto = varquivoObjeto.substring(varquivoObjeto.lastIndexOf("\\")+1);
		}

		// fazendo o upload do arquivo
		multiparts.get(ultimo).write(new File(vdiretorio + varquivoObjeto));
		
		
		vretorno = incluir.incluirAnexo(vid_conteudo, vdescricao2, vdiretorio, varquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), i, 0, "");
		vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
	
	}


	out.print("<script>top.atualizaTelaLegislacao();</script>");
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}

%>