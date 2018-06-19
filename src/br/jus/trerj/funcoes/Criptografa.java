package br.jus.trerj.funcoes;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;

import javax.crypto.Cipher;
 
 
public class Criptografa {
 

  /**
   * Testa o Algoritmo
   */
  public static void main(String[] args) {
 
    try {
    	
    	Criptografia criptografia = new Criptografia();
    	
      // Verifica se já existe um par de chaves, caso contrário gera-se as chaves..
      if (!criptografia.verificaSeExisteChavesNoSO()) {
       // Método responsável por gerar um par de chaves usando o algoritmo RSA e
       // armazena as chaves nos seus respectivos arquivos.
    	  criptografia.geraChave();
      }
 
      //final String msgOriginal = "/opt/tomcat/webapps/site/gecoi_arquivos/noticias/";
      final String msgOriginal = ";_ky!a3W$$74"; 
      ObjectInputStream inputStream = null;
 
      // Criptografa a Mensagem usando a Chave Pública
      inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
      final PublicKey chavePublica = (PublicKey) inputStream.readObject();
      //final byte[] textoCriptografado = criptografa(msgOriginal, chavePublica);
 System.out.println(criptografia.PATH_CHAVE_PRIVADA);
      // Decriptografa a Mensagem usando a Chave Pirvada
      inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PRIVADA));
      final PrivateKey chavePrivada = (PrivateKey) inputStream.readObject();
      //final String textoPuro = decriptografa(textoCriptografado, chavePrivada);
      System.out.println(criptografia.PATH_CHAVE_PUBLICA);
      final byte[] textoCriptografado = criptografia.criptografa(msgOriginal, chavePrivada);
      
      //final String textoPuro = criptografia.decriptografa(textoCriptografado, chavePublica);

      // Imprime o texto original, o texto criptografado e 
      // o texto descriptografado.
      System.out.println("Mensagem Original: " + msgOriginal);
      System.out.println("Mensagem Criptografada: " +textoCriptografado.toString());
      //System.out.println("Mensagem Decriptografada: " + textoPuro);
      inputStream.close();
       
      // Salva a Chave Pública no arquivo
      File criptoGerado = new File("d:/temp/n2.key");
      ObjectOutputStream chavePublicaOS = new ObjectOutputStream(
          new FileOutputStream(criptoGerado));
      chavePublicaOS.writeObject(textoCriptografado);
      chavePublicaOS.close();

      inputStream = new ObjectInputStream(new FileInputStream("d:/temp/n2.key"));
      byte[] mensagem = (byte[]) inputStream.readObject();
      inputStream.close();
      //usuario = textoCriptografado;
      //System.out.println(usuario.toString());
      System.out.println(mensagem + " > " + criptografia.decriptografa(mensagem, chavePublica));
      System.out.println(mensagem.toString() + " > " );
      System.out.println(criptografia.decriptografa(mensagem, chavePublica));
      System.out.println(textoCriptografado.hashCode());
      //System.out.println(decriptografa(usuario, chavePublica));
      //byte[] senha="[B@771c7eb2".getBytes();
      //System.out.println(criptografia.decriptografa(senha, chavePublica));
 
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}