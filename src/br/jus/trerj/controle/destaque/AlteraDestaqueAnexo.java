package br.jus.trerj.controle.destaque;

import br.jus.trerj.funcoes.AlterarGecoiArquivo;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AlteraDestaqueAnexo
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public AlteraDestaqueAnexo() {}
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String vnomeAnexo = "";
    String arquivoAnexo = "";
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
    


    if (isMultipart)
    {
      FileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      List<FileItem> multiparts = null;
      try {
        multiparts = upload.parseRequest(request);
      }
      catch (FileUploadException e1) {
        e1.printStackTrace();
      }
      vnomeAnexo = ((FileItem)multiparts.get(3)).getName();
      String extensao = "";
      
      try
      {
        extensao = vnomeAnexo.substring(vnomeAnexo.lastIndexOf(".") + 1, vnomeAnexo.length());
        arquivoAnexo = "anexo-" + request.getSession().getAttribute("login") + "." + extensao;
        ((FileItem)multiparts.get(3)).write(new File(diretorio + arquivoAnexo));
      }
      catch (Exception e)
      {
        System.out.println("Anexo failed: " + e.getMessage());
        request.getSession().setAttribute("erro", "Erro no Anexo: " + e.getMessage());
      }
      
      try
      {
        if (((FileItem)multiparts.get(3)).getSize() > 0L)
        {
          AlterarGecoiArquivo e = new AlterarGecoiArquivo();
        }
        else
        {
        	AlteraDestaque e = new AlteraDestaque();
        }
      }
      catch (Exception ex) {
        System.out.println("grava texto no GECOI: " + ex.getMessage());
        request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
      }
      try
      {
        File apagar = new File(diretorio + arquivoAnexo);
        apagar.delete();
      }
      catch (Exception e)
      {
        System.out.println("Erro ao apagar: " + e.getMessage());
        request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());
      }
      request.getSession().setAttribute("erro", "");
      
      MostraTv mostraTv = new MostraTv();
      try {
        mostraTv.mostra(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
      }
      catch (ClassNotFoundException e) {
        e.printStackTrace();
      }
      catch (SQLException e) {
        e.printStackTrace();
      }
    }
    
    PrintWriter out = response.getWriter();
    out.print("<script>parent.atualizaTela();</script>");
  }
}