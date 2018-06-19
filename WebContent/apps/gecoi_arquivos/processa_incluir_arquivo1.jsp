<%@page import="br.jus.trerj.funcoes.UltimasNoticiasInternet"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasSemImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasComImagem"%>
<%@page import="java.sql.Connection"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.controle.gecoiArquivos.ReduzirImagem"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="be.telio.mediastore.ui.upload.UploadListener"%>
<%@page import="br.jus.trerj.funcoes.IncluirGecoiArquivo"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%
int vidArea = 0;
String vobservacao = "";
String vdescricao = "";
String vidArquivo = "";
String vretorno = "";
String nomeArquivo = "";
String arquivoObjeto = "";
String dataPublicacao = "";
int ultimo = 4;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

//		//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
//		Date data = new Date(System.currentTimeMillis());  
//		SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
//		String dataPublicacao = formatarDate.format(data);

// 
// process only if its multipart content
if (isMultipart) {
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

	Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));

	int totalAnexo = multiparts.size();

	vidArea = Integer.parseInt(multiparts.get(0).getString());
	dataPublicacao = multiparts.get(1).getString();
	vobservacao = multiparts.get(2).getString();
	vdescricao = multiparts.get(3).getString();
	nomeArquivo = multiparts.get(4).getName();


	PrintWriter pw = response.getWriter();

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
		multiparts.get(4).write(new File(diretorio + arquivoObjeto));
		
		FileItem arquivo = multiparts.get(4);
		//Verifica se o arquivo é uma imagem para proceder o cálculo do percentual de redução
		if (arquivo.getContentType().lastIndexOf("image")>-1)
		{
			ReduzirImagem redu = new ReduzirImagem();
			redu.ReduzImagem(arquivo, diretorio, arquivoObjeto);
		}
		
		//Gravar arquivo no banco
		try {
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			
			conexao.setAutoCommit(false);
			
			

			vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, null + " a " + vobservacao, 0);
			vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
			//Se for imagem é verificado se precisa reduzir
			if (arquivo.getContentType().lastIndexOf("image")>-1)
				vretorno = incluir.incluirImagemReduzida(vidArquivo, diretorio, "redu" + arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());

			for(int i=1; i<= totalAnexo; i++){

				vdescricao = multiparts.get(++ultimo).getString();
				nomeArquivo = multiparts.get(++ultimo).getName();

				//upload no anexo
				extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
				arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
				if (arquivoObjeto.lastIndexOf("\\") > -1)
				{
					arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
				}

				// fazendo o upload do arquivo
				
				multiparts.get(ultimo).write(new File(diretorio + arquivoObjeto));
				
				arquivo = multiparts.get(ultimo);
				//Verifica se o arquivo é uma imagem para proceder o cálculo do percentual de redução
				if (arquivo.getContentType().lastIndexOf("image")>-1)
				{
					ReduzirImagem redu = new ReduzirImagem();
					redu.ReduzImagem(arquivo, diretorio, arquivoObjeto);
				}
				
				//vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), i, dataPublicacao, null);
				vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, null + " a " + vobservacao, 0);
				vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
				
				if (arquivo.getContentType().lastIndexOf("image")>-1)
					vretorno = incluir.incluirImagemReduzida(vidArquivo, diretorio, "redu" + arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			}


			conexao.commit();
			UltimasNoticiasComImagem ultimasNoticiasComImagem = new UltimasNoticiasComImagem();
			vretorno = ultimasNoticiasComImagem.ultimasTV(
					request.getSession().getAttribute("login").toString(), request.getSession()
							.getAttribute("senha").toString());

			UltimasNoticiasSemImagem ultimasNoticiasSemImagem = new UltimasNoticiasSemImagem();
			vretorno = ultimasNoticiasSemImagem.ultimas(
					request.getSession().getAttribute("login").toString(), request.getSession()
							.getAttribute("senha").toString());

			UltimasNoticiasInternet ultimasNoticiasInternet = new UltimasNoticiasInternet();
			vretorno = ultimasNoticiasInternet.ultimasTV(
					request.getSession().getAttribute("login").toString(), request.getSession()
							.getAttribute("senha").toString());

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


	pw.print("<script>top.carregaAPP('/gecoi.3.0/apps/gecoi_arquivos/index.jsp','');</script>");
}		

%>