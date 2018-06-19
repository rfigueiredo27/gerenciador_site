<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.*, br.jus.trerj.funcoes.IncluirGecoiArquivo,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%//@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
int vid_area = 2604;
/*
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
if (isMultipart) 
{
	//Listener para a barra de progresso
	UploadListener listener = new UploadListener(request, 30);
	// Create a factory for disk-based file items
	FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
	// Create a new file upload handler
	ServletFileUpload upload = new ServletFileUpload(factory);
	List<FileItem> multiparts = null;
	try {
		multiparts = upload.parseRequest(request);
	} catch (FileUploadException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	String idConteudo = multiparts.get(0).getString();
	String secao = multiparts.get(1).getString();
	String anoPregao = multiparts.get(2).getString();
	String dataReportagem = multiparts.get(3).getString();
	String descricaoReportagem = multiparts.get(4).getString();
			nomeArquivo = multiparts.get(8).getName();
			
			
			//upload no objeto
			String extensao = "";
			extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
			arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
			if (arquivoObjeto.lastIndexOf("\\") > -1)
			{
				arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
			}

			try {
				// fazendo o upload do arquivo
				multiparts.get(8).write(new File(diretorio + arquivoObjeto));
					
				//Gravar licitacao no banco
				try {
					vdescricao = tipo + "-" + numPregao + "/" + anoPregao + "-" + numProcesso + "/" + anoProcesso + "-" + objeto;
					vobservacao = "";
					vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataAbertura, dataFechamento, 0, vobservacao, 0);
					//vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#")+1);

					if ((!dataPublicacao.equals("")) && (vretorno.indexOf("Erro") < 0))
						vretorno = incluir.incluirCampoAdicional(vidArquivo, vidDataPublicacao, dataPublicacao, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				}
				catch(Exception ex){
					System.out.println("grava arquivo no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
				}
					
				
				try{
					File apagar = new File(diretorio + arquivoObjeto); 
					apagar.delete();
				}
				catch (Exception e)
				{
					System.out.println("Erro ao apagar: " + e.getMessage());
					request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
				}
					
				request.getSession().setAttribute("erro", "");					
			} 
			catch (Exception e) 
			{
				System.out.println("File upload failed: " + e.getMessage());
				request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
			}
			
			PrintWriter out = response.getWriter();
			out.print("<script>top.carregaAPP('/gecoi.3.0/apps/licitacao/index.jsp','');</script>");
		}		
*/

/*
String vdescricao = (request.getParameter("descricaoReportagem") == null ? "" : request.getParameter("descricaoReportagem"));
String vdata = (request.getParameter("dataReportagem") == null ? "" : request.getParameter("dataReportagem"));
//int vid_conteudo = (request.getParameter("idconteudo") == null ? 0 : Integer.parseInt(request.getParameter("idconteudo")));
String vid_conteudo = (request.getParameter("idconteudo") == null ? "0" : request.getParameter("idconteudo"));

String vsecao = (request.getParameter("secao") == null ? "" : request.getParameter("secao"));
*/

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
String vsubtitulo = multiparts.get(4).getString();
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

	//incluir(String descricao, String diretorio, String nomeArquivo, int idArea, String vusuario, String vsenha, String dataIni, String dataFim, int ordem, String observacao, int publicado){
	// gravando o arquivo html
	vretorno = incluir.incluir(vtitulo + "@@" + vsubtitulo, vdiretorio, vnomeArquivo, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vsecao, vedicao);
	vid_arquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
	vid_conteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));
	
	//incluir(String idConteudo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha, int ordem, int publicado, String observacao)
	//vretorno = incluir.incluir(vid_conteudo, vsecao + "@@" + vdescricao, vdiretorio, vnomeArquivo, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, 0, " ");
	// gravando o arquivo imagem
	vretorno = incluir.incluir(vid_conteudo, vtitulo + "@@" + vsubtitulo, vdiretorio, varquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), 1, vedicao, vsecao);
	//vretorno = incluir.incluir(vtitulo + "@@" + vsubtitulo, vdiretorio, varquivoObjeto, vid_area, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), vdata, "", 0, vsecao, vedicao);

	/*Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ";  // parametros do conteudo
	vsql = vsql + "?, ?, ?, ?)}"; // parametros do arquivo
 	
	CallableStatement cs;
	cs = con.prepareCall(vsql);
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
	// variáveis da inclusão de conteudo
	cs.setInt(2,vid_conteudo); //id_conteudo
	cs.setString(3,vsecao + "@@" + vdescricao); //descricao
	cs.setString(4,""); //observacao
	cs.setString(5,session.getAttribute("login").toString()); //usuario
	//cs.setString(5,"gdebossa"); //usuario
	// variáveis da inclusão de arquivo
	File arquivo = new File(application.getRealPath("/") + nomeArquivo);
	FileInputStream fis = new FileInputStream(arquivo);
	cs.setBinaryStream(6, fis, (int)arquivo.length());

	cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
	cs.setInt(8,1);//ordem
	cs.setInt(9,0);//publicado

	cs.execute();
	    			
	retorno = cs.getString(1);
	con.commit();*/
	//out.print(vretorno);
	out.print("<script>top.atualizaTela();</script>");
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