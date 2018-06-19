package br.jus.trerj.funcoes;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Calendar;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.webflow.execution.RequestContext;


public class UploadArquivo {

	//public static void enviar(File arquivo)
	public static void enviar(InputStream arquivo, String nomeArquivo)
	//public static void enviar(MultipartFile arquivo)
	{
		
		//FileMultipartData part =  new FileMultipartData();
		//InputStream inputStream = part.getFileMultipart().get(0).getByteStream();		
		
		//RequestContext context = getRequestContext();
		Calendar c = Calendar.getInstance();
		System.out.println(nomeArquivo + "<br>começo: "+c.getTime());
		//String SFTPGECOIDIR = "/opt/tomcat/webapps/site/webtemp/";
		String SFTPWORKINGDIR = "/opt/tomcat/webapps/site/webtemp/";
		
		String SFTPHOST = "192.168.202.81";
		String SFTPPASS = "G77Jf7y/#g?y";
		String SFTPUSER = "seinte"; 
				
	    int SFTPPORT = 22;
	    Session session = null;
	    Channel channel = null;
	    ChannelSftp channelSftp = null;
	
	    try {
	    	c = Calendar.getInstance();
	    	System.out.println("conectar: "+c.getTime());
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
	        //File f = new File(vnomeDiretorioFisico + "ultima_noticia_imagem.htm");
	        //channelSftp.put(new FileInputStream(f), f.getName());
	        //channelSftp.put(new FileInputStream(arquivo), arquivo.getName());
	        //channelSftp.put(new FileInputStream(arquivo), arquivo.getOriginalFilename());
	        //channelSftp.put(new FileInputStream(arquivo.getOriginalFilename()), arquivo.getOriginalFilename());
	        c = Calendar.getInstance();
	        System.out.println("upload: "+c.getTime());
	        channelSftp.put(arquivo, nomeArquivo);
	        c = Calendar.getInstance();
	        System.out.println("fim upload: "+c.getTime());
	        /*f = new File(vnomeDiretorioFisico + "ultimas_noticias_index.htm"); 
	        // copia todos os arquivos gerados
	        channelSftp.cd(SFTPGECOIDIR);
	        String[] agerados = vgerados.split("-");
	        for (String gerado : agerados)
	        {
	            f = new File(vnomeDiretorioGecoi + gerado);
	            channelSftp.put(new FileInputStream(f), f.getName());        	
	        }*/
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	}

}
