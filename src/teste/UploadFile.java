package teste;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private final String UPLOAD_DIRECTORY = "C:/Files/";

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String UPLOAD_DIRECTORY = getServletContext().getRealPath("/") + "webtemp";
		//String UPLOAD_DIRECTORY = request.getSession().getAttribute("diretorio").toString();
		// 
		// process only if its multipart content
		System.out.println("UPLOAD_DIRECTORY");
		System.out.println(UPLOAD_DIRECTORY);
		if (isMultipart) {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				// Parse the request
				List<FileItem> multiparts = upload.parseRequest(request);
				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						String name = new File(item.getName()).getName();
						System.out.println(UPLOAD_DIRECTORY + File.separator + name);
						item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
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
	}
}