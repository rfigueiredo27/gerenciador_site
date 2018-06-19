<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.*, be.telio.mediastore.ui.upload.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
int vid_area = 2604;
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
	String idArquivoPrincipal = multiparts.get(1).getString();
	String dataItemTv = multiparts.get(2).getString();
	int ordem = Integer.parseInt(multiparts.get(3).getString()) + 1;
	String descricaoItemTv = multiparts.get(4).getString();
	String nomeArquivo = multiparts.get(5).getName();

	//upload no objeto
	String extensao = "";
	extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
	String arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + session.getAttribute("login") + "." + extensao;
	if (arquivoObjeto.lastIndexOf("\\") > -1)
	{
		arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
	}

	try 
	{
		// fazendo o upload do arquivo
		multiparts.get(5).write(new File(diretorio + arquivoObjeto));
					
		//Gravar licitacao no banco
		try {
			String vdescricao = "TV@@" + descricaoItemTv;
			String vobservacao = "";
			String vretorno = incluir.incluir(idConteudo, vdescricao, diretorio, arquivoObjeto, session.getAttribute("login").toString(), session.getAttribute("senha").toString(), ordem, 0, vobservacao);
			String idArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
			
			if (vretorno.indexOf("Erro") < 0)
			{
				CadastroReferencia incluirReferencia = new CadastroReferencia();
				incluirReferencia.incluir(Integer.parseInt(idArquivoPrincipal), Integer.parseInt(idArquivo), session().getAttribute("login").toString(), session().getAttribute("senha").toString(), 0);
			}
		}
		catch(Exception ex){
			out.println("grava arquivo no GECOI: " + ex.getMessage());
			//session().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
		}
					
				
		try{
			File apagar = new File(diretorio + arquivoObjeto); 
			apagar.delete();
		}
		catch (Exception e)
		{
			out.println("Erro ao apagar: " + e.getMessage());
			//request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
		}
				
		//request.getSession().setAttribute("erro", "");					
	} 
	catch (Exception e) 
	{
		out.println("File upload failed: " + e.getMessage());
		//request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
	}
			
	//out.print("<script>top.carregaAPP('/gecoi.3.0/apps/licitacao/index.jsp','');</script>");
}		

/*
String vdescricao = (request.getParameter("descricaoItemTv") == null ? "" : request.getParameter("descricaoItemTv"));
String vdata = (request.getParameter("dataItemTv") == null ? "" : request.getParameter("dataItemTv"));
int vid_conteudo = (request.getParameter("idconteudo") == null ? 0 : Integer.parseInt(request.getParameter("idconteudo")));
int vordem = (request.getParameter("ordem") == null ? 0 : Integer.parseInt(request.getParameter("ordem")));
String nomeArquivo = "apps\\parlatorio\\reportagem.txt";
String retorno = "";
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ";  // parametros do conteudo
	vsql = vsql + "?, ?, ?, ?)}"; // parametros do arquivo
 	
	CallableStatement cs;
	cs = con.prepareCall(vsql);
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
	// variáveis da inclusão de conteudo
	cs.setInt(2,vid_conteudo); //id_conteudo
	cs.setString(3,"TV@@" + vdescricao); //descricao
	cs.setString(4,""); //observacao
	//cs.setString(5,session.getAttribute("login").toString()); //usuario
	cs.setString(5,"gdebossa"); //usuario
	// variáveis da inclusão de arquivo
	out.print("111");
	File arquivo = new File(application.getRealPath("/") + nomeArquivo);
	out.print("222");
	FileInputStream fis = new FileInputStream(arquivo);
	cs.setBinaryStream(6, fis, (int)arquivo.length());
	out.print((int)arquivo.length());

	cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
	cs.setInt(8,vordem+1);//ordem
	cs.setInt(9,0);//publicado
	out.print("444");

	cs.execute();
	    			
	retorno = cs.getString(1);
	con.commit();
	out.print(retorno);
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
*/
%>