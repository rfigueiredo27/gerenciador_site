package br.jus.trerj.funcoes;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.security.PublicKey;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.io.FileUtils;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

public class UltimasNoticiasInternet
{
  public UltimasNoticiasInternet() {}
  
  public String ultimasTV(String vusuario, String vsenha) throws java.io.IOException, ClassNotFoundException, SQLException
  {
    String vnomeDiretorioFisico = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\noticias_publicacoes\\noticias\\";
    //vnomeDiretorioFisico = "O:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\gecoi.3.0\\";

    // gerando o ultima_noticia_imagem.htm
    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "ultima_noticia_imagem.htm");
    
    Parametros parametros = new Parametros("Produção");
    
    int vid_area = parametros.getVidAreaNoticiaInternet();
    int vid_area2 = 2661; 
    int vid_area3 = 2662; 
    
    String vmsg = "";
    String vid_arquivo = "0";   //id do arquivo
    String vdescricao  = "";  //descrição do arquivo
    String vpublicacao = "";  //
    String vgerados = ""; // guarda todos os arquivos gerados
    String vnomeDiretorioGecoi = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\gecoi_arquivos\\noticias\\";
    //vnomeDiretorioGecoi = "O:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\gecoi.3.0\\intra_nova\\gecoi_arquivos\\noticias\\";
    
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    String vid_conteudo = "";
    try
    {

       String vsql = "select * from (SELECT id_arquivo, imagem.id_conteudo, descricao, data_inicio_exib as data, " +
       				 "to_char(data_inicio_exib, 'dd_mm_yyyy - HH24:mi') as data_inicio_exib, nome from " +
                     "(SELECT aq.id_arquivo, aq.id_conteudo, co.descricao, ca.data_inicio_exib " +
                     "FROM gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.conteudo co " +
                     "WHERE ca.id_area in (?,?,?) AND aq.ordem>0 AND ((nome_arquivo_reduzido IS NOT NULL) OR (Upper(SubStr(nome, Length(nome)-3)) = '.JPG')) " +
                     "AND aq.id_conteudo=co.id_conteudo  AND ca.data_inicio_exib<=sysdate AND co.id_conteudo=ca.id_conteudo " +
                     "ORDER BY ca.data_inicio_exib desc) imagem, " +
                     "(SELECT aq.id_conteudo, aq.nome FROM " +
                     "gecoi.arquivo aq WHERE aq.ordem=0) tipo " +
                     "WHERE imagem.id_conteudo=tipo.id_conteudo ORDER BY data desc) Where rownum = 1";
    				 
       PreparedStatement pstm = conexao.prepareStatement(vsql);
       pstm.setInt(1,vid_area);
       pstm.setInt(2,vid_area2);
       pstm.setInt(3,vid_area3);
    							  	
       ResultSet resultSet = pstm.executeQuery();   

       if (resultSet.next())
       {
         vid_conteudo = resultSet.getString("id_conteudo");
    	 vid_arquivo  = resultSet.getString("id_arquivo");
    	 vdescricao   = resultSet.getString("descricao");
    	 vpublicacao  = resultSet.getString("data_inicio_exib");
       }

       //se o arquivo for to tipo texto ou html, abre a página de notícias
       //se for diferente tipo PDF, DOC, RTF abre o arquivo diretamente
       double vsessao = Math.random();
       if (resultSet.getString("nome").indexOf(".txt")>0 || resultSet.getString("nome").indexOf(".htm")>0)
       {
    	   escreveLinha("<div id='img_tv'><a href='#' onclick=\"document.location.href = '/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + vid_conteudo + "&amp;sessao=" + vsessao + "'\" target='_top' ><img alt='" + vdescricao + "' title='" + vdescricao + "' src='/site/jsp/grava_imagem_reduzida.jsp?id=" + vid_arquivo + "' width='225' height='150' border='0'/></a></div>", varquivoDestino);
    	   escreveLinha("<div id='txt_tv'><a href='#' onclick=\"document.location.href = '/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + vid_conteudo + "&amp;sessao=" + vsessao + "'\" target='_top' >" + vdescricao + "</a></div>", varquivoDestino);			   
       }
       else		  
       {
    	   escreveLinha("<div id='img_tv'><a href='/site/jsp/grava_arquivo.jsp?id=" + vid_arquivo  + "&sessao=" + vsessao + "' target='_blank' class='noticias_txt' border='0'><img alt='" + vdescricao + "' title='" + vdescricao + "' src='/site/jsp/grava_imagem_reduzida.jsp?id=" + vid_arquivo + "' width='225' height='150' border='0'/></a></div>", varquivoDestino);
    	   escreveLinha("<div id='txt_tv'><a href='/site/jsp/grava_arquivo.jsp?id=" + vid_arquivo  + "&sessao=" + vsessao + "' target='_blank'>" + vdescricao + "</p></a></div>", varquivoDestino);
       }
    	 
       resultSet.close();
       
       // gerando o arq_id_conteudo.jsp
       FileUtils.copyFile(new File(vnomeDiretorioFisico + "jsp\\visualiza_noticia.jsp"), new File(vnomeDiretorioGecoi + "arq_" + vid_conteudo + ".jsp"));
       vgerados = "arq_" + vid_conteudo + ".jsp"; 
    }
    catch (Exception ex)
    {
        if(ex.getMessage().indexOf("12505")==0)
            vmsg = "Não foi possível conectar ao banco. Por favor tente mais tarde.";
    	else
            vmsg = "Não foi possível conectar ao banco. Ocorreu o seguinte erro: " + ex.getMessage();
    }
    /*finally
    {
        if(conexao!=null && !conexao.isClosed())
           conexao.close();
    } */
    varquivoDestino.close();
    
    // gerando o ultimas_noticias_index.htm
    varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "ultimas_noticias_index.htm");
    try
    {

       //------------------------------------------------------------------------------------------------------------------------
       //Seleciona os registros referentes as notícias destaques
       //------------------------------------------------------------------------------------------------------------------------   
       
       String vsql = "SELECT id_conteudo, id_arquivo, descricao, data_publicacao, nome, id_arquivo, publicacao FROM " +
              "(SELECT a.id_conteudo, min(id_arquivo) as id_arquivo, Min(a.descricao) AS descricao, " +
    		  "Min(To_Char(ca.data_inicio_exib,'dd/mm/yyyy')) AS data_publicacao, min(to_char(ca.data_inicio_exib, 'dd_mm_yyyy - HH24:mi')) as publicacao, Min(a.nome) AS nome " + 
              "from gecoi.arquivo a, gecoi.conteudo_area ca " +
              "where a.id_conteudo=ca.id_conteudo and ca.id_area in (?,?,?) and ca.data_inicio_exib <= SYSDATE " +
    		  "and a.ordem=0 and a.id_conteudo <> ? GROUP BY a.id_conteudo order BY Min(ca.data_inicio_exib) desc) " +
              "WHERE ROWNUM <= 3";

       
       PreparedStatement pstm = conexao.prepareStatement(vsql);
       pstm.setInt(1,vid_area);
       pstm.setInt(2,vid_area2);
       pstm.setInt(3,vid_area3);
       pstm.setInt(4, Integer.parseInt(vid_conteudo));
       
       ResultSet resultSet = pstm.executeQuery();
    	 
      if ( resultSet.next() )
      {
    	
          do 
    	  {
     	     if (resultSet.getString("nome").indexOf(".txt")>0 || resultSet.getString("nome").indexOf(".htm")>0)
    		 {
    			escreveLinha("<div class='ultimas_noticias'><span class='hora_data1'>"+ resultSet.getString("data_publicacao") +"</span> - <a href='/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + resultSet.getString("id_conteudo")+ "&amp;sessao=" + Math.random() + "&amp;data=" + resultSet.getString("publicacao") + "' target='_top'>" + resultSet.getString("descricao") + "</a></div>", varquivoDestino); 
    		 }else		
               escreveLinha("<div class='ultimas_noticias'><span class='hora_data1'>"+ resultSet.getString("data_publicacao") +"</span> - <a href='../../jsp/grava_arquivo.jsp?id=" + resultSet.getString("id_arquivo")+ "&amp;sessao=" + Math.random() + "' target='_blank'>" + resultSet.getString("descricao") + "</a></div>", varquivoDestino);

     	     // gerando o arq_id_conteudo.jsp
     	     FileUtils.copyFile(new File(vnomeDiretorioFisico + "jsp\\visualiza_noticia.jsp"), new File(vnomeDiretorioGecoi + "arq_" + resultSet.getString("id_conteudo") + ".jsp"));
     	     vgerados = vgerados + "-" + "arq_" + resultSet.getString("id_conteudo") + ".jsp"; 

    	  }
    	  while( resultSet.next());

      	  resultSet.close(); 	  

       }

    }//
    catch( SQLException sqlex){
        vmsg = "Não foi possível conectar ao banco. Por favor tente mais tarde.";  
    }
    catch (Exception ex)
    {
    	//se der erro mostra uma outra página no lugar de notícias
        escreveLinha("<script language='javascript'>", varquivoDestino);
        escreveLinha("parent.erroConexao();", varquivoDestino);
        escreveLinha("</script>", varquivoDestino);	
    }
    finally
    {
        if(conexao!=null && !conexao.isClosed())
           conexao.close();
    }
    
    
	Criptografia criptografia = new Criptografia();
	ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
	final PublicKey chavePublica = (PublicKey) inputStream.readObject();
	inputStream.close();
	
    String caminho = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\intra_nova\\WEB-INF\\";
    //caminho = "O:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\gecoi.3.0\\WEB-INF\\";
	
	inputStream = new ObjectInputStream(new FileInputStream(caminho + "n1.key"));
	byte[] secret = (byte[]) inputStream.readObject();
	inputStream.close();
	String SFTPUSER = criptografia.decriptografa(secret, chavePublica);
	inputStream.close();

	inputStream = new ObjectInputStream(new FileInputStream(caminho + "n2.key"));
	secret = (byte[]) inputStream.readObject();
	inputStream.close();
	String SFTPPASS = criptografia.decriptografa(secret, chavePublica);
	inputStream.close();

	inputStream = new ObjectInputStream(new FileInputStream(caminho + "n3.key"));
	secret = (byte[]) inputStream.readObject();
	inputStream.close();
	String SFTPHOST = criptografia.decriptografa(secret, chavePublica);
	inputStream.close();

	/*inputStream = new ObjectInputStream(new FileInputStream(caminho + "n4.key"));
	secret = (byte[]) inputStream.readObject();
	inputStream.close();
	String SFTPWORKINGDIR = criptografia.decriptografa(secret, chavePublica);
	inputStream.close();*/

	inputStream = new ObjectInputStream(new FileInputStream(caminho + "n5.key"));
	secret = (byte[]) inputStream.readObject();
	inputStream.close();
	String raiz = criptografia.decriptografa(secret, chavePublica);
	String SFTPGECOIDIR = raiz + "gecoi_arquivos/noticias/";
	String SFTPWORKINGDIR = raiz + "noticias/";
	inputStream.close();

    int SFTPPORT = 22;
    Session session = null;
    Channel channel = null;
    ChannelSftp channelSftp = null;

    try {
        JSch jsch = new JSch();
        session = jsch.getSession(SFTPUSER, SFTPHOST, SFTPPORT);
        session.setPassword(SFTPPASS);
        java.util.Properties config = new java.util.Properties();
        config.put("StrictHostKeyChecking", "no");
        session.setConfig(config);
        session.connect();
        channel = session.openChannel("sftp");
        channel.connect();
        channelSftp = (ChannelSftp) channel;
        channelSftp.cd(SFTPWORKINGDIR);
        File f = new File(vnomeDiretorioFisico + "ultima_noticia_imagem.htm");
        channelSftp.put(new FileInputStream(f), f.getName());
        f = new File(vnomeDiretorioFisico + "ultimas_noticias_index.htm"); 
        // copia todos os arquivos gerados
        channelSftp.cd(SFTPGECOIDIR);
        String[] agerados = vgerados.split("-");
        for (String gerado : agerados)
        {
            f = new File(vnomeDiretorioGecoi + gerado);
            channelSftp.put(new FileInputStream(f), f.getName());        	
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    
    return vmsg;
  }
  
  
  public String ultimasTVExterno(String vusuario, String vsenha, String vpagina, String vcliente) throws java.io.IOException, ClassNotFoundException, SQLException
  {
	  /*
		Criptografia criptografia = new Criptografia();
		ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
		final PublicKey chavePublica = (PublicKey) inputStream.readObject();
		inputStream.close();

		inputStream = new ObjectInputStream(new FileInputStream("n5.key"));
		byte[] secret = (byte[]) inputStream.readObject();
		inputStream.close();
		String vnomeDiretorioFisico = criptografia.decriptografa(secret, chavePublica);
		inputStream.close();
		*/
		String vnomeDiretorioFisico = "opt/tomcat/webapps/site/";

    // gerando o ultima_noticia_imagem.htm
    FileOutputStream varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "noticias/ultima_noticia_imagem.htm");
    
    Parametros parametros = new Parametros("Produção");
    
    int vid_area = parametros.getVidAreaNoticiaInternet();
    int vid_area2 = 2661;
    int vid_area3 = 2662;
    
    String vmsg = "";
    String vid_arquivo = "0";   //id do arquivo
    String vdescricao  = "";  //descrição do arquivo
    String vpublicacao = "";  //
    String vnomeDiretorioGecoi = vnomeDiretorioFisico + "gecoi_arquivos/noticias/";
    
    //Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    Connection conexao = new ConnectionFactory().getConnection(5, vpagina, vcliente);
    String vid_conteudo = "";
    try
    {

		String vsql = "select (guardiao.pkg_validar_usuario.autenticar_usuario(?,?,?)) as retorno from dual";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setString(1,vusuario);
		pstm.setString(2,vsenha);
		pstm.setInt(3,74);
		ResultSet resultSet = pstm.executeQuery();
		if (resultSet.next())
		{
		       vsql = "select * from (SELECT id_arquivo, imagem.id_conteudo, descricao, data_inicio_exib as data, " +
		       				 "to_char(data_inicio_exib, 'dd_mm_yyyy - HH24:mi') as data_inicio_exib, nome from " +
		                     "(SELECT aq.id_arquivo, aq.id_conteudo, co.descricao, ca.data_inicio_exib " +
		                     "FROM gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.conteudo co " +
		                     "WHERE ca.id_area in (?,?,?) AND aq.ordem>0 AND ((nome_arquivo_reduzido IS NOT NULL) OR (Upper(SubStr(nome, Length(nome)-3)) = '.JPG')) " +
		                     "AND aq.id_conteudo=co.id_conteudo  AND ca.data_inicio_exib<=sysdate AND co.id_conteudo=ca.id_conteudo " +
		                     "ORDER BY ca.data_inicio_exib desc) imagem, " +
		                     "(SELECT aq.id_conteudo, aq.nome FROM " +
		                     "gecoi.arquivo aq WHERE aq.ordem=0) tipo " +
		                     "WHERE imagem.id_conteudo=tipo.id_conteudo ORDER BY data desc) Where rownum = 1";
		    				 
		       pstm = conexao.prepareStatement(vsql);
		       pstm.setInt(1,vid_area);
		       pstm.setInt(2,vid_area2);
		       pstm.setInt(3,vid_area3);
		    							  	
		       resultSet = pstm.executeQuery();   
		
		       if (resultSet.next())
		       {
		         vid_conteudo = resultSet.getString("id_conteudo");
		    	 vid_arquivo  = resultSet.getString("id_arquivo");
		    	 vdescricao   = resultSet.getString("descricao");
		    	 vpublicacao  = resultSet.getString("data_inicio_exib");
		       }
		
		       //se o arquivo for to tipo texto ou html, abre a página de notícias
		       //se for diferente tipo PDF, DOC, RTF abre o arquivo diretamente
		       double vsessao = Math.random();
		       if (resultSet.getString("nome").indexOf(".txt")>0 || resultSet.getString("nome").indexOf(".htm")>0)
		       {
		    	   escreveLinha("<div id='img_tv'><a href='#' onclick=\"document.location.href = '/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + vid_conteudo + "&amp;sessao=" + vsessao + "'\" target='_top' ><img alt='" + vdescricao + "' title='" + vdescricao + "' src='/site/jsp/grava_imagem_reduzida.jsp?id=" + vid_arquivo + "' width='225' height='150' border='0'/></a></div>", varquivoDestino);
		    	   escreveLinha("<div id='txt_tv'><a href='#' onclick=\"document.location.href = '/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + vid_conteudo + "&amp;sessao=" + vsessao + "'\" target='_top' >" + vdescricao + "</a></div>", varquivoDestino);			   
		       }
		       else		  
		       {
		    	   escreveLinha("<div id='img_tv'><a href='/site/jsp/grava_arquivo.jsp?id=" + vid_arquivo  + "&sessao=" + vsessao + "' target='_blank' class='noticias_txt' border='0'><img alt='" + vdescricao + "' title='" + vdescricao + "' src='/site/jsp/grava_imagem_reduzida.jsp?id=" + vid_arquivo + "' width='225' height='150' border='0'/></a></div>", varquivoDestino);
		    	   escreveLinha("<div id='txt_tv'><a href='/site/jsp/grava_arquivo.jsp?id=" + vid_arquivo  + "&sessao=" + vsessao + "' target='_blank'>" + vdescricao + "</p></a></div>", varquivoDestino);
		       }
		}
       resultSet.close(); 	
       
       // gerando o arq_id_conteudo.jsp
       FileUtils.copyFile(new File(vnomeDiretorioFisico + "noticias/jsp/visualiza_noticia.jsp"), new File(vnomeDiretorioGecoi + "arq_" + vid_conteudo + ".jsp"));
    }
    catch (Exception ex)
    {
        if(ex.getMessage().indexOf("12505")==0)
            vmsg = "Não foi possível conectar ao banco. Por favor tente mais tarde."+ex.getMessage();
    	else
            vmsg = "Não foi possível conectar ao banco. Ocorreu o seguinte erro: " + ex.getMessage();
    }
    /*finally
    {
        if(conexao!=null && !conexao.isClosed())
           conexao.close();
    } */
    varquivoDestino.close();
    
    // gerando o ultimas_noticias_index.htm
    varquivoDestino = new FileOutputStream(vnomeDiretorioFisico + "noticias/ultimas_noticias_index.htm");
    try
    {

       //------------------------------------------------------------------------------------------------------------------------
       //Seleciona os registros referentes as notícias destaques
       //------------------------------------------------------------------------------------------------------------------------   
       
		String vsql = "select (guardiao.pkg_validar_usuario.autenticar_usuario(?,?,?)) as retorno from dual";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setString(1,vusuario);
		pstm.setString(2,vsenha);
		pstm.setInt(3,74);
		ResultSet resultSet = pstm.executeQuery();
		if (resultSet.next())
		{
			vsql = "SELECT id_conteudo, id_arquivo, descricao, data_publicacao, nome, id_arquivo, publicacao FROM " +
              "(SELECT a.id_conteudo, min(id_arquivo) as id_arquivo, Min(a.descricao) AS descricao, " +
    		  "Min(To_Char(ca.data_inicio_exib,'dd/mm/yyyy')) AS data_publicacao, min(to_char(ca.data_inicio_exib, 'dd_mm_yyyy - HH24:mi')) as publicacao, Min(a.nome) AS nome " + 
              "from gecoi.arquivo a, gecoi.conteudo_area ca " +
              "where a.id_conteudo=ca.id_conteudo and ca.id_area in (?,?,?) and ca.data_inicio_exib <= SYSDATE " +
    		  "and a.ordem=0 and a.id_conteudo <> ? GROUP BY a.id_conteudo order BY Min(ca.data_inicio_exib) desc) " +
              "WHERE ROWNUM <= 3";

       
	       pstm = conexao.prepareStatement(vsql);
	       pstm.setInt(1,vid_area);
	       pstm.setInt(2,vid_area2);
	       pstm.setInt(3,vid_area3);
	       pstm.setInt(4, Integer.parseInt(vid_conteudo));
	       resultSet = pstm.executeQuery();
	      if ( resultSet.next() )
	      {
	          do 
	    	  {
	     	     if (resultSet.getString("nome").indexOf(".txt")>0 || resultSet.getString("nome").indexOf(".htm")>0)
	    		 {
	    			escreveLinha("<div class='ultimas_noticias'><span class='hora_data1'>"+ resultSet.getString("data_publicacao") +"</span> - <a href='/site/noticias/jsp/copia_visualiza_noticia.jsp?id=" + resultSet.getString("id_conteudo")+ "&amp;sessao=" + Math.random() + "&amp;data=" + resultSet.getString("publicacao") + "' target='_top'>" + resultSet.getString("descricao") + "</a></div>", varquivoDestino); 
	    		 }else		
	               escreveLinha("<div class='ultimas_noticias'><span class='hora_data1'>"+ resultSet.getString("data_publicacao") +"</span> - <a href='../../jsp/grava_arquivo.jsp?id=" + resultSet.getString("id_arquivo")+ "&amp;sessao=" + Math.random() + "' target='_blank'>" + resultSet.getString("descricao") + "</a></div>", varquivoDestino); 

	     	     // gerando o arq_id_conteudo.jsp
	     	     FileUtils.copyFile(new File(vnomeDiretorioFisico + "noticias/jsp/visualiza_noticia.jsp"), new File(vnomeDiretorioGecoi + "arq_" + resultSet.getString("id_conteudo")  + ".jsp"));
	    	  }
	    	  while( resultSet.next());
	      }
      	  resultSet.close(); 	  
       }

    }
    catch( SQLException sqlex){
    	vmsg = vmsg+"Não foi possível conectar ao banco. Por favor tente mais tarde."+sqlex.getMessage();  
    }
    catch (Exception ex)
    {
    	vmsg = vmsg+"Não foi possível conectar ao banco. Por favor tente mais tarde."+ex.getMessage();
    	//se der erro mostra uma outra página no lugar de notícias
        escreveLinha("<script language='javascript'>", varquivoDestino);
        escreveLinha("parent.erroConexao();", varquivoDestino);
        escreveLinha("</script>", varquivoDestino);	
    }
    finally
    {
        if(conexao!=null && !conexao.isClosed())
           conexao.close();
    }
    
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
