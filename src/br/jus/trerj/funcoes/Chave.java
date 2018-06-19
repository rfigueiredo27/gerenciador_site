package br.jus.trerj.funcoes;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.codec.binary.Base64;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class Chave {
	
	public static final String ALGORITHM = "RSA";
	private static final String caminho = "/opt/tomcat/webapps/gecoi30/WEB-INF/";
	//private static final String caminho = "d:/Temp/";
	private static final String PATH_CHAVE_PUBLICA = caminho + "public.key";
	
	
	public String PegaChave(){
		String chave = "";
		
		return chave;
	}
	/*
	public void geraChave() {
	    try {
	    	
	      final KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
	      keyGen.initialize(1024);
	      final KeyPair key = keyGen.generateKeyPair();
	 
	      //File chavePrivadaFile = new File(PATH_CHAVE_PRIVADA);
	      String PATH_CHAVE_PRIVADA = PegaChave();
	      
	      //PegaChave();
	      File chavePrivadaFile = new File(PATH_CHAVE_PRIVADA);
	      File chavePublicaFile = new File(PATH_CHAVE_PUBLICA);
	 
	      // Cria os arquivos para armazenar a chave Privada e a chave Publica
	      if (chavePrivadaFile.getParentFile() != null) {
	        chavePrivadaFile.getParentFile().mkdirs();
	      }
	      
	      chavePrivadaFile.createNewFile();
	  
	      if (chavePublicaFile.getParentFile() != null) {
	        chavePublicaFile.getParentFile().mkdirs();
	      }
	      
	      chavePublicaFile.createNewFile();
	 
	      // Salva a Chave Pública no arquivo
	      ObjectOutputStream chavePublicaOS = new ObjectOutputStream(
	          new FileOutputStream(chavePublicaFile));
	      chavePublicaOS.writeObject(key.getPublic());
	      chavePublicaOS.close();
	 
	      // Salva a Chave Privada no arquivo
	      ObjectOutputStream chavePrivadaOS = new ObjectOutputStream(
	          new FileOutputStream(chavePrivadaFile));
	      chavePrivadaOS.writeObject(key.getPrivate());
	      chavePrivadaOS.close();
	    	
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	 
	  }*/
	
	public String enviar(String vpagina, String vcliente, String vusuario) throws ClassNotFoundException, FileNotFoundException, IOException, SQLException {
		Connection conexao = null;
		String vmsg = "E-mail enviado com sucesso.  Favor verificar o seu e-mail. ";
        String vnome = "";
        String vdestino = "";
        String resultado = "";
        String vsql = "";
		try {
			conexao = new ConnectionFactory().getConnection(2, vpagina, vcliente);
	        vsql = "SELECT login, nome, e_mail, To_Char(SYSDATE+15/1440,'yyyymmddhh24mi') as validade FROM guardiao.usuarios_gecoi WHERE upper(login) = upper(?)";
	        PreparedStatement pstm = conexao.prepareStatement(vsql);
	        pstm.setString(1, vusuario);
	        ResultSet resultSet = pstm.executeQuery();
	        if (resultSet.next())
	        {
	        	vnome = resultSet.getString("nome");
	        	vdestino = resultSet.getString("e_mail");
	        	resultado = resultSet.getString("nome") + "@@" + resultSet.getString("login") + "@@" + resultSet.getString("validade");
	        }
	        resultSet.close();
	    
			 vsql = "select internauta.sendmail(?,?,?,?,?) as em from dual";
				
			 pstm = conexao.prepareStatement(vsql);
			 pstm.setString(1,vnome);
			 pstm.setString(2,"seinte@tre-rj.jus.br");
			 pstm.setString(3,vdestino);
			 pstm.setString(4,"Envio de chave temporária");
			 pstm.setString(5,"Copie e cole a seguinte chave: <br />" + Base64.encodeBase64String(resultado.getBytes()) + "<br /> <br />Essa chave tem validade por 15 minutos.");
		  
			 resultSet = pstm.executeQuery();   
	
		  if (resultSet.next())
		  {
			 if (resultSet.getString("em").compareToIgnoreCase("0")!=0)
			 {
				 System.out.println(resultSet.getString("em"));
				 vmsg = resultSet.getString("em");
			 }
		  }
		  
		} catch (Exception e) {
		      System.out.println(e.getMessage());
		      vmsg = e.getMessage();
		      
		    }
	    finally
	    {
	    	if(conexao!=null && !conexao.isClosed())
	    		conexao.close();
	    }
		return vmsg;
	}

	 public boolean verificaValidade(String chave, String vusuario, String vsenha) throws SQLException {
		 
		 	boolean verificado = false; 
		 	Connection conexao = null;
		    try {

             String chaveCripto = "";
             //chaveCripto = Base64.encodeBase64String(chave.getBytes());
             chaveCripto = chave; 
     
			     System.out.println("String codificada " + chaveCripto);
			
			     //
			                // Decodifica uma string anteriormente codificada usando o método decodeBase64 e
			                // passando o byte[] da string codificada
			     //
			     byte[] decoded = Base64.decodeBase64(chaveCripto.getBytes());
			
			     //
			     // Imprime o array decodificado
			     //
			     //System.out.println(Arrays.toString(decoded));
			
			     //
			                // Converte o byte[] decodificado de volta para a string original e imprime
			                // o resultado.
			     //
			     String decodedString = new String(decoded);
			     System.out.println(decodedString);
			     
			        Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			        conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			        String vsql = "SELECT login, nome, to_char(sysdate, 'yyyymmddhh24mi') as agora FROM guardiao.usuarios_gecoi WHERE login = ?";
			        PreparedStatement pstm = conexao.prepareStatement(vsql);
			        pstm.setString(1, vusuario);
			        ResultSet rs = pstm.executeQuery();
			        String resultado = "";
			        long agora = 0;
			        if (rs.next())
			        {
			        	resultado = rs.getString("nome") + "@@" + rs.getString("login");
			        	agora = rs.getLong("agora");
			        }
			        rs.close();
			        String[] verificacao = decodedString.split("@@");
			        verificado = agora <= Long.parseLong(verificacao[2]);
			        if (verificado)
			        {
			        	verificado = resultado.equals(verificacao[0] + "@@" + verificacao[1]);
			        }

		    } catch (Exception e) {
			      System.out.println(e.getMessage());
			    }
		    finally
		    {
		    	conexao.close();
		    }
			    return verificado;
			  }
			  
	/*
	 public boolean verifica(String chave, String vusuario, String vsenha) throws SQLException {
		 
		 	boolean verificado = false; 
		 	Connection conexao = null;
		    try {

                String chaveCripto = "";
                //chaveCripto = Base64.encodeBase64String(chave.getBytes());
                chaveCripto = chave; 
        
			     //System.out.println("String codificada " + chaveCripto);
			
			     //
			                // Decodifica uma string anteriormente codificada usando o método decodeBase64 e
			                // passando o byte[] da string codificada
			     //
			     byte[] decoded = Base64.decodeBase64(chaveCripto.getBytes());
			
			     //
			     // Imprime o array decodificado
			     //
			     //System.out.println(Arrays.toString(decoded));
			
			     //
			                // Converte o byte[] decodificado de volta para a string original e imprime
			                // o resultado.
			     //
			     String decodedString = new String(decoded);
			     
			     
			        Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			        conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			        String vsql = "SELECT login, nome FROM guardiao.usuarios_gecoi WHERE login = ?";
			        PreparedStatement pstm = conexao.prepareStatement(vsql);
			        pstm.setString(1, vusuario);
			        ResultSet rs = pstm.executeQuery();
			        String resultado = "";
			        if (rs.next())
			        	resultado = rs.getString("nome") + "@@" + rs.getString("login");
			        rs.close();
			     verificado = decodedString.equals(resultado);
			    		 
		    } catch (Exception e) {
			      System.out.println(e.getMessage());
			    }
		    finally
		    {
		    	conexao.close();
		    }
			    return verificado;
			  }*/
	 
	 
	 /*public boolean verifica(byte[] chave, String vusuario, String vsenha) {
		 
		 	boolean verificado = false; 
		    try {
		    	
		    	Criptografia criptografia = new Criptografia();
		    	ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
		    	//ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(PATH_CHAVE_PUBLICA));
		        final PublicKey chavePublica = (PublicKey) inputStream.readObject();
		        
		        Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		        Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
		        String vsql = "SELECT login, nome FROM guardiao.usuarios_gecoi WHERE login = ?";
		        PreparedStatement pstm = conexao.prepareStatement(vsql);
		        pstm.setString(1, vusuario);
		        ResultSet rs = pstm.executeQuery();
		        String resultado = "";
		        if (rs.next())
		        	resultado = rs.getString("nome") + "@@" + rs.getString("login");
		        rs.close();
		        
		        
		        inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PRIVADA));
		        final PrivateKey chavePrivada = (PrivateKey) inputStream.readObject();
		        criptografia.criptografa("GUSTAVO AFFONSO DEBOSSAM@@GDEBOSSA", chavePrivada);
		        
		        System.out.println(""+resultado.hashCode());
		        System.out.println("r="+resultado);
		        System.out.println("c="+chave);
		        //System.out.println(criptografia.decriptografa(chave.getBytes(), chavePublica));
		        //verificado = criptografia.decriptografa(chave.getBytes(), chavePublica).equals(resultado);
		        
		        inputStream = new ObjectInputStream(new FileInputStream("d:/temp/externo1.key"));
		        byte[] mensagem = (byte[]) inputStream.readObject();
		        inputStream.close();
		        System.out.println("m="+mensagem);
		        System.out.println(criptografia.decriptografa(mensagem, chavePublica));
		        System.out.println("v="+criptografia.decriptografa(mensagem, chavePublica).equals(resultado));
		        //mensagem = chave.getBytes();

		        File criptoGerado = new File("d:/temp/externo_teste.key");
		        ObjectOutputStream chavePublicaOS = new ObjectOutputStream(
		            new FileOutputStream(criptoGerado));
		        chavePublicaOS.writeObject(chave);
		        chavePublicaOS.close();
		        inputStream = new ObjectInputStream(new FileInputStream("d:/temp/externo_teste.key"));
		        mensagem = (byte[]) inputStream.readObject();
		        inputStream.close();

		        //mensagem = chave;
		        System.out.println("m2="+mensagem);
		        System.out.println(criptografia.decriptografa(mensagem, chavePublica));
		        System.out.println("v2="+criptografia.decriptografa(mensagem, chavePublica).equals(resultado));
		      
		    } catch (Exception e) {
		      System.out.println(e.getMessage());
		    }
		    return verificado;
		  }	*/
}
