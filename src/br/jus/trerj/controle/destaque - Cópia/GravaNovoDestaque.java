package br.jus.trerj.controle.destaque;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;



public class GravaNovoDestaque extends HttpServlet {

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
		String vdescricao = "";
		String vlink = "";
		String vidConteudo = "";
		String vdataIni = "";
		String vdataFim = "";
		int vpublicado = 1;
		String vsql = "";
		Connection conexao = null;
		//int vidArea = 60;
		//vidArea = 1622;  //teste
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		int vidArea = parametros.getVidAreaDestaque();
		
		String nomeArquivo = "";
		String vnomeAnexo = "";
		String arquivoAnexo = "";
		String vdescricaoAnexo = "";
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
			vlink = multiparts.get(1).getString();
			vdescricaoAnexo = multiparts.get(2).getString();
			vnomeAnexo = multiparts.get(3).getName();
			vdataIni = multiparts.get(4).getString();
			vdataFim = multiparts.get(5).getString();
			vpublicado = Integer.parseInt(multiparts.get(6).getString());
			if (!multiparts.get(8).getString().equals("-"))
			{
				x1 = Integer.parseInt(multiparts.get(8).getString());
				y1 = Integer.parseInt(multiparts.get(9).getString());
				w = Integer.parseInt(multiparts.get(10).getString());
				h = Integer.parseInt(multiparts.get(11).getString());
				//nomeArquivo = multiparts.get(11).getString();
				nomeArquivo = multiparts.get(7).getName();
			}
				//upload no banner
				String extensao = "";
				if (!vnomeAnexo.equals(""))
				{
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
				}
				extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
				String arquivoImgOriginal = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
				String arquivoImgCroped   = "cropped-" + request.getSession().getAttribute("login") + "." + extensao;
				
				try {
					// fazendo o upload do arquivo
					multiparts.get(7).write(new File(diretorio + arquivoImgOriginal));
					/*for (FileItem item : multiparts) {
						if (!item.isFormField()) {
							//String name = new File(item.getName()).getName();
							//item.write(new File(diretorio + File.separator + name));
							//item.write(new File(diretorio + name));
							item.write(new File(diretorio + arquivoImgOriginal));

						}
					}*/
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
						//if (vidConteudo.equals(""))
						//{
							//tem que alterar a ordem (guardada no campo publicado) dos banners existentes
     						vsql = "update gecoi.arquivo set publicado = publicado + 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
     						conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setInt(1, vpublicado);
     						pstm.setInt(2, vidArea);
     						pstm.executeUpdate();
							
							vidConteudo = incluir.incluir(vdescricao, diretorio, arquivoImgCroped, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vdataIni, vdataFim, 0, vlink, vpublicado);
							vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
							if (!vnomeAnexo.equals(""))
								vidConteudo = incluir.incluir(vidConteudo, vdescricaoAnexo, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1, vpublicado, "");
								
						/*}
						else
							vidConteudo = incluir.incluir(vidConteudo, vdescricao, diretorio, arquivoImgCroped, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1);*/
						
					}
					catch(Exception ex){
						System.out.println("grava texto no GECOI: " + ex.getMessage());
						request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
					}
					
				
						try{
							File apagar2 = new File(diretorio + arquivoImgOriginal); // nova imagem 
							apagar2.delete();
							File apagar3 = new File(diretorio + arquivoImgCroped); // imagem cortada
							apagar3.delete();
							if (!vnomeAnexo.equals(""))
							{
								File apagar1 = new File(diretorio + arquivoAnexo); // anexo
								apagar1.delete();								
							}
						}
						catch (Exception e)
						{
							System.out.println("Erro ao apagar: " + e.getMessage());
							request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
						}
					
					request.getSession().setAttribute("erro", "");					
				} 
				catch (Exception e) 
				{
					System.out.println("File upload failed: " + e.getMessage());
			  		request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
				}
			
			PrintWriter out = response.getWriter();
			out.print("<script>top.carregaAPP('/gecoi.3.0/apps/destaques_intranet/index.jsp','');</script>");
		}		
	}
}
