package teste;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import teste.FileUploadBancoListener;

/**
 * This is a File Upload Servlet that is used with AJAX
 * to monitor the progress of the uploaded file. It will
 * return an XML object containing the meta information
 * as well as the percent complete.
 * 
 * @author Frank T. Rios
 * 
 * Initial Creation Date: 6/24/2007
 */
public class FileUploadBancoServlet 
	extends HttpServlet  
	implements Servlet 
{
	private static final long serialVersionUID = 2740693677625051632L;

	public FileUploadBancoServlet()
	{
		super();
	}
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
    	throws ServletException, IOException 
    {
    	PrintWriter 
    		out = response.getWriter();
    	HttpSession 
    		session = request.getSession();
    	FileUploadBancoListener 
    		listener = null; 
	    StringBuffer
	    	buffy = new StringBuffer();
    	long 
	    	bytesRead = 0,
    		contentLength = 0; 
    	
    	// Make sure the session has started
    	if (session == null)
    	{
    		return;
    	}
    	else if (session != null)
    	{
    		// Check to see if we've created the listener object yet
    		listener = (FileUploadBancoListener)session.getAttribute("LISTENER");
    		
    		if (listener == null)
    		{
    			return;
    		}
    		else
    		{
    			// Get the meta information
    	    	bytesRead = listener.getBytesRead();
    			contentLength = listener.getContentLength();
    		}
    	}
    	
    	/*
    	 * XML Response Code
    	 */
    	response.setContentType("text/xml");
	    
	    buffy.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
	    buffy.append("<response>\n");
	    buffy.append("\t<bytes_read>" + bytesRead + "</bytes_read>\n");
	    buffy.append("\t<content_length>" + contentLength + "</content_length>\n");

	    // Check to see if we're done
	    if (bytesRead == contentLength) 
	    {
		    buffy.append("\t<finished />\n");
		    
		    // No reason to keep listener in session since we're done
			session.setAttribute("LISTENER", null);
	    }
	    else
	    {
	    	// Calculate the percent complete
		    long percentComplete = ((100 * bytesRead) / contentLength);  
	
		    buffy.append("\t<percent_complete>" + percentComplete + "</percent_complete>\n");
	    }
		
	    buffy.append("</response>\n");

	    out.println(buffy.toString());
	    out.flush();
	    out.close();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    	throws ServletException, IOException 
    {
		// create file upload factory and upload servlet
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);

		// set file upload progress listener
		FileUploadBancoListener 
			listener = new FileUploadBancoListener();
		
		HttpSession 
			sessao = request.getSession();
		
		sessao.setAttribute("LISTENER", listener);
		
		// upload servlet allows to set upload listener
		upload.setProgressListener(listener);

		/*List 
			uploadedItems = null;
		FileItem 
			fileItem = null;
		String 
			//filePath = "c:\\temp";	// Path to store file on local system
			filePath = "http:\\\\rjweb12.tre-rj.jus.br\\site\\webtemp";
		System.out.println(filePath);*/
 		try 
		{
 			int idArea = 61;
 			String retorno = "";
 			PrintWriter out = response.getWriter();
 			/*String vsql = "{call gecoi.g_inclusao_arquivo(?, ?, ?, ?, " + 
					"?, ?, ?, " +
					"?, ?, ?, Empty_Blob(), ?, ?, " +
					"?)}";*/
 			
 			String vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ?, ?, ?, ?)";
 			CallableStatement cs;
 			
			List<FileItem> items = upload.parseRequest(request);
			//int total = items.size();
			/*Iterator iteracao = items.iterator();
			while (iteraracao.hasNext())
			{
				FileItem item = (FileItem) iteracao.next();
				if (!item.isFormField())
				{
					is = item.getInputStream();
				}
			}*/
			
			/*FileItem item = items.get(0);
			String numProcesso = item.getString();

			item = items.get(1);
			String anoProcesso = item.getString();
			
			item = items.get(2);
			String numContrato = item.getString();

			item = items.get(3);
			String anoContrato = item.getString();

			item = items.get(4);
			String vigenciaIni = item.getString();

			item = items.get(5);
			String vigenciaFim = item.getString();

			item = items.get(6);
			String descContrato = item.getString();

			item = items.get(7);
			String dataPublicacao = item.getString();
			
			FileItem arquivo = items.get(8);*/
						
			FileItem arquivo = items.get(0);
			
			String vnome = arquivo.getName().toString();
			
			String vnomeArquivo = vnome.substring(vnome.lastIndexOf("\\")+1); //nome do arquivo		
						
			//HttpSession sessao = request.getSession(true);
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@rjdbs03:1521:ursa",  "gecoi", "5851385");
			//Connection connection = (Connection) sessao.getAttribute("connection");

			//sessao.setAttribute("LISTENER", listener);
			
			// upload servlet allows to set upload listener
			upload.setProgressListener(listener);
			
			cs = connection.prepareCall(vsql);
			/*
			// variáveis da inclusão de conteudo
			cs.setString(1,"1/12-2/12-descContrato"); //descricao_conteudo
			cs.setString(2,"01/12/2013 a 30/12/2013");//vobservacao
			cs.setString(3,"gecoi"); //vlogon_usuario_criacao
			cs.setString(4,"gecoi"); //vlogon_usuario_ult_alteracao
			
			// variáveis da inclusão de conteudo_area
			cs.setInt(5, idArea); //vid_area
			cs.setString(6,"01/12/2013"); //vdata_inicio_exib
			cs.setDate(7, null);
			
			// variáveis da inclusão de arquivo
			cs.setString(8,"1/12-2/12-descContrato"); //vdescricao_arquivo
			cs.setBinaryStream(9,arquivo.getInputStream(), (int) arquivo.getSize()); //arquivo
			cs.setString(10,vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")));//nome
			cs.setString(11,"");//nome_arquivo_reduzido
			cs.setInt(12,0);//ordem
			
			// retorno
			cs.registerOutParameter(13, OracleTypes.VARCHAR); //retorno
			*/
						
			// retorno
			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    	
			//List<FileItem> items = upload.parseRequest(request);
			//FileItem arquivo = items.get(0);			
			//String vnome = arquivo.getName().toString();

			// variáveis da alteração do conteúdo
			cs.setInt(2,77584); //id do conteudo
			cs.setString(3,"descricao"); //descricao
			cs.setString(4,"observacao"); //observacao
			cs.setString(5,"usuario"); //usuario

			// variáveis da inclusão de arquivo
			//File arquivo = new File(diretorio + nomeArquivo);
			//FileInputStream fis = new FileInputStream(arquivo);
			//cs.setBinaryStream(6, fis, (int)arquivo.length());
			//cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
			cs.setBinaryStream(6,arquivo.getInputStream(), (int) arquivo.getSize()); //arquivo
			cs.setString(7,vnomeArquivo.substring(vnomeArquivo.lastIndexOf(".")+1));//extensao

			cs.setInt(8,5); //ordem
			cs.setInt(9,2);//publicado

			cs.execute();
			//retorno = cs.getString(13);
			
			out.println(retorno);
			connection.close();
			
 			/*
			// iterate over all uploaded files
			uploadedItems = upload.parseRequest(request);
			
			Iterator i = uploadedItems.iterator();
			
			while (i.hasNext()) 
			{
				fileItem = (FileItem) i.next();
				
				if (fileItem.isFormField() == false) 
				{
					if (fileItem.getSize() > 0) 
					{
						File 
							uploadedFile = null; 
						String
							myFullFileName = fileItem.getName(),
							myFileName = "",
							slashType = (myFullFileName.lastIndexOf("\\") > 0) ? "\\" : "/"; // Windows or UNIX
						int
							startIndex = myFullFileName.lastIndexOf(slashType);

						// Ignore the path and get the filename
						myFileName = myFullFileName.substring(startIndex + 1, myFullFileName.length());

						// Create new File object
						uploadedFile = new File(filePath, myFileName);
						
						// Write the uploaded file to the system
						fileItem.write(uploadedFile);
					}
				}
			}
			*/
		} 
		catch (FileUploadException e) 
		{
			e.printStackTrace();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
	}       
}
