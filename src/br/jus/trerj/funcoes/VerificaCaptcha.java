package br.jus.trerj.funcoes;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.net.URL;
import java.security.PublicKey;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;

public class VerificaCaptcha {

	public static final String url = "https://www.google.com/recaptcha/api/siteverify";
	private final static String USER_AGENT = "Mozilla/5.0";
	//private final static String caminho = "/opt/tomcat/webapps/site/WEB-INF/";
	private final static String caminho = "/opt/tomcat/webapps/site_responsivo/WEB-INF/";
	//private final static String caminho = "/opt/tomcat/webapps/mesario_voluntario/WEB-INF/";
	//private final static String caminho = "/opt/tomcat/webapps/eje/WEB-INF/";
	//private final static String caminho = "x:/workspace/gecoi.3.0/WebContent/WEB-INF/";
	//private final static String caminho = "/opt/tomcat/webapps/ambiental/WEB-INF/";

	public static boolean verify(String gRecaptchaResponse) throws IOException {
		if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) {
			return false;
		}
		
		try{
		URL obj = new URL(url);
		HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

		// add reuqest header
		con.setRequestMethod("POST"); 
		con.setRequestProperty("User-Agent", USER_AGENT);
		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		
		Criptografia criptografia = new Criptografia();
		ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
		final PublicKey chavePublica = (PublicKey) inputStream.readObject();
		inputStream.close();
		
		
		inputStream = new ObjectInputStream(new FileInputStream(caminho + "k2.key"));
		byte[] secret = (byte[]) inputStream.readObject();
		inputStream.close();
		String postParams = "secret=" + criptografia.decriptografa(secret, chavePublica) + "&response=" + gRecaptchaResponse;
		inputStream.close();

		// Send post request
		con.setDoOutput(true);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(postParams);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();

		BufferedReader in = new BufferedReader(new InputStreamReader(
				con.getInputStream()));
		String inputLine, outputString = "";
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			outputString += inputLine;
		}
		in.close();

		// print result
		CaptchaResponse capRes = new Gson().fromJson(outputString, CaptchaResponse.class);
		return capRes.isSuccess();
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}