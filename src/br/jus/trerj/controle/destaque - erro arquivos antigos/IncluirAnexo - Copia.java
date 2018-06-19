package br.jus.trerj.controle.destaque;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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



public class IncluirAnexo extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String vretorno = "";
		String vidConteudo = "";
		int vpublicado = 0;
		String vsql = "";
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		//int vidArea = parametros.getVidAreaDestaque();
		
		int vordem = 0;
		//String nomeArquivo = "";
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
			vidConteudo = multiparts.get(0).getString();
			vdescricaoAnexo = multiparts.get(1).getString();
			vnomeAnexo = multiparts.get(2).getName();
				//upload no banner
				String extensao = "";
					try {
						
						extensao = vnomeAnexo.substring(vnomeAnexo.lastIndexOf(".")+1, vnomeAnexo.length());
						arquivoAnexo = "anexo" + "-" + request.getSession().getAttribute("login") + "." + extensao;
						multiparts.get(2).write(new File(diretorio + arquivoAnexo));
					}
					catch (Exception e) 
					{
					  System.out.println("Anexo failed: " + e.getMessage());
					  request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
					}
				
					
					//Gravar anexo no banco
					try {
						/*
						//if (vidConteudo.equals(""))
						//{
							//tem que alterar a ordem (guardada no campo publicado) dos banners existentes
     						vsql = "update gecoi.arquivo set publicado = publicado + 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
     						conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
     						PreparedStatement pstm = conexao.prepareStatement(vsql);
     						pstm.setInt(1, vpublicado);
     						pstm.setInt(2, vidArea);
     						pstm.executeUpdate();*/
							
 						vsql = "select (max(ordem) + 1) as ordem, max(publicado) as publicado from gecoi.arquivo where id_conteudo = ?";
 						conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
 						PreparedStatement pstm = conexao.prepareStatement(vsql);
 						pstm.setInt(1, Integer.parseInt(vidConteudo));
 						ResultSet rs = pstm.executeQuery();
 						rs.next();
 						vordem = rs.getInt("ordem");
 						vpublicado = rs.getInt("publicado");
						vretorno = incluir.incluir(vidConteudo, vdescricaoAnexo, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vordem, vpublicado, "");
								
						/*}
						else
							vidConteudo = incluir.incluir(vidConteudo, vdescricao, diretorio, arquivoImgCroped, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1);*/
						
					}
					catch(Exception ex){
						System.out.println("grava texto no GECOI: " + ex.getMessage());
						request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
					}
					
				
						try{
							File apagar = new File(diretorio + arquivoAnexo); // nova imagem 
							apagar.delete();
						}
						catch (Exception e)
						{
							System.out.println("Erro ao apagar: " + e.getMessage());
							request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
						}
					
					System.out.println(vretorno);
					request.getSession().setAttribute("erro", "");					
				} 
			
			//PrintWriter out = response.getWriter();
			//out.print("<script>top.carregaAPP('/gecoi.3.0/apps/destaques_intranet/destaque.jsp','');</script>");
			response.sendRedirect("/gecoi.3.0/apps/destaques_intranet/alterar_anexo.jsp?idConteudo=" + vidConteudo);
				
	}
}
