package br.jus.trerj.funcoes;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory;
import be.telio.mediastore.ui.upload.UploadListener;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;



public class IncluirAnexoServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
			
		//response.sendRedirect("/gecoi.3.0/apps/contrato/alterar_aditivo.jsp?id=" + vidConteudo + "&nProcesso=" + vnProcesso + "&nContrato=" + vnContrato);
		//response.sendRedirect(vapp);
		//out.print("<script>top.carregaPag('/gecoi.3.0/apps/licitacao/alterar_anexo.jsp?id=' + pconteudo + '&nProcesso=' + pprocesso + '&nPregao=' + ppregao, 'divbusca');</script>");
		//out.print("<script>alert('zzz');</script>");
		PrintWriter out = response.getWriter();
		out.print("<script>parent.atualizaTela();</script>");
				
	}
}
