package br.jus.trerj.conexao;

import java.security.PublicKey;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;






import br.jus.trerj.funcoes.Criptografia;
import br.jus.trerj.modelo.Parametros;

public class ConnectionFactory {
	public Connection getConnection(String banco, String usuario, String senha) throws ClassNotFoundException{
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			return DriverManager.getConnection(banco,  usuario, senha);
		}catch (SQLException e){
			throw new RuntimeException(e); 
		}
	}
	
	public Connection getConnection(int identificador, String vpagina, String vcliente) throws ClassNotFoundException, FileNotFoundException, IOException{
		byte[] usuario = null;
		String banco = "";
		byte[] senha = null;
		String caminho = "";
		caminho = "o:/workspace/gecoi.3.0/WebContent/WEB-INF/";
		//rjweb12
		//caminho = "/opt/tomcat/webapps/site/WEB-INF/";
		//caminho = "/opt/tomcat/webapps/site_responsivo/WEB-INF/";
		//caminho = "/opt/tomcat/webapps/gecoi30/WEB-INF/";
		//rjweb17 e 18
		//caminho = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\gecoi.3.0\\WEB-INF\\";
		//caminho = "/opt/tomcat/webapps/mesario_voluntario/WEB-INF/";
		//caminho = "/opt/tomcat/webapps/eje/WEB-INF/";
		// localhost
		//caminho = new File(".").getCanonicalPath() + "\\";
		try{
			ObjectInputStream inputStream = null;
			Criptografia criptografia = new Criptografia();
			//System.out.println(criptografia.PATH_CHAVE_PUBLICA);
			//inputStream = new ObjectInputStream(new FileInputStream(criptografia.PATH_CHAVE_PUBLICA));
			//localhost
			inputStream = new ObjectInputStream(new FileInputStream(caminho + "public.key"));
			final PublicKey chavePublica = (PublicKey) inputStream.readObject();
			switch(identificador){
		   	case 1:
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "g1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "g2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		break;
		   	case 2:
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "i1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)(SERVER=SHARED)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "i2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		break;
		   	case 3:
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "t1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)(SERVER=SHARED)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "t2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		break;
		   	case 4:
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "ii1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rjdbs03.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=zod)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "ii2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		break;
		   	case 5:
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "ge1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "ge2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		break;
		   }
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//System.out.println("chavePublica");
			Connection conexao = DriverManager.getConnection(banco,  criptografia.decriptografa(usuario, chavePublica), criptografia.decriptografa(senha, chavePublica));

			//serão utilizados pelo identifica_sessao.jsp
			  String vaplicacao = "Internet";

			  //Class.forName("oracle.jdbc.driver.OracleDriver");
			  Statement statement = conexao.createStatement();
			  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_module(module_name => '" + vaplicacao + "', action_name => '" + vpagina + "'); end;");
			  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_client_info('" + vcliente + "'); end;");
			  statement.close();
			
			return conexao;
		}catch (SQLException e){
			throw new RuntimeException(e); 
		}
	}
	
	public void fechaConexao(Connection connection) throws SQLException
	{
		connection.close();
	}

	public Connection getConnectionExterno() throws ClassNotFoundException, FileNotFoundException, IOException{
		byte[] usuario = null;
		String banco = "";
		byte[] senha = null;
		String caminho = "";
		//rjweb12
		caminho = "/opt/tomcat/webapps/gecoi30/WEB-INF/";
		//localhost
		//caminho = new File(".").getCanonicalPath() + "\\";
		try{
			ObjectInputStream inputStream = null;
			Criptografia criptografia = new Criptografia();
			//localhost
			inputStream = new ObjectInputStream(new FileInputStream(caminho + "public.key"));
			final PublicKey chavePublica = (PublicKey) inputStream.readObject();
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "ge1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rj1.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=adm)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "ge2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();

			Class.forName("oracle.jdbc.driver.OracleDriver");
			//System.out.println("chavePublica");
			Connection conexao = DriverManager.getConnection(banco,  criptografia.decriptografa(usuario, chavePublica), criptografia.decriptografa(senha, chavePublica));
			/*
			 Não precisa no portal do servidor
			 
			//serão utilizados pelo identifica_sessao.jsp
			  String vaplicacao = "Internet";

			  //Class.forName("oracle.jdbc.driver.OracleDriver");
			  Statement statement = conexao.createStatement();
			  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_module(module_name => '" + vaplicacao + "', action_name => '" + vpagina + "'); end;");
			  statement.executeUpdate("begin DBMS_APPLICATION_INFO.set_client_info('" + vcliente + "'); end;");
			  statement.close();
			*/
			return conexao;
		}catch (SQLException e){
			throw new RuntimeException(e); 
		}
	}
	
}
