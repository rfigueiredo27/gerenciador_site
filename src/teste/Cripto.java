package teste;

import java.security.MessageDigest;



public class Cripto {

	public static void main(String[] args)  {
		// TODO Auto-generated method stub
		/*String digits = "0123456789abcdef";
	       
		//KeyGenerator keygen = KeyGenerator.getInstance("AES");
		KeyGenerator keygen = KeyGenerator.getInstance("SHA1");

		SecureRandom random = new SecureRandom();
		keygen.init(random);

		byte[] key = keygen.generateKey().getEncoded();

		StringBuffer result = new StringBuffer();

		for (int i = 0; i != key.length; i++) {
		    int v = key[i] & 0xff;

		    result.append(digits.charAt(v >> 4));
		    result.append(digits.charAt(v & 0xf));
		}
		   System.out.println(result.toString());
 
*/
	
		
		  try{
		        MessageDigest digest = MessageDigest.getInstance("SHA-256");
		        byte[] hash = digest.digest("snhgc".getBytes("UTF-8"));
		        StringBuffer hexString = new StringBuffer();

		        for (int i = 0; i < hash.length; i++) {
		            String hex = Integer.toHexString(0xff & hash[i]);
		            if(hex.length() == 1) hexString.append('0');
		            hexString.append(hex);
		        }

		        System.out.print(hexString.toString());
		    } catch(Exception ex){
		       throw new RuntimeException(ex);
		    }
	}

}
