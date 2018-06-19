package br.jus.trerj.controle.destaque;

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
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import br.jus.trerj.funcoes.AlterarGecoiArquivo;

public class AlteraDestaqueAnexo extends HttpServlet {

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
		String vnomeAnexo = "";
		String arquivoAnexo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		
		// 
		// process only if its multipart content
		if (isMultipart) {
			// Pegando os dados do formulario
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> multiparts = null;
			try {
				multiparts = upload.parseRequest(request);
			} catch (FileUploadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			vidArquivo = multiparts.get(0).getString();
			vidConteudo = multiparts.get(1).getString();
			vdescricao = multiparts.get(2).getString();
			vnomeAnexo = multiparts.get(3).getName();
			String extensao = "";			
				//upload no anexo
			try {
				
				extensao = vnomeAnexo.substring(vnomeAnexo.lastIndexOf(".")+1, vnomeAnexo.length());
				arquivoAnexo = "anexo" + "-" + request.getSession().getAttribute("login") + "." + extensao;
				multiparts.get(3).write(new File(diretorio + arquivoAnexo));
			}
			catch (Exception e) 
			{
			  System.out.println("Anexo failed: " + e.getMessage());
			  request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
			}
					
			//Gravar anexo no banco
			try {
				if (multiparts.get(3).getSize() > 0)
				{
					AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();
					vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vdescricao, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				}
				else
				{
					AlteraDestaque altera = new AlteraDestaque();
					vretorno = altera.alterar(vidConteudo, vidArquivo, vdescricao, "", "", "", 0, 0, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				}
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
			request.getSession().setAttribute("erro", "");
				
		} 
		PrintWriter out = response.getWriter();
		out.print("<script>parent.atualizaTela();</script>");
	}
}
