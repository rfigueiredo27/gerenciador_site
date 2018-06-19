package teste;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;



public class UploadAndCrop extends HttpServlet {

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
		
		String nomeArquivo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp";
		// 
		// process only if its multipart content
		if (isMultipart) {
			// Pegando os dados do formulario
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				// Parse the request
				// Pegando os dados do formulario
				List<FileItem> multiparts = upload.parseRequest(request);
				x1 = Integer.parseInt(multiparts.get(4).getString());
				y1 = Integer.parseInt(multiparts.get(5).getString());
				w = Integer.parseInt(multiparts.get(6).getString());
				h = Integer.parseInt(multiparts.get(7).getString());
				nomeArquivo = multiparts.get(8).getString();
				
				// fazendo o upload do arquivo
				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						String name = new File(item.getName()).getName();
						item.write(new File(diretorio + File.separator + name));
					}
				}
				
				try
				{
					//crop
					String extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
					String imagePath = diretorio + "\\" + nomeArquivo;
					BufferedImage outImage=ImageIO.read(new File(imagePath));
					BufferedImage cropped=outImage.getSubimage(x1, y1, w, h);
					ImageIO.write(cropped, extensao, new File(diretorio + "\\cropped." + extensao)); // save the file with crop dimensions
				}
				catch (Exception e) 
				{
					  System.out.println("Crop failed: " + e.getMessage());
					  request.getSession().setAttribute("erro", "Erro no Crop: " + e.getMessage());
				}
				
				request.getSession().setAttribute("erro", "");
				response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp");
			} 
			catch (Exception e) 
			{
			  System.out.println("File upload failed: " + e.getMessage());
			  request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
			}
		}		
	}
}
