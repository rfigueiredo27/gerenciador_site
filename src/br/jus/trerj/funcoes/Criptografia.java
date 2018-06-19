package br.jus.trerj.funcoes;

import java.io.File;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import javax.crypto.Cipher;
 
 
public class Criptografia {
 
  public static final String ALGORITHM = "RSA";
 
  //rjweb12
  //public static final String caminho = "/opt/tomcat/webapps/site/WEB-INF/";
  //public static final String caminho = "/opt/tomcat/webapps/site_responsivo/WEB-INF/";
  //public static final String caminho = "/opt/tomcat/webapps/ambiental/WEB-INF/";
  public static final String caminho = "/opt/tomcat/webapps/gecoi30/WEB-INF/";
  // rjweb17 e 18
  //public static final String caminho = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\gecoi.3.0\\WEB-INF\\";
  //public static final String caminho = "X:/workspace/gecoi.3.0/WebContent/WEB-INF/";
  // localhost
  //public static final String caminho = "d:/temp/";
  
  
  /**
   * Local da chave privada no sistema de arquivos.
   */
  //public static final String PATH_CHAVE_PRIVADA = "d:/temp/private.key";
  //public static final String PATH_CHAVE_PRIVADA = "X:/workspace/gecoi.3.0/WebContent/WEB-INF/private.key";
  //public static final String PATH_CHAVE_PRIVADA = "/opt/tomcat/webapps/ambiental/WEB-INF/private.key";
  public static final String PATH_CHAVE_PRIVADA = "/opt/tomcat/webapps/site/WEB-INF/private.key";
 
  /**
   * Local da chave pública no sistema de arquivos.
   */
  public static final String PATH_CHAVE_PUBLICA = "d:/temp/public.key";
  //public static final String PATH_CHAVE_PUBLICA = "X:/workspace/gecoi.3.0/WebContent/WEB-INF/public.key"; 
  //public static final String PATH_CHAVE_PUBLICA = caminho + "public.key";
  //public static final String PATH_CHAVE_PUBLICA = "/opt/tomcat/webapps/site/WEB-INF/public.key";
  //public static final String PATH_CHAVE_PUBLICA = "/opt/tomcat/webapps/mesario_voluntario/WEB-INF/public.key";
  //public static final String PATH_CHAVE_PUBLICA = "/opt/tomcat/webapps/eje/WEB-INF/public.key";
  
  
  /**
   * Gera a chave que contém um par de chave Privada e Pública usando 1025 bytes.
   * Armazena o conjunto de chaves nos arquivos private.key e public.key
   */
  public static void geraChave() {
    try {
      final KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
      keyGen.initialize(1024);
      final KeyPair key = keyGen.generateKeyPair();
 
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
 
  }
 
  /**
   * Verifica se o par de chaves Pública e Privada já foram geradas.
   */
  public static boolean verificaSeExisteChavesNoSO() {
 
    File chavePrivada = new File(PATH_CHAVE_PRIVADA);
    File chavePublica = new File(PATH_CHAVE_PUBLICA);
 
    if (chavePrivada.exists() && chavePublica.exists()) {
      return true;
    }
    
    return false;
  }
 
  /**
   * Criptografa o texto puro usando chave pública.
   */
  //public static byte[] criptografa(String texto, PublicKey chave) {
  public static byte[] criptografa(String texto, PrivateKey chave) {
    byte[] cipherText = null;
    
    try {
      final Cipher cipher = Cipher.getInstance(ALGORITHM);
      // Criptografa o texto puro usando a chave Púlica
      cipher.init(Cipher.ENCRYPT_MODE, chave);
      cipherText = cipher.doFinal(texto.getBytes());
      //System.out.println(texto+"==>"+cipherText);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return cipherText;
  }
 
  /**
   * Decriptografa o texto puro usando chave privada.
   */
  //public static String decriptografa(byte[] texto, PrivateKey chave) {
  public static String decriptografa(byte[] texto, PublicKey chave) {
    byte[] dectyptedText = null;
    try {
      final Cipher cipher = Cipher.getInstance(ALGORITHM);
      // Decriptografa o texto puro usando a chave Privada
      cipher.init(Cipher.DECRYPT_MODE, chave);
      
      dectyptedText = cipher.doFinal(texto);
      
 
    } catch (Exception ex) {
      ex.printStackTrace();
    }
 
    return new String(dectyptedText);
  }
 
}