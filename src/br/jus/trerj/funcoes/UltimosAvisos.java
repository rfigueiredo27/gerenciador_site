package br.jus.trerj.funcoes;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UltimosAvisos
{
  public UltimosAvisos() {}
  
  public String ultimos(String vusuario, String vsenha) throws java.io.IOException, ClassNotFoundException, SQLException
  {
    String vnomeDiretorioFisico = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\noticias_publicacoes\\avisos\\";
    
    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "ultimos_avisos_gecoi_pronto.htm");
    String vmsg = "";
    
    escreveLinha("<script type='text/javascript'>", varquivoDestino);
    escreveLinha("function abreArquivo(id,caminho,ct)", varquivoDestino);
    escreveLinha("{", varquivoDestino);
    escreveLinha("url = window.location.href;", varquivoDestino);
    escreveLinha("if (url.indexOf('_offline')>0)", varquivoDestino);
    escreveLinha("{", varquivoDestino);
    escreveLinha("pagina = caminho;", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    escreveLinha("else{", varquivoDestino);
    escreveLinha("pagina = '/intra_nova/jsp/visualizar_arquivo.jsp?idarquivo=' + id +'&idconteudo= '+ ct;", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    escreveLinha("window.open(pagina,'download','resizable=yes,toolbar=yes,menubar=yes,scrollbars=yes,width=800,height=580');", varquivoDestino);
    escreveLinha("}", varquivoDestino);
    
    escreveLinha("</script>", varquivoDestino);
    


    String vurl = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\";
    String[] ArrayUrl = vurl.split("/");
    String vnomearquivooff = ArrayUrl[(ArrayUrl.length - 1)];
    vnomearquivooff = vnomearquivooff.replace(".jsp", "_offline.htm");
    
    String vcaminho = "/informacoes/avisos";
    
    String vurloff = vcaminho + "/" + vnomearquivooff;
    
    Parametros parametros = new Parametros("Produção");
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    try
    {
      String vsql = "SELECT id_arquivo, descricao, to_char(data_inclusao, 'dd/mm/yy - HH24:mi') as inclusao, pasta_fisica,id_conteudo, nome FROM (SELECT aq.data_inclusao, aq.descricao, aq.id_arquivo, ar.pasta_fisica, aq.nome,aq.id_conteudo FROM gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.area ar WHERE aq.id_conteudo=ca.id_conteudo AND ca.id_area=ar.id_area AND ar.tipo_area=2 AND aq.ordem=0 AND ca.id_area NOT IN (1521,1522,1523) ORDER BY aq.data_inclusao desc) where ROWNUM <= 4";
      




      PreparedStatement pstm = conexao.prepareStatement(vsql);
      ResultSet resultSet = pstm.executeQuery();
      if (resultSet.next())
      {
        escreveLinha("<table width='100%' border='0' cellpadding='0' cellspacing='0'>", varquivoDestino);
        String vdescricao = "";
        do
        {
          if (resultSet.getString("descricao").length() > 80) {
            vdescricao = resultSet.getString("descricao").substring(0, 75) + "...";
          } else {
            vdescricao = resultSet.getString("descricao");
          }
          escreveLinha("<tr><td valign='top'>", varquivoDestino);
          escreveLinha("<span class='hora_data'>" + resultSet.getString("inclusao") + "</span>", varquivoDestino);
          escreveLinha("<span id='sem_destaque'><a href='#' onclick=\"abreArquivo(" + resultSet.getString("id_arquivo") + ",'/" + resultSet.getString("pasta_fisica") + "/" + resultSet.getString("nome") + "'," + resultSet.getString("id_conteudo") + ");\">" + vdescricao + "</a></span>", varquivoDestino);
          escreveLinha("</td></tr>", varquivoDestino);
        } while (resultSet.next());
        
        escreveLinha("</table>", varquivoDestino);
      }
      resultSet.close();

    }
    catch (Exception ex)
    {
      escreveLinha("response.sendRedirect('" + vurloff + "');", varquivoDestino);
      
      if ((conexao != null) && (!conexao.isClosed()))
      {
        conexao.close();
      }
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
