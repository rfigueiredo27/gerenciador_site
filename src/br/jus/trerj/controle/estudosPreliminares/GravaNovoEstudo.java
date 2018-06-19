package br.jus.trerj.controle.estudosPreliminares;

import be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory;
import be.telio.mediastore.ui.upload.UploadListener;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.CadastroReferencia;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.Connection;
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
import org.apache.commons.fileupload.servlet.ServletFileUpload;



public class GravaNovoEstudo
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public GravaNovoEstudo() {}
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String descricao = "";
    int vidArea = 0;
    String vretorno = "";
    String vidConteudo = "";
    String vidArquivo = "";
    String vidArquivoPrincipal = "";
    String nomeArquivo = "";
    String arquivoObjeto = "";
    String dataPublicacao = "";
    

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
    IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
    

    if (isMultipart)
    {
      UploadListener listener = new UploadListener(request, 30L);
      
      FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
      
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      List<FileItem> multiparts = null;
      try {
        multiparts = upload.parseRequest(request);
      }
      catch (FileUploadException e1) {
        e1.printStackTrace();
      }
      
      Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
      
      vidArea = parametros.getVidEstudosPreliminares();
      

      vidArquivoPrincipal = ((FileItem)multiparts.get(0)).getString();
      dataPublicacao = ((FileItem)multiparts.get(3)).getString();
      


      descricao = ((FileItem)multiparts.get(4)).getString();
      nomeArquivo = ((FileItem)multiparts.get(5)).getName();
      PrintWriter out = response.getWriter();
      




      String extensao = "";
      extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1, nomeArquivo.length());
      arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + " - " + request.getSession().getAttribute("login") + "." + extensao;
      if (arquivoObjeto.lastIndexOf("\\") > -1)
      {
        arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\") + 1);
      }
      try
      {
        ((FileItem)multiparts.get(5)).write(new File(diretorio + arquivoObjeto));
        
        
        try
        {
          Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
          conexao.setAutoCommit(false);
          



          vretorno = incluir.incluir(descricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, null + " a " + null, 0);
          vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
          vidConteudo = vretorno.substring(vretorno.indexOf("#") + 1);
          
          CadastroReferencia incluirReferencia = new CadastroReferencia();
          incluirReferencia.incluir(Integer.parseInt(vidArquivoPrincipal), Integer.parseInt(vidArquivo), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 0);
          
          conexao.commit();
        }
        catch (Exception ex) {
          System.out.println("grava arquivo no GECOI: " + ex.getMessage());
          request.getSession().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
        }
        
        try
        {
          File apagar = new File(diretorio + arquivoObjeto);
          apagar.delete();
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
      

      out.print("<script>parent.atualizaTela();</script>");
    }
  }
}
