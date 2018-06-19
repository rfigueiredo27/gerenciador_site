package br.jus.trerj.controle.destaque;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;



public class GravaNovoDestaque
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public GravaNovoDestaque() {}
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String vdescricao = "";
    String vlink = "";
    String vidConteudo = "";
    String vretorno = "";
    String vdataIni = "";
    String vdataFim = "";
    int vpublicado = 1;
    String vsql = "";
    Connection conexao = null;
    

    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
    int vidArea = parametros.getVidAreaDestaque();
    String nomeArquivo = "";
    String vnomeAnexo = "";
    String vtarget = "";
    String arquivoAnexo = "";
    String vdescricaoAnexo = "";
    String arquivoObjeto = "";
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
    IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
    

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
      nomeArquivo = ((FileItem)multiparts.get(0)).getName();
      vdescricao = ((FileItem)multiparts.get(1)).getString();
      vlink = ((FileItem)multiparts.get(2)).getString();
      vdescricaoAnexo = ((FileItem)multiparts.get(3)).getString();
      vnomeAnexo = ((FileItem)multiparts.get(4)).getName();
      vtarget = ((FileItem)multiparts.get(5)).getString();
      vdataIni = ((FileItem)multiparts.get(6)).getString();
      vdataFim = ((FileItem)multiparts.get(7)).getString();
      vpublicado = Integer.parseInt(((FileItem)multiparts.get(8)).getString());

      String extensao = "";
      extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1, nomeArquivo.length());
      arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
      if (arquivoObjeto.lastIndexOf("\\") > -1)
      {
        arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\") + 1);
      }
      
      try
      {
        ((FileItem)multiparts.get(0)).write(new File(diretorio + arquivoObjeto));
        
        if (!vnomeAnexo.equals(""))
        {
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
        }
        



        try
        {
          vsql = "update gecoi.arquivo set publicado = publicado + 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
          conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
          PreparedStatement pstm = conexao.prepareStatement(vsql);
          pstm.setInt(1, vpublicado);
          pstm.setInt(2, vidArea);
          pstm.executeUpdate();
          
          vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), vdataIni, vdataFim, 0, vlink + "@@" + vtarget, vpublicado);
          vidConteudo = vretorno.substring(vretorno.indexOf("#") + 1, vretorno.lastIndexOf("#"));
          if (!vnomeAnexo.equals("")) {
            vidConteudo = incluir.incluir(vidConteudo, vdescricaoAnexo, diretorio, arquivoAnexo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 1, vpublicado, "");
          }
          

        }
        catch (Exception ex)
        {

          System.out.println("grava texto no GECOI: " + ex.getMessage());
          request.getSession().setAttribute("erro", "Erro na gravacao do texto no GECOI: " + ex.getMessage());
        }
        
        try
        {
          File apagar2 = new File(diretorio + arquivoObjeto);
          apagar2.delete();
          if (!vnomeAnexo.equals(""))
          {
            File apagar1 = new File(diretorio + arquivoAnexo);
            apagar1.delete();
          }
        }
        catch (Exception e)
        {
          System.out.println("Erro ao apagar: " + e.getMessage());
          request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());
        }
        
        request.getSession().setAttribute("erro", "");
        MostraTv mostraTv = new MostraTv();
        mostraTv.mostra(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
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