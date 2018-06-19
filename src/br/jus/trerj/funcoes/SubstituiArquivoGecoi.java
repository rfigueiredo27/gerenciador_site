package br.jus.trerj.funcoes;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
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

public class SubstituiArquivoGecoi  extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String vretorno = "";
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vnomeArquivo = "";
		String vextensao = "";
		String varquivo = "";
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		
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
			
			vidConteudo  = multiparts.get(0).getString();
			vidArquivo  = multiparts.get(1).getString();
			vdescricao = multiparts.get(2).getString();
			vdescricao = new String (vdescricao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
			
			vnomeArquivo  = multiparts.get(3).getName();
			vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf("."));
			vnomeArquivo = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + vextensao;
			
			try {
				vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
				varquivo = vnomeArquivo.substring(0,vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + vextensao;				
				multiparts.get(3).write(new File(diretorio + varquivo));
			}
			catch(Exception ex){
			  System.out.println("grava texto: " + ex.getMessage());
			  request.getSession().setAttribute("erro", "Erro na gravacao do texto: " + ex.getMessage());
			}
				
			//Gravar arquivo texto no banco
			try {	
				AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();
				vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vdescricao, diretorio, varquivo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				System.out.println(vretorno);
			}
			catch(Exception ex){
				System.out.println("grava texto no GECOI: " + ex.getMessage());
				request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
			}
			
			try{
				File apagar = new File(diretorio + vnomeArquivo);
				apagar.delete();
			}
				catch (Exception e)
				{
					System.out.println("Erro ao apagar: " + e.getMessage());
			  		request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
				}
			//response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp");
				PrintWriter out = response.getWriter();
				out.print("<script>parent.atualizaTela();</script>");
		}		
	}

}
