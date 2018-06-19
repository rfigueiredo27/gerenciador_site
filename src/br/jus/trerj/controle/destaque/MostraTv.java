package br.jus.trerj.controle.destaque;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class MostraTv
{
  public MostraTv() {}
  
  public String mostra(int videntificador, String vpagina, String vip) throws ClassNotFoundException, FileNotFoundException, java.io.IOException
  {
    Parametros parametros = new Parametros("Produção");
    int vid_area = parametros.getVidAreaDestaque();
    ConnectionFactory connectionFactory = new ConnectionFactory();
    Connection conexao = connectionFactory.getConnection(videntificador, vpagina, vip);
    
    return geraTv(conexao, vid_area);
  }
  
  public String mostra(String vusuario, String vsenha) throws SQLException, FileNotFoundException, ClassNotFoundException
  {
    Parametros parametros = new Parametros("Produção");
    int vid_area = parametros.getVidAreaDestaque();
    String vmsg = "";
    Connection conexao = null;
    try
    {
      conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
      vmsg = geraTv(conexao, vid_area);


    }
    catch (Exception localException) {}finally
    {

      if ((conexao != null) && (!conexao.isClosed())) {
        conexao.close();
      }
    }
    
    return vmsg;
  }
  
  public String geraTv(Connection conexao, int vid_area) throws FileNotFoundException
  {
    String vnomeDiretorioFisico = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\tv_banner\\tv\\";
    String vdiretorioImagem = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\tv_banner\\tv\\img\\";
    


    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "mostra_tv_pronto.htm");
    
    escreveLinha("<link rel='stylesheet' type='text/css' href='/intra_nova/tv_banner/tv/css2/blueprint.css' media='screen'/>", varquivoDestino);
    escreveLinha("<link rel='stylesheet' type='text/css' href='/intra_nova/tv_banner/tv/css2/portal.css'/>", varquivoDestino);
    escreveLinha("<link rel='stylesheet' type='text/css' href='/intra_nova/tv_banner/tv/css2/textoRotativo.css'/>", varquivoDestino);
    
    escreveLinha("<script src='/intra_nova/tv_banner/tv/script/alterna_destaques.js' type='text/javascript'></script>", varquivoDestino);
    escreveLinha("<script src='/intra_nova/scripts/global.js' type='text/javascript'></script>", varquivoDestino);
    
    escreveLinha("<script>", varquivoDestino);
    escreveLinha("function OnTecla(e)", varquivoDestino);
    escreveLinha("{", varquivoDestino);
    escreveLinha("if (e.keyCode == '9' || e.which == '9')", varquivoDestino);
    escreveLinha("botao_troca();", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    
    escreveLinha("function chamaBox(lnk,tit)", varquivoDestino);
    escreveLinha("{", varquivoDestino);
    escreveLinha("parent.document.getElementById('acesso').href = lnk;", varquivoDestino);
    escreveLinha("parent.document.getElementById('acesso').title = tit;", varquivoDestino);
    escreveLinha("parent.clica_link('acesso');", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    escreveLinha("$(document).ready(function(){", varquivoDestino);
    escreveLinha("$.post('/intra_nova/pesquisas/aniversariantes/ultimos_aniversariantes.jsp', {}, function(resposta){$('#divultimosaniversariantes').html(resposta);});", varquivoDestino);
    escreveLinha("});", varquivoDestino);
    escreveLinha("</script>", varquivoDestino);
    

    escreveLinha("<div id='destaques'>", varquivoDestino);
    escreveLinha("<div id='contdestaques'>\n", varquivoDestino);
    
    int conta = 0;
    String vlink = "";
    String vnome_arquivo = "";
    String vnome_original = "";
    String vnome_dir = "";
    int vtamanho_arquivo = 0;
    int vresto_arquivo = 0;
    File varquivo = null;
    File vdiretorio = null;
    FileOutputStream fos = null;
    InputStream is = null;
    String vcaminho = "";
    String vmsg = "";
    String vtarget = "";
    
    try
    {
      String vsql = "SELECT a.id_Conteudo, a.id_arquivo, a.descricao, Nvl(c.observacao, '-') AS observacao, " +
    		  		"to_char(ca.data_inicio_exib,'dd/mm/yyyy') as data_inicio_exib, to_char(ca.data_fim_exib,'yyyymmdd') as data_fim_exib, " +
    		  		"a.nome, a.ordem, a.publicado, Nvl((SELECT Nvl(id_arquivo,0) " +
    		  		"FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ordem = 1),0) AS anexo, " +
    		  		"Nvl((SELECT Nvl(descricao,'') FROM gecoi.arquivo WHERE id_conteudo = a.id_conteudo AND ordem = 1),'-') AS descricaoAnexo, " +
    		  		"dbms_lob.getlength(a.arquivo) AS tamanho, a.arquivo, ar.pasta_fisica, " +
    		  		"To_Char(data_ult_alteracao, 'yyyymmddhh24mi') AS data_ult_alteracao " +
    		  		"FROM gecoi.arquivo a, gecoi.conteudo_Area ca, gecoi.conteudo c, gecoi.area ar " +
    		  		"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = c.id_Conteudo AND ca.id_area = ? " +
    		  		"AND a.ordem = 0 AND ca.id_area = ar.id_area AND a.publicado > 0 " +
    		  		"AND To_Date(SYSDATE, 'dd/mm/yyyy') BETWEEN To_Date(data_inicio_exib, 'dd/mm/yyyy') AND To_Date(data_fim_exib, 'dd/mm/yyyy') " +
    		  		"ORDER BY a.publicado, a.ordem, a.id_arquivo ";

      PreparedStatement pstm = conexao.prepareStatement(vsql);
      pstm.setInt(1, vid_area);
      ResultSet resultSet = pstm.executeQuery();
      if (resultSet.next())
      {
        do
        {
          vnome_original = resultSet.getString("nome").toLowerCase();
          vnome_arquivo = resultSet.getString("data_ult_alteracao") + "_" + resultSet.getString("nome").toLowerCase();
          vcaminho = resultSet.getString("pasta_fisica") + "/" + vnome_arquivo;
          vtamanho_arquivo = resultSet.getInt("tamanho");
          

          vdiretorio = new File(vnomeDiretorioFisico + resultSet.getString("pasta_fisica"));
          vnome_dir = vnomeDiretorioFisico + resultSet.getString("pasta_fisica");
          vresto_arquivo = vtamanho_arquivo % 1024;
          
          varquivo = new File(vdiretorioImagem + vnome_arquivo);
          
          if (!varquivo.exists())
          {
            try
            {

              if (!vdiretorio.exists()) {
                vdiretorio.mkdirs();
              }
              

              File pasta = new File(vnome_dir);
              File[] listaArquivos = pasta.listFiles();
              for (int i = 0; i < listaArquivos.length; i++)
              {
                if (listaArquivos[i].isFile())
                {
                  if (listaArquivos[i].getName().indexOf(vnome_original) > -1)
                  {
                    listaArquivos[i].delete();
                  }
                }
              }
              
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
              

              fos.flush();
              fos.close();

            }
            catch (Exception erro)
            {

              vmsg = "Ocorreu um erro ao escrever a imagem: " + erro.getMessage();
            }
            finally
            {
              if (fos != null) {
                fos.close();
              }
            }
          }
          if (resultSet.getInt("anexo") > 0)
          {
            vlink = "/intra_nova/jsp/grava_arquivo.jsp?id=" + resultSet.getString("anexo");
          }
          else
          {
            String[] vobservacao = resultSet.getString("observacao").split("@@"); 
            vlink = vobservacao[0];
            if (vobservacao.length > 1)
            	vtarget = vobservacao[1];
            else
            	vtarget = "_blank";
          }
          

          escreveLinha("<div id='evidenciaVar" + ++conta + "' style='z-index:" + conta + ";' dataFim='" + resultSet.getString("data_fim_exib") + "'>", varquivoDestino);
          
          if (resultSet.getString("descricao").equals("Aniversariantes do mês"))
          {
            escreveLinha("<div id='imagem' class='aniversario'>", varquivoDestino);
            
            escreveLinha("<a href='" + vlink + "' target='" + vtarget + "'><div id='divultimosaniversariantes'></div></a>", varquivoDestino);
          }
          else
          {
            escreveLinha("<div id='imagem'>", varquivoDestino);
            
            escreveLinha("<a href='" + vlink + "' target='" + vtarget + "'><img src='/intra_nova/tv_banner/tv/img/" + vnome_arquivo + "' alt='" + resultSet.getString("descricao") + "' title='" + resultSet.getString("descricao") + "' border='0' class='sizecorrection' /></a>", varquivoDestino);
          }
          escreveLinha("</div>", varquivoDestino);
          escreveLinha("</div dataFim='" + resultSet.getString("data_fim_exib") + "'>\n", varquivoDestino);
        } while (resultSet.next());
      }
      else
      {
        vmsg = "N&atilde;o foi encontrada nenhuma not&iacute;cia!";
      }
      resultSet.close();
    }
    catch (Exception localException1) {}
    



    escreveLinha("</div>", varquivoDestino);
    escreveLinha("</div>", varquivoDestino);
    escreveLinha("<div id='botao' class='span-3' >\n", varquivoDestino);
    
    for (int ativa = 1; ativa <= conta; ativa++)
    {
      if (ativa == 1) {
        escreveLinha("<div class='contdestaques'  id='chamaEvidencia" + ativa + "' onclick=\"changeContainer($('#chamaEvidencia'+proximo).get(0));\"><a class='contdestaques'> </a> </div>\n", varquivoDestino);
      } else {
        escreveLinha("<div class='contdestaques'  id='chamaEvidencia" + ativa + "' onclick=\"changeContainer(this)\"><a class='contdestaques'> </a> </div>\n", varquivoDestino);
      }
    }
    
    escreveLinha("</div>", varquivoDestino);
    
    escreveLinha("<script language='javascript' type='text/javascript'>", varquivoDestino);
    escreveLinha("changeContainer($('#chamaEvidencia1').get(0));", varquivoDestino);
    
    escreveLinha("function botao_troca(){", varquivoDestino);
    escreveLinha("changeContainer($('#chamaEvidencia'+proximo).get(0));", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    
    escreveLinha("</script>", varquivoDestino);
    
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
