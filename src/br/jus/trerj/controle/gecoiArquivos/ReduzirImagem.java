package br.jus.trerj.controle.gecoiArquivos;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.swing.ImageIcon;

import org.apache.commons.fileupload.FileItem;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ReduzirImagem {
	
	
	
	public ReduzirImagem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void ReduzImagem(FileItem arquivo, String vdirName, String vnomeArquivo) throws ImageFormatException, IOException{

		long vtamanho       = 0;  //tamanho do arquivo
		int vlargura        = 0;  //largura da imagem
		int valtura         = 0;  //altura da imagem
		int vreducao        = 0;  //porcentagem de redução da imagem
		int vidconteudo     = 0;  //id do conteudo para gravar o arquivo
		int vidarquivo      = 0;  //id do arquivo
		int vdiagonal       = 0;  //valor da diagonal da imagem
		vtamanho = arquivo.getSize(); //tamanho do arquivo

		//Se o arquivo for uma imagem e tiver tamanho maior que 500k
		if ((vtamanho > 500000)) 
		{
			Image image = new ImageIcon(vdirName + "/" + vnomeArquivo).getImage();
			vlargura = image.getWidth(null);
			valtura  = image.getHeight(null);
			vdiagonal = (int)Math.sqrt((vlargura*vlargura) + (valtura*valtura));

			//Redimensionar imagem principal
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			//760 é o tamanho da diagonal que as imagens deverão ter ao ser incluídas no banco para o tamanho tipo álbum
			//se a diagonal for maior que a constante então é necessária a sua redução
			if (vdiagonal>760)
			{

				//calculando a altura e comprimento para a redução
				valtura  = (valtura*760)/vdiagonal;
				vlargura = (vlargura*760)/vdiagonal;

				//reduzindo a imagem
				BufferedImage thumbImage = new BufferedImage(vlargura, valtura,	BufferedImage.TYPE_INT_RGB);

				Graphics2D graphics2D = thumbImage.createGraphics();

				graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
				graphics2D.drawImage(image, 0, 0, vlargura, valtura, null);

				BufferedOutputStream saida;

				//grava a imagem no servidor
				saida = new BufferedOutputStream(new FileOutputStream(vdirName + "/" + vnomeArquivo));

				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(saida);
				JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(thumbImage);

				int quality = Math.max(0, Math.min(90, 100));
				param.setQuality((float) quality / 100.0f, false);

				encoder.setJPEGEncodeParam(param);
				encoder.encode(thumbImage);

				saida.close();
			}

			//Retirei para reduzir a imagem do arquivo_reduzido			
			//Cálculo do percentual de redução para a miniatura da imagem
			//361 é o tamanho da diagonal que a imagem deverá ter após a redução no tamanho tipo miniatura
			vreducao = 100 - (int)((344 /  Math.sqrt((vlargura*vlargura) + (valtura*valtura)))*100);

			//Se o resultado do cálculo for um número negativo
			if (vreducao<0)
				vreducao=0;		
			else
			{
				//calculando a altura e comprimento para a redução
				valtura  = valtura - ((valtura*vreducao)/100);
				vlargura = vlargura - ((vlargura*vreducao)/100);

				//reduzindo a imagem
				BufferedImage thumbImage = new BufferedImage(vlargura, valtura,	BufferedImage.TYPE_INT_RGB);

				Graphics2D graphics2D = thumbImage.createGraphics();

				graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
				graphics2D.drawImage(image, 0, 0, vlargura, valtura, null);

				BufferedOutputStream saida;

				//grava a imagem no servidor
				saida = new BufferedOutputStream(new FileOutputStream(vdirName + "/redu" + vnomeArquivo));

				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(saida);
				JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(thumbImage);

				int quality = Math.max(0, Math.min(90, 100));
				param.setQuality((float) quality / 100.0f, false);

				encoder.setJPEGEncodeParam(param);
				encoder.encode(thumbImage);

				saida.close();
			}

		}
		

	}

}
