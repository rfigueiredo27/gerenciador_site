package br.jus.trerj.controle.contrato;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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



public class IncluirOutrosTermos extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String vretorno = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vnContrato = "";
		String vnProcesso = "";
		String vtermo = "";
		
		String vdescricao = "";
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
			vnProcesso = multiparts.get(1).getString();
			vnContrato = multiparts.get(2).getString();
			vtermo = multiparts.get(3).getString();
			vnomeArquivo = multiparts.get(4).getName();
			vdescricao = vnContrato + "-" + vnProcesso + "-" + vtermo;
			ListaContratos lista = new ListaContratos();
			try {
				vordem = lista.getOrdem(vidConteudo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//upload 
			String extensao = "";
			extensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
			arquivoAnexo = vnomeArquivo.substring(0,vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
			if (arquivoAnexo.lastIndexOf("\\") > -1)
			{
				arquivoAnexo = arquivoAnexo.substring(arquivoAnexo.lastIndexOf("\\")+1);
			}
			try {
						
				multiparts.get(4).write(new File(diretorio + arquivoAnexo));
			}
			catch (Exception e) 
			{
				System.out.println("Anexo failed: " + e.getMessage());
				request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
			}
				
					
			//Gravar anexo no banco
			try {
							
				vretorno = incluir.incluir(vidConteudo, vdescricao, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vordem, 0, "");
				vidArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
				vidConteudo = vretorno.substring(vretorno.indexOf("#")+1);
				
								
			}
			catch(Exception ex){
				System.out.println("grava texto no GECOI: " + ex.getMessage());
				request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
			}
					
				
			try{
				File apagar = new File(diretorio + arquivoAnexo); 
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
			
		PrintWriter out = response.getWriter();
		out.print("<script>parent.atualizaTela();</script>");
				
	}
}
