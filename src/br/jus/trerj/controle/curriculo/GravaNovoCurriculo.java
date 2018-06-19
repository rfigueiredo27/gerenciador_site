package br.jus.trerj.controle.curriculo;

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

import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.modelo.Parametros;



public class GravaNovoCurriculo extends HttpServlet {

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
		String vtexto_arquivo  = "";
		String vdescricao = "";
		String vidConteudo = "";
		//int vidArea = 60;
		//vidArea = 1622;  //teste
		Parametros parametros = new Parametros();
		int vidArea = parametros.getVidAreaCurriculo();
		
		String nomeArquivo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
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
			vdescricao = multiparts.get(0).getString();
			vtexto_arquivo  = multiparts.get(1).getString();
			if (!multiparts.get(3).getString().equals("-"))
			{
				x1 = Integer.parseInt(multiparts.get(3).getString());
				y1 = Integer.parseInt(multiparts.get(4).getString());
				w = Integer.parseInt(multiparts.get(5).getString());
				h = Integer.parseInt(multiparts.get(6).getString());
				nomeArquivo = multiparts.get(7).getString();
			}
						
			if (!vtexto_arquivo.equals(""))
			{
				
				// gravando o texto
				String vnomeArquivoTexto = "texto-" + request.getSession().getAttribute("login") + ".htm";
				File varquivoTexto        = new File(diretorio + vnomeArquivoTexto);
				try {
				   FileOutputStream gravador = new FileOutputStream(varquivoTexto);
				   gravador.write(vtexto_arquivo.getBytes());
				   gravador.close();
				}
				catch(Exception ex){
				  System.out.println("grava texto: " + ex.getMessage());
				  request.getSession().setAttribute("erro", "Erro na gravacao do texto: " + ex.getMessage());
				}
				//Gravar arquivo texto no banco
				try {					
					vidConteudo = incluir.incluir(vdescricao, diretorio, vnomeArquivoTexto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), "", "", 0, "", 1); //sem data_inicio_publicacao e data_fim_publicacao; ordem=0; observacao=; publicado=1 (ativo)
					vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
				}
				catch(Exception ex){
					System.out.println("grava texto no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
				}
			}
			
			if (x1 > 0)
			{
				//upload na foto
				String extensao = "";
				extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
				String arquivoImgOriginal = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
				String arquivoImgCroped   = "cropped-" + request.getSession().getAttribute("login") + "." + extensao;
				try {				
					// fazendo o upload do arquivo
					for (FileItem item : multiparts) {
						if (!item.isFormField()) {
							//String name = new File(item.getName()).getName();
							//item.write(new File(diretorio + File.separator + name));
							//item.write(new File(diretorio + name));
							item.write(new File(diretorio + arquivoImgOriginal));
						}
					}
					try
					{
						//crop na foto
						extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
						//String imagePath = diretorio + nomeArquivo;
						String imagePath = diretorio + arquivoImgOriginal;
						BufferedImage outImage=ImageIO.read(new File(imagePath));
						BufferedImage cropped=outImage.getSubimage(x1, y1, w, h);
						ImageIO.write(cropped, extensao, new File(diretorio + arquivoImgCroped)); // save the file with crop dimensions
					}
					catch (Exception e) 
					{
					  System.out.println("Crop failed: " + e.getMessage());
					  request.getSession().setAttribute("erro", "Erro no Crop: " + e.getMessage());
					}
					
					//Gravar foto no banco
					try {
						if (vidConteudo.equals(""))
							vidConteudo = incluir.incluir(vdescricao, diretorio, arquivoImgCroped, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), "", "", 0, "", 1); //sem data_inicio_publicacao e data_fim_publicacao; ordem=0; observacao=; publicado=1 (ativo)
						else
							vidConteudo = incluir.incluir(vidConteudo, vdescricao, diretorio, arquivoImgCroped, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1, 1, "ativo");
						vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
					}
					catch(Exception ex){
						System.out.println("grava texto no GECOI: " + ex.getMessage());
						request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
					}
					
					if (!vtexto_arquivo.equals(""))
					{
						try{
							String vnomeArquivoTexto = "texto-" + request.getSession().getAttribute("login") + ".htm";
							File apagar = new File(diretorio + vnomeArquivoTexto);
							apagar.delete();
						}
						catch (Exception e)
						{
							System.out.println("Erro ao apagar: " + e.getMessage());
							request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
						}
					}
				
					if (x1 > 0)
					{
						try{
							File apagar2 = new File(diretorio + arquivoImgOriginal); // nova imagem 
							apagar2.delete();
							File apagar3 = new File(diretorio + arquivoImgCroped); // imagem cortada
							apagar3.delete();
						}
						catch (Exception e)
						{
							System.out.println("Erro ao apagar: " + e.getMessage());
							request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
						}
					}
					
					request.getSession().setAttribute("erro", "");					
				} 
				catch (Exception e) 
				{
					System.out.println("File upload failed: " + e.getMessage());
			  		request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
				}
			}
			//response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp");
			PrintWriter out = response.getWriter();
			out.print("<script>top.carregaAPP('/gecoi.3.0/apps/curriculo/index.jsp','');</script>");
		}		
	}
}
