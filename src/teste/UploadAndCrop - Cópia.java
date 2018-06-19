package br.jus.trerj.funcoes;

import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import sun.awt.image.ImageAccessException;
import sun.java2d.loops.ScaledBlit;


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
		System.out.println(diretorio);
		//String diretorio = request.getSession().getAttribute("diretorio").toString();
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
				System.out.println(multiparts.size());
				System.out.println("x1 " + multiparts.get(3).getString());
				System.out.println("y1 " + multiparts.get(4).getString());
				System.out.println("w " + multiparts.get(5).getString());
				System.out.println("h " + multiparts.get(6).getString());
				System.out.println("arquivo " + multiparts.get(7).getString());
				System.out.println("nomeArquivo"+nomeArquivo);
				x1 = Integer.parseInt(multiparts.get(3).getString());
				y1 = Integer.parseInt(multiparts.get(4).getString());
				w = Integer.parseInt(multiparts.get(5).getString());
				h = Integer.parseInt(multiparts.get(6).getString());
				nomeArquivo = multiparts.get(7).getString();
				System.out.println("x1" + x1);
				System.out.println("y1" + y1);
				System.out.println("w" + w);
				System.out.println("h" + h);
				System.out.println("nomeArquivo"+nomeArquivo);
				
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
					//BufferedImage outImage=ImageIO.read(new File(nomeArquivo));					
					/*System.out.println("raster: " + outImage.getRaster());
					System.out.println("width: " + outImage.getWidth());
					System.out.println("height: " + outImage.getHeight());
					System.out.println("tile h: " + outImage.getTileHeight());
					System.out.println("tile w: " + outImage.getTileWidth());
					
					
					System.out.println( outImage.TYPE_INT_RGB);*/
					//PixelGrabber pg = new PixelGrabber(outImage, 0, 0, -1, -1, null, 0 ,0);
					//System.out.println("transparencia: " + pg.getPixels());
/*
import com.lowagie.text.Image;
Image img= Image.getInstance("c:/pathImage.tiff");
img.getDpiX(); // 200, 300, etc...
img.getDpiY(); // 200, 300, etc..
*/
					
					/*JImageAnalyst analyst = JImageAnalystFactory.getDefaultInstance();
					ImageInfo imageInfo = analyst.analyze(inp);					
					System.out.println("Horizontal Resolution : "
							+ imageInfo.getPhysicalHeightDpi() + " dpi");
							// Vertical resolution
							System.out.println("Vertical Resolution : "
							+ imageInfo.getPhysicalHeightDpi() + " dpi");
						*/	
					/*
					// recalcula o x e o y para que as coordenadas não ultrapassem o tamanho da imagem.
					// tem que tirar 16 senão dá erro quando selecionamos até o final da imagem
					if  ((t + w) >= outImage.getWidth())
					{
						t = outImage.getWidth() - w - 16;
						System.out.println("mudei o t");
					}
					if  ((l + h) >= outImage.getHeight())
					{
						l = outImage.getHeight() - h - 16;
						System.out.println("mudei o l");
					}*/
					//t=t-16;
					//l=l-16;
					BufferedImage cropped=outImage.getSubimage(x1, y1, w, h);
					//BufferedImage croppedAux=outImage.getSubimage(0, 0, outImage.getWidth(), outImage.getHeight());
					//ImageIO.write(croppedAux, extensao, new File(diretorio + "\\croppedAux." + extensao)); // save the file with crop dimensions
					ImageIO.write(cropped, extensao, new File(diretorio + "\\cropped." + extensao)); // save the file with crop dimensions
					//System.out.println(imagePath);
					//imagePath = diretorio + "\\croppedAux." + extensao;
					//System.out.println(imagePath);
					//outImage=ImageIO.read(new File(imagePath));
					//BufferedImage cropped=outImage.getSubimage(l, t, w, h);
					///ByteArrayOutputStream out=new ByteArrayOutputStream();
					//ImageIO.write(croppedAux, extensao, out);
					//ImageIO.write(cropped, extensao, new File(diretorio + "\\cropped." + extensao)); // save the file with crop dimensions
					//ImageIO.write(cropped, extensao, new File(imagePath)); // save the file with crop dimensions

					//res.setContentType("image/jpg");
					///ServletOutputStream wrt=response.getOutputStream();
					///wrt.write(out.toByteArray());
					///wrt.flush();
					///wrt.close();
				}
				catch (Exception e) 
				{
					  System.out.println("Crop failed: " + e.getMessage());
					  request.getSession().setAttribute("erro", "Erro no Crop: " + e.getMessage());
				}
				
				response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp?imagem=" + nomeArquivo);
				request.getSession().setAttribute("erro", "");
			} 
			catch (Exception e) 
			{
			  System.out.println("File upload failed: " + e.getMessage());
			  request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
			}
		}		
	}
}
