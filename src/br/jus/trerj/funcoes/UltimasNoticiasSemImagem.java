package br.jus.trerj.funcoes;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UltimasNoticiasSemImagem
{
  public UltimasNoticiasSemImagem() {}
  
  public String ultimas(String vusuario, String vsenha) throws java.io.IOException, ClassNotFoundException, java.sql.SQLException
  {
    String vnomeDiretorioFisico = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\noticias_publicacoes\\noticias\\";
    




    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "ultimas_noticias_sem_imagem_pronto.htm");
    
    escreveLinha("<link rel='stylesheet' type='text/css' href='/intra_nova/noticias_publicacoes/noticias/css/noticias.css'/>", varquivoDestino);
    
    Parametros parametros = new Parametros("Produção");
    int vid_area2 = parametros.getVidAreaNoticiaIntranet();
    int vid_area3 = 2661;
    int vid_area_destaque = parametros.getVidAreaNoticiaIntranetDestaque();
    String vclasse = "";
    String vid = "";
    String vmsg = "";
    System.out.println(vid_area2);
    System.out.println(vid_area_destaque);
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    try
    {
      /*String vsql = "SELECT id_conteudo, id_arquivo, descricao, data_publicacao, nome, id_arquivo, destaque, topo, OBSERVACAO FROM (SELECT a.id_conteudo, min(id_arquivo) as id_arquivo, Min(a.descricao) AS descricao, Min(To_Char(ca.data_inicio_exib,'dd/mm/yyyy')) AS data_publicacao, Min(a.nome) AS nome, co.observacao, Min(Decode(ca.id_area,?, 'sim', ?, 'nao')) AS destaque, Min(Decode(ca.id_area,?, Decode(Upper(co.observacao),'TOPO', 0, 1),1)) AS topo from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co where a.id_conteudo=ca.id_conteudo and ca.id_area in (?,?) and ca.data_inicio_exib <= SYSDATE and a.ordem=0 AND a.id_conteudo = co.id_conteudo GROUP BY a.id_conteudo, co.observacao order BY Min(ca.data_inicio_exib) desc) WHERE ROWNUM <= 4";

      PreparedStatement pstm = conexao.prepareStatement(vsql);
      pstm.setInt(1, vid_area_destaque);
      pstm.setInt(2, vid_area2);
      pstm.setInt(3, vid_area_destaque);
      pstm.setInt(4, vid_area2);
      pstm.setInt(5, vid_area_destaque);*/
    	String vsql = "SELECT id_conteudo, id_arquivo, descricao, data_publicacao, nome, id_arquivo, destaque, topo, OBSERVACAO FROM " +
				"(SELECT a.id_conteudo, min(id_arquivo) as id_arquivo, Min(a.descricao) AS descricao, " +
				"Min(To_Char(ca.data_inicio_exib,'dd/mm/yyyy')) AS data_publicacao, Min(a.nome) AS nome, co.observacao, " +
				"Min(Decode(ca.id_area,?, 'sim', 'nao')) AS destaque, " +
				"Min(Decode(ca.id_area,?, Decode(Upper(co.observacao),'TOPO', 0, 1),1)) AS topo " +
				"from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co " +
				"where a.id_conteudo=ca.id_conteudo and ca.id_area in (?,?,?) and ca.data_inicio_exib <= SYSDATE " +
				"and a.ordem=0 AND a.id_conteudo = co.id_conteudo " +
				"GROUP BY a.id_conteudo, co.observacao order BY Min(ca.data_inicio_exib) desc) " +
				"WHERE ROWNUM <= 4";

 	PreparedStatement pstm = conexao.prepareStatement(vsql);
	pstm.setInt(1, vid_area_destaque);
	pstm.setInt(2, vid_area_destaque);
	pstm.setInt(3, vid_area_destaque);
	pstm.setInt(4, vid_area2);
	pstm.setInt(5, vid_area3);
	
      ResultSet resultSet = pstm.executeQuery();
      if (resultSet.next())
      {
        escreveLinha("<table width='100%' border='0' cellpadding='0' cellspacing='0'>", varquivoDestino);
        do
        {
          if (resultSet.getString("destaque").toUpperCase() == "SIM")
          {
            vid = "destaque";
            vclasse = "hora_data_destaque";
          }
          else
          {
            vid = "sem_destaque";
            vclasse = "hora_data";
          }
          if ((resultSet.getString("nome").indexOf(".txt") > 0) || (resultSet.getString("nome").indexOf(".htm") > 0))
          {
            escreveLinha("<tr><td valign='top'>", varquivoDestino);
            escreveLinha("<span class='" + vclasse + "'>" + resultSet.getString("data_publicacao") + "</span>", varquivoDestino);
            escreveLinha("<span id='" + vid + "'><a href='/intra_nova/noticias_publicacoes/noticias/jsp/noticia.jsp?id=" + resultSet.getString("id_conteudo") + "' target='_top'>" + resultSet.getString("descricao") + "</a></span>", varquivoDestino);
            escreveLinha("</td></tr>", varquivoDestino);
          }
          else
          {
            escreveLinha("<tr><td valign='top'>", varquivoDestino);
            escreveLinha("<span class='" + vclasse + "'>" + resultSet.getString("data_publicacao") + "</span>", varquivoDestino);
            escreveLinha("<span id='" + vid + "'><a href='/intra_nova/jsp/download_arquivo.jsp?id=" + resultSet.getString("id_arquivo") + "' target='_blank'>" + resultSet.getString("descricao") + "</a></span>", varquivoDestino);
            escreveLinha("</td></tr>", varquivoDestino);
          }
        } while (resultSet.next());
        


        escreveLinha("</table>", varquivoDestino);
      }
      resultSet.close();

    }
    catch (Exception ex)
    {

      escreveLinha("<script language='javascript'>", varquivoDestino);
      escreveLinha("parent.erroConexao();", varquivoDestino);
      escreveLinha("</script>", varquivoDestino);
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
