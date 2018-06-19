package teste;

import java.awt.image.BufferedImage;
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

/**
* Crop
* @author RVashi
*
*/
public class Crop extends HttpServlet {

private static final long serialVersionUID = 1L;

public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException,ServletException{
	int x1=Integer.parseInt(req.getParameter("x1"));
	int y1=Integer.parseInt(req.getParameter("y1"));
	int w=Integer.parseInt(req.getParameter("w"));
	int h=Integer.parseInt(req.getParameter("h"));
	//String nomeArquivo = req.getParameter("i");	
	String nomeArquivo = req.getParameter("arquivo");
	String imagePath = getServletContext().getRealPath("/") + "webtemp/" + nomeArquivo;
	Crop crop = new Crop();
	doCrop(x1, y1, w, h, nomeArquivo, imagePath);
	crop.destroy();
}

public void doCrop(int x1, int y1, int w, int h, String nomeArquivo, String imagePath) {
	try
	{		
	//System.out.println("0-"+nomeArquivo);
	//System.out.println("1-"+imagePath);
		//String CroppedPath = getServletContext().getRealPath("/") + "webtemp\\";
		//System.out.println("croppedpath " + CroppedPath);
		String extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
		//String imagePath = diretorio + "\\" + nomeArquivo;
	//System.out.println("extensao: " + extensao);
	//System.out.println("imagepath + nomearquivo" + imagePath + nomeArquivo);
		BufferedImage outImage=ImageIO.read(new File(imagePath + nomeArquivo));
		if (w == 0)
		{
			w = outImage.getWidth();
		}
		if (h == 0)
		{
			h = outImage.getHeight();
		}
		
		BufferedImage cropped=outImage.getSubimage(x1, y1, w, h);
		//ImageIO.write(cropped, extensao, new File(CroppedPath + "cropped." + extensao)); // save the file with crop dimensions
		ImageIO.write(cropped, extensao, new File(imagePath + "cropped." + extensao)); // save the file with crop dimensions
		System.out.println(imagePath + "cropped." + extensao);
		//ImageIO.write(cropped, extensao, new File(imagePath)); // save the file with crop dimensions

		//ByteArrayOutputStream out=new ByteArrayOutputStream();
		//ImageIO.write(cropped, extensao, out);
		//res.setContentType("image/jpg");
		//ServletOutputStream wrt=res.getOutputStream();
		//wrt.write(out.toByteArray());
		//wrt.flush();
		//wrt.close();
	}
	catch (Exception e) 
	{
		  System.out.println("Crop failed: " + e.getMessage());
		  //req.getSession().setAttribute("erro", "Erro no Crop: " + e.getMessage());
	}

	}

}