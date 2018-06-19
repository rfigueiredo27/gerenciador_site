<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="be.telio.mediastore.ui.upload.UploadListener"%>
<%@page import="br.jus.trerj.funcoes.IncluirGecoiArquivo"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%
String vretorno = "";
		String vidConteudo = "";
		String vdescricao = "";
		String vapp = ""; // guarda a app que chamou essa inlusao
		int vordem = 0;
		String vnomeArquivo = "";
		String arquivoAnexo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		// 
		// process only if its multipart content
		if (isMultipart) {
			// Pegando os dados do formulario
			//Listener para a barra de progresso
		      UploadListener listener = new UploadListener(request, 30);
		      // Create a factory for disk-based file items
		      FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
		      // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		      // Set upload parameters   
		      //upload.setSizeMax(70*1024*1024); //70Mb
		    //fim listener
			List<FileItem> multiparts = null;
			try {
				multiparts = upload.parseRequest(request);
			} catch (FileUploadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			vidConteudo = multiparts.get(0).getString();
			vapp = multiparts.get(1).getString();
			vdescricao = multiparts.get(2).getString();
			vordem = 0;
			vnomeArquivo = multiparts.get(3).getName();
			//upload 			
			String extensao = "";
			try {
						
				extensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
				arquivoAnexo = vnomeArquivo.substring(0,vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
				multiparts.get(3).write(new File(diretorio + arquivoAnexo));
			}
			catch (Exception e) 
			{
				System.out.println("Anexo failed: " + e.getMessage());
				request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
			}
				
					
			//Gravar anexo no banco
			try {
							
				vretorno = incluir.incluirAnexo(vidConteudo, vdescricao, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vordem, 0, "");
								
			}
			catch(Exception ex){
				System.out.println("grava texto no GECOI: " + ex.getMessage());
				request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
			}
					
				
			try{
				File apagar = new File(diretorio + arquivoAnexo); // nova imagem 
				apagar.delete();
			}
			catch (Exception e)
			{
				System.out.println("Erro ao apagar: " + e.getMessage());
				request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
			}
					
			System.out.println(vretorno);
			request.getSession().setAttribute("erro", "");					
		} 
			
		PrintWriter out2 = response.getWriter();
		out2.print("<script>parent.atualizaTela();</script>");
				
		 %>