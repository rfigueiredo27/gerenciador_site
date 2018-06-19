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

import br.jus.trerj.funcoes.AlterarGecoiArquivo;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;

public class AlteraCurriculoTexto  extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String vretorno = "";
		String vtexto_arquivo  = "";
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vnomeArquivo = "";
		//int vidArea = 60;
		
		String nomeArquivo = "";
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
			
			vidConteudo  = multiparts.get(0).getString();
			vdescricao = multiparts.get(1).getString();
			vidArquivo  = multiparts.get(2).getString();
			vnomeArquivo  = multiparts.get(3).getString();
			vtexto_arquivo  = multiparts.get(4).getString();
			String vextensao = "";
			if (vnomeArquivo.equals(""))
			{
				vnomeArquivo = "texto-" + request.getSession().getAttribute("login") + ".htm";
				vextensao = ".htm";
			}			
			else
			{
				vextensao = vnomeArquivo.substring(vnomeArquivo.lastIndexOf("."));
				vnomeArquivo = vnomeArquivo.substring(0, vnomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + vextensao;
			}
						
				// gravando o texto
				//File varquivoTexto        = new File(diretorio + "\\texto.htm");
			
				File varquivoTexto        = new File(diretorio + vnomeArquivo);
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
					if (vidArquivo.equals(""))
					{
						IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
						vretorno = incluir.incluir(vidConteudo, vdescricao, diretorio, vnomeArquivo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1, 1, "ativo");
					}
					else
					{
						AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();
						vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vdescricao, diretorio, vnomeArquivo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					}
				}
				catch(Exception ex){
					System.out.println("grava texto no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
				}
			
				try{
					File apagar = new File(diretorio + vnomeArquivo);
					apagar.delete();
				}
				catch (Exception e)
				{
					System.out.println("Erro ao apagar: " + e.getMessage());
			  		request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
				}
			//response.sendRedirect("/gecoi.3.0/apps/curriculo/curriculo.jsp");
				PrintWriter out = response.getWriter();
				out.print("<script>parent.atualizaTela();</script>");
		}		
	}

}
