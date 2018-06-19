<%@ page import="java.sql.*,java.util.*,br.jus.trerj.funcoes.*,java.io.*,java.security.PublicKey,br.jus.trerj.conexao.ConnectionFactory"%>

<%
//informa ao banco oracle que deve ser utilizado um pool de conexões
Connection con = null;
Statement statement = null;
ResultSet resultSet = null;
int identificador = 4;
ConnectionFactory connectionFactory = new ConnectionFactory();

		byte[] usuario = null;
		String banco = "";
		byte[] senha = null;
		//String caminho = "/opt/tomcat/webapps/site/WEB-INF/";
		String caminho = "x:/workspace/gecoi.3.0/WebContent/WEB-INF/";
		ObjectInputStream inputStream = null;
		Criptografia cripto = new Criptografia();
			inputStream = new ObjectInputStream(new FileInputStream(caminho + "public.key"));
			final PublicKey chavePublica = (PublicKey) inputStream.readObject();
			inputStream.close();
			
		        inputStream = new ObjectInputStream(new FileInputStream(caminho + "ii1.key"));
		        usuario = (byte[]) inputStream.readObject();
		        inputStream.close();
		   		//banco = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rjdbs03.tre-rj.gov.br)(PORT=1521)))(CONNECT_DATA=(SID=zod)))";
		   		inputStream = new ObjectInputStream(new FileInputStream(caminho + "ii2.key"));
		   		senha = (byte[]) inputStream.readObject();
		        inputStream.close();
			
			//out.print(chavePublica.toString());	
		out.print(cripto.decriptografa(usuario, chavePublica));
		out.print(cripto.decriptografa(senha, chavePublica));


%>