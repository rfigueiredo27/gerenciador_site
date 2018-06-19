package teste;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

public class Crop2 {
	public void doCrop(int t, int l, int w, int h, String nomeArquivo, String imagePath) {
		try
		{		
		
			String extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
			//String imagePath = diretorio + "\\" + nomeArquivo;

			BufferedImage outImage=ImageIO.read(new File(imagePath));
			BufferedImage cropped=outImage.getSubimage(l, t, w, h);
			//ImageIO.write(cropped, extensao, new File(diretorio + "\\cropped." + extensao)); // save the file with crop dimensions
			ImageIO.write(cropped, extensao, new File(imagePath)); // save the file with crop dimensions

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
