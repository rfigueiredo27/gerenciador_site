package br.jus.trerj.funcoes;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UltimasNoticiasComImagem
{
  public UltimasNoticiasComImagem() {}
  
  public String ultimasTV(String vusuario, String vsenha) throws java.io.IOException, ClassNotFoundException, SQLException
  {
    String vnomeDiretorioFisico = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\noticias_publicacoes\\noticias\\";
    




    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "ultimas_noticias_com_imagem_pronto.htm");
    
    escreveLinha("<script type=\"text/javascript\" src=\"/intra_nova/noticias_publicacoes/noticias/scripts/jquery.infinitecarousel.js\"></script>", varquivoDestino);
    escreveLinha("<link rel=\"stylesheet\" type=\"text/css\" href=\"/intra_nova/noticias_publicacoes/noticias/css/carousel.css\"/>", varquivoDestino);
    escreveLinha("<script type=\"text/javascript\">$(function(){$('#carousel1').infiniteCarousel({displayThumbnailBackground:0});});</script>", varquivoDestino);
    
    Parametros parametros = new Parametros("Produção");
    
    int vid_area = parametros.getVidAreaNoticiaIntranet();
    int vid_area1 = 2661; 
    
    int i = 0;
    String vmsg = "";
    
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    try
    {
      /*String vsql = "SELECT * FROM (" 
    		  + "SELECT np.id_conteudo, ir.imagem, im.id_arquivo_principal, descricao, im.nome, ir.nome_arquivo_reduzido as nome_imagem, " 
    		  + "publicado, pasta_fisica, To_Char(data_ult_alteracao, 'yyyymmddhh24mi') AS data_ult_alteracao "
    		  + "from (SELECT a.id_conteudo, Nvl(ar.pasta_fisica, 'gecoi_arquivos/webtemp') AS pasta_fisica, Min(a.ordem) AS ordem, "
    		  + "Min(co.data_ult_alteracao) AS data_ult_alteracao, Min(a.publicado) AS publicado "
    		  + "FROM gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co, gecoi.area ar "
    		  + "WHERE a.id_conteudo=ca.id_conteudo and a.ordem > 0 and upper(a.nome) like Upper('%.jpg') and ca.id_area=? "
    		  + "AND ca.id_conteudo = co.id_conteudo AND ca.id_area = ar.id_area "
    		  + "GROUP by a.id_conteudo, Nvl(ar.pasta_fisica, 'gecoi_arquivos/webtemp') "
    		  + "ORDER BY a.id_conteudo DESC) np, "
    		  + "(SELECT a.id_conteudo, a.id_arquivo AS id_arquivo_principal, a.nome, a.descricao "
    		  + "FROM gecoi.arquivo a, gecoi.conteudo_area ca "
    		  + "WHERE a.id_conteudo=ca.id_conteudo and a.ordem=0 and data_inicio_exib<=SYSDATE and ca.id_area=? "
    		  + "ORDER BY a.id_conteudo desc ) im, "
    		  + "(SELECT a.ordem, Nvl(a.nome_arquivo_reduzido, a.nome) AS nome_arquivo_reduzido, a.id_conteudo, "
    		  + "a.id_arquivo as imagem, Nvl(a.arquivo_reduzido, a.arquivo) AS arquivo_reduzido "
    		  + "FROM gecoi.arquivo a, gecoi.conteudo_area ca WHERE a.id_conteudo=ca.id_conteudo and ca.id_area=? AND ordem > 0) ir "
    		  + "WHERE np.id_conteudo=im.id_conteudo AND ir.ordem=np.ordem AND ir.id_conteudo=np.id_conteudo  "
    		  //+ "AND ROWNUM <= 5 "
    		  + "order by np.id_conteudo DESC"
    		  + ") where rownum <= 5";

      PreparedStatement pstm = conexao.prepareStatement(vsql);
      pstm.setInt(1, vid_area);
      pstm.setInt(2, vid_area);
      pstm.setInt(3, vid_area);*/
    	String vsql = "SELECT np.id_conteudo, ir.imagem, arquivo, descricao, im.nome, ir.nome as nome_imagem, publicado, pasta_fisica, " +
				"To_Char(data_ult_alteracao, 'yyyymmddhh24mi') AS data_ult_alteracao, np.data_inicio_exib " +
				"from (SELECT a.id_conteudo, Nvl(ar.pasta_fisica, 'gecoi_arquivos/webtemp') AS pasta_fisica, " +
				"Min(a.ordem) AS ordem, Min(co.data_ult_alteracao) AS data_ult_alteracao, Min(a.publicado) AS publicado, ca.data_inicio_exib " +
				"FROM gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co, gecoi.area ar " +
				"WHERE a.id_conteudo=ca.id_conteudo and a.ordem > 0 and upper(a.nome) like Upper('%.jpg') " +
				"and ca.id_area in (?,?) AND ca.id_conteudo = co.id_conteudo AND ca.id_area = ar.id_area " +
				"GROUP by a.id_conteudo, Nvl(ar.pasta_fisica, 'gecoi_arquivos/webtemp'), ca.data_inicio_exib ORDER BY a.id_conteudo DESC) np, " +
				"(SELECT a.id_conteudo, a.id_arquivo AS arquivo, a.nome, a.descricao FROM gecoi.arquivo a, gecoi.conteudo_area ca " +
				"WHERE a.id_conteudo=ca.id_conteudo and a.ordem=0 and data_inicio_exib<=SYSDATE and ca.id_area in (?,?) ORDER BY a.id_conteudo desc ) im, " +
				"(SELECT  a.ordem, a.nome, a.id_conteudo, a.id_arquivo as imagem FROM gecoi.arquivo a, gecoi.conteudo_area ca " +
				"WHERE a.id_conteudo=ca.id_conteudo and ca.id_area in (?,?)) ir " +
				"WHERE np.id_conteudo=im.id_conteudo AND ir.ordem=np.ordem AND ir.id_conteudo=np.id_conteudo  AND ROWNUM <= 5 order by np.data_inicio_exib DESC";
 	PreparedStatement pstm = conexao.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	pstm.setInt(2, vid_area1);
	pstm.setInt(3, vid_area);
	pstm.setInt(4, vid_area1);
	pstm.setInt(5, vid_area);
	pstm.setInt(6, vid_area1);
      ResultSet resultSet = pstm.executeQuery();
      if (resultSet.next())
      {
        escreveLinha("<div id='carousel1'>", varquivoDestino);
        escreveLinha("<ul>", varquivoDestino);
        String vpasta = "";
        String vnome = "";
        String vlink = "";
        
        File vdiretorio = null;
        File varquivo = null;
        FileOutputStream fos = null;
        InputStream is = null;
        int vtamanho_arquivo = 0;
        int vresto_arquivo = 0;
        
        String vnome_dir = "";
        
        do
        {
          vpasta = resultSet.getString("pasta_fisica");
          vnome_dir = vnomeDiretorioFisico + resultSet.getString("pasta_fisica");
          vnome = resultSet.getString("data_ult_alteracao") + "_" + resultSet.getString("nome_imagem").toLowerCase();
          vlink = "/" + vpasta + "/";
          vdiretorio = new File(vnomeDiretorioFisico + vlink);
          if (!vdiretorio.exists())
            vdiretorio.mkdirs();
          vlink = "/" + vpasta + "/" + vnome;
          varquivo = new File(vnomeDiretorioFisico + vlink);
          
          if (!varquivo.exists())
          {

            if (!vdiretorio.exists()) {
              vdiretorio.mkdirs();
            }
            

            File pasta = new File(vnome_dir);
            File[] listaArquivos = pasta.listFiles();
            for (i = 0; i < listaArquivos.length; i++)
            {
              if (listaArquivos[i].isFile())
              {
                if (listaArquivos[i].getName().indexOf(resultSet.getString("nome_imagem").toLowerCase()) > -1)
                {
                  listaArquivos[i].delete();
                }
              }
            }
            


            if (!varquivo.exists()) {
              try
              {
                fos = new FileOutputStream(varquivo);
                
                byte[] buffer = new byte[1024];
                byte[] sobra_buffer = new byte[vresto_arquivo];
                
                is = resultSet.getBinaryStream("arquivo");
                for (int ind = 0; ind < vtamanho_arquivo / 1024; ind++)
                {
                  is.read(buffer);
                  fos.write(buffer);
                }
                is.read(sobra_buffer);
                fos.write(sobra_buffer);
                
                fos.close();

              }
              catch (Exception erro)
              {
                vmsg = "Ocorreu um erro ao escrever a imagem: " + erro.getMessage();
              }
              finally
              {
                fos.close();
              }
            }
          }
          if ((resultSet.getString("nome").indexOf(".txt") > 0) || (resultSet.getString("nome").indexOf(".htm") > 0))
          {
            escreveLinha("<li><a href='/intra_nova/noticias_publicacoes/noticias/jsp/noticia.jsp?id=" + resultSet.getString("id_conteudo") + "&idimagem=" + resultSet.getString("imagem") + "' target='_top' class='noticias_txt' border='0'><img title='" + resultSet.getString("descricao") + "' src='/intra_nova/jsp/verifica_arquivo.jsp?arquivo=" + vpasta + "/" + vnome + "&id=" + resultSet.getString("imagem") + "' width='300' height='201' border='0' onerror=\"this.src='../images/erro.gif'\"/></a><p>" + resultSet.getString("descricao") + "</p></li>", varquivoDestino);
          }
          else {
            System.out.println("33");
          }
          
        }
        while (resultSet.next());
        escreveLinha("</ul>", varquivoDestino);
        escreveLinha("</div>", varquivoDestino);
      }
      resultSet.close();
      vmsg = "Arquivo gerado";
    }
    catch (Exception ex)
    {
      vmsg = "Ocorreu um erro: " + ex.getMessage();
    }
    finally
    {
      if ((conexao != null) && (!conexao.isClosed())) {
        conexao.close();
      }
    }
    varquivoDestino.close();
    return vmsg;
  }
  
  public static void escreveLinha(String linha, FileOutputStream destino)
  {
    try
    {
      byte[] buf = new byte[1024];
      buf = linha.getBytes();
      destino.write(buf, 0, linha.length());
    }
    catch (Exception localException) {}
  }
}
