package br.jus.trerj.controle.destaque;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.imageio.ImageIO;
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
import br.jus.trerj.funcoes.IncluirGecoiArquivo;

public class AlteraDestaqueBanner extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int x1 = 0;
		int y1 = 0;
		int w = 0;
		int h = 0;
		String vretorno = "";
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vimagem = "";  // guarda a imagem pega no banco
		String arquivoImgCroped = "";
		String arquivoImgOriginal = "";
		//int vidArea = 60;
		
		String vnomeArquivo = "";
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
			if (multiparts.get(4).getString().equals(""))
			{
				diretorio = getServletContext().getRealPath("/");
				arquivoImgCroped = "img\\semfoto.jpg";
				vdescricao = multiparts.get(5).getString();						
				vidArquivo = multiparts.get(6).getString();
				vidConteudo = multiparts.get(7).getString();
			}
			else
			{
				x1 = Integer.parseInt(multiparts.get(0).getString());
				y1 = Integer.parseInt(multiparts.get(1).getString());
				w = Integer.parseInt(multiparts.get(2).getString());
				h = Integer.parseInt(multiparts.get(3).getString());
				vnomeArquivo = multiparts.get(4).getString();
				vdescricao = multiparts.get(5).getString();						
				vidArquivo = multiparts.get(6).getString();
				vidConteudo = multiparts.get(7).getString();
				vimagem = multiparts.get(8).getString().replace("/", "\\"); // imagem recuperada do banco antes da alteração
				String extensao = "";
				extensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1, vnomeArquivo.length());
				String imagePath = "";
				arquivoImgOriginal = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao; // nova imagem escolhida pelo usuario
				arquivoImgCroped   = "cropped-" + request.getSession().getAttribute("login") + "." + extensao; // imagem cortada que será gravada no banco
			
				//upload na foto
				try {				
					// fazendo o upload do arquivo
					for (FileItem item : multiparts) {
						if (!item.isFormField()) {
							//String name = new File(item.getName()).getName();
							//name = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao; 
							//item.write(new File(diretorio + File.separator + name));
							//item.write(new File(diretorio + name));
							item.write(new File(diretorio + arquivoImgOriginal));
						}
					}
					try
					{
						//crop na foto
					
						//String imagePath = diretorio + vnomeArquivo;
						imagePath = diretorio + arquivoImgOriginal;
						BufferedImage outImage=ImageIO.read(new File(imagePath));
						BufferedImage cropped=outImage.getSubimage(x1, y1, w, h);
						ImageIO.write(cropped, extensao, new File(diretorio + arquivoImgCroped)); // save the file with crop dimensions
					}
					catch (Exception e) 
					{
						System.out.println("Crop failed: " + e.getMessage());
						request.getSession().setAttribute("erro", "Erro no Crop: " + e.getMessage());
					}
				} 
				catch (Exception e) 
				{
					System.out.println("File upload failed: " + e.getMessage());
					request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
				}
					
			}
				//Gravar foto no banco
				try {
					// cropped. + extensao é o arquivo já recortado, enquanto o nome arquivo é a foto inteira sem cortes
					AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();
					vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vdescricao, diretorio, arquivoImgCroped, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				}
				catch(Exception ex){
					System.out.println("grava texto no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
				}
				
				try{
					File apagar2 = new File(diretorio + arquivoImgOriginal); // nova imagem 
					apagar2.delete();
					File apagar3 = new File(diretorio + vimagem);  // imagem que estava no banco
					apagar3.delete();
					File apagar = new File(diretorio + arquivoImgCroped); // imagem cortada
					apagar.delete();
				}
				catch (Exception e)
				{
					System.out.println("Erro ao apagar: " + e.getMessage());
			  		request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
				}
				request.getSession().setAttribute("erro", "");
				
			//response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp");
			PrintWriter out = response.getWriter();
			out.print("<script>parent.atualizaTela();</script>");
		}		
	}
}
