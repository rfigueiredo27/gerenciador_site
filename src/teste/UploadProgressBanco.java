package teste;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory;
import be.telio.mediastore.ui.upload.UploadListener;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.modelo.Parametros;

public class UploadProgressBanco extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String vdescricao = "";
		String vlink = "";
		String vidConteudo = "";
		String vdataIni = "";
		String vdataFim = "";
		int vpublicado = 0;
		String extensao = "";
		String arquivoAnexo = "";
		String vmsg  = "";    //mensagem para o usuário
		Parametros parametros = new Parametros();
		int vidArea = parametros.getVidAreaDestaque();
		
		String vnomeAnexo = "";
		//String arquivoAnexo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		// 
		// process only if its multipart content
		if (isMultipart) {
			//Listener para a barra de progresso
		      UploadListener listener = new UploadListener(request, 30);
		      // Create a factory for disk-based file items
		      FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
		      // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		      // Set upload parameters   
		      //upload.setSizeMax(70*1024*1024); //70Mb
		    //fim listener
			
			List<FileItem> multiparts = null;
			try {
				multiparts = upload.parseRequest(request);
			} catch (FileUploadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			vdescricao = multiparts.get(0).getString();
			vnomeAnexo = multiparts.get(1).getName();
				//upload no banner
				//String extensao = "";
				if (!vnomeAnexo.equals(""))
				{
					try {
						
						extensao = vnomeAnexo.substring(vnomeAnexo.lastIndexOf(".")+1, vnomeAnexo.length());
						arquivoAnexo = "anexo" + "-" + request.getSession().getAttribute("login") + "." + extensao;
						
						multiparts.get(1).write(new File(diretorio + arquivoAnexo));
					}
					catch (Exception e) 
					{
					  System.out.println("Anexo failed: " + e.getMessage());
					  //request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
					  vmsg = "Erro no upload do arquivo: " + e.getMessage(); 
					}
				}
				
					
					//Gravar arquivo no banco
					try {
							
							vidConteudo = incluir.incluir(vdescricao, diretorio, arquivoAnexo, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vdataIni, vdataFim, 0, vlink, vpublicado);
							vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
							//if (!vnomeAnexo.equals(""))
								//vidConteudo = incluir.incluir(vidConteudo, vdescricaoAnexo, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1, vpublicado, "");
								
						
					}
					catch(Exception ex){
						System.out.println("grava texto no GECOI: " + ex.getMessage());
						//request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
						vmsg = "Erro na gravacao do arquivo no GECOI: " + ex.getMessage();
					}
					
				
						try{
							if (!vnomeAnexo.equals(""))
							{
								File apagar1 = new File(diretorio + arquivoAnexo); // anexo
								apagar1.delete();								
							}
						}
						catch (Exception e)
						{
							System.out.println("Erro ao apagar: " + e.getMessage());
							//request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());
							vmsg = "Erro ao apagar o arquivo: " + e.getMessage();
						}
					
					//request.getSession().setAttribute("erro", "");					
			
		            PrintWriter out = response.getWriter();
		            out.println("<html>");
		            out.println("<head>");
	   	            out.println("<script language='javascript'>");
	   //mostra o resultado do upload ao usuário
	   	 	        out.println("parent.document.getElementById('mensagem_caixa').innerHTML = '" + vmsg.replaceAll("\\n","") + "';");
	   		        out.println("parent.document.getElementById('campoArquivo').style.display = 'block';");
	   		 	    out.println("parent.document.getElementById('progressBar').style.display = 'none';");
	   			    out.println("parent.document.getElementById('mensagem_caixa').style.display = 'block';");   
	   
	   			 	out.println("if(parent.document.getElementById('mensagem_caixa').innerHTML.indexOf('sucesso')>0)");
	   			 	out.println("parent.document.getElementById('mensagem_caixa').className = 'sucesso';");
	   			 	out.println("else");	   
		            out.println("parent.document.getElementById('mensagem_caixa').className = 'erro';");
		            out.println("parent.document.anexo.reset();");
	   
		            out.println("</script>");
		            out.println("</head>");
		            out.println("<body>");
		            out.println("</body>");
		            out.println("</html>");
		}		
	}
}
