package br.jus.trerj.funcoes;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.text.*;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class GravarArquivo {

	public String gravarApp(int vidapp, String vcaminho, String vusuario, String vsenha)
	{
		String vnome = "";
		try
		{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

		   //Acessando os dados no banco
		    String vsql = "SELECT dbms_lob.getlength(icone) AS tamanho, id_app, icone_extensao, icone " +
		            "FROM gecoi.app " +
		            "WHERE id_app=?";

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setInt(1,vidapp);

		   ResultSet resultSet = pstm.executeQuery();
		   
		   //Se encontrou o registro
		   if(resultSet.next())
		   {
			     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
			     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024
			     //String caminho = new File("").get
			     java.io.File varquivo = new File(vcaminho + "\\img\\icone_app" + resultSet.getString("id_app") + "." + resultSet.getString("icone_extensao"));
		     
		    	 //Grava o arquivo na pasta
		    	 FileOutputStream fos = new FileOutputStream(varquivo);

		     	//Configura o tamanho do buffer que será usado para gravar o arquivo
		     	byte[] buffer       = new byte[1024];
		     	byte[] sobra_buffer = new byte[vresto_arquivo]; 

		     	//Grava o arquivo na pasta especificada com o tamanho especificado
		     	InputStream is = resultSet.getBinaryStream("icone");
		     	for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
		     	{  
		    	 is.read(buffer);
		        	fos.write(buffer);
		     	}
		     	is.read(sobra_buffer);
		     	fos.write(sobra_buffer);

		     	//fecha o objeto
		     	fos.close();
		     		     
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return "erro";
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return vnome;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return "erro";
		} 

		
	}
	

	// Grava o arquivo do banco (passado como parametro) para o diretório passado como parametro
	public String gravarNovo(String vidarquivo, String vdiretorio, String vusuario, String vsenha)
	{
		String vnome = "";
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

		   //Acessando os dados no banco
		   //String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho, ar.pasta_fisica " +
		   //       "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
			//	  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      
		   
		    String vsql = "SELECT Nvl(co.data_ult_alteracao,co.data_criacao) AS data_ult_alteracao, ar.pasta_fisica, aq.nome, dbms_lob.getlength(aq.arquivo) AS tamanho, ar.descricao, aq.arquivo " +
		            "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.area ar " +
		            "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo AND ca.id_area=ar.id_area " +
		            "AND aq.id_arquivo=?";

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidarquivo);

		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
		     vnome                   		= resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
		     if (!vusuario.equals(""))
		    	 vnome = vnome.substring(0, vnome.lastIndexOf(".")) + "-" + vusuario + vnome.substring(vnome.lastIndexOf(".")); //coloco o nome do usuario no nome do arquivo  
			 //String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
		     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
		     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024
		     
		     java.util.Date vdata_alteracao  = resultSet.getTimestamp("data_ult_alteracao"); //guarda a data da última alteração do arquivo

		     //Indica onde arquivo será gravado
			 //java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
		     //java.io.File varquivo = new File("/gecoi.3.0/webtemp/" + vnome);
		     //if (vdiretorio.equals(""))
		    	 //vdiretorio = resultSet.getString("pasta_fisica");
		     
		     if (!new File(vdiretorio).exists()) {  
		    	 new File(vdiretorio).mkdirs(); //mkdir() cria somente um diretório, mkdirs() cria diretórios e subdiretórios.  
		      }   

		     java.io.File varquivo = new File(vdiretorio + "\\" + vnome);
		     
		     if (!varquivo.exists() || (vdata_alteracao.getTime() > varquivo.lastModified())) 
		     {
		    	 //Grava o arquivo na pasta
		    	 FileOutputStream fos = new FileOutputStream(varquivo);

		     	//Configura o tamanho do buffer que será usado para gravar o arquivo
		     	byte[] buffer       = new byte[1024];
		     	byte[] sobra_buffer = new byte[vresto_arquivo]; 

		     	//Grava o arquivo na pasta especificada com o tamanho especificado
		     	InputStream is = resultSet.getBinaryStream("arquivo");
		     	for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
		     	{  
		    	 is.read(buffer);
		        	fos.write(buffer);
		     	}
		     	is.read(sobra_buffer);
		     	fos.write(sobra_buffer);

		     	//fecha o objeto
		     	fos.close();
		     }
		     		     
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return "erro";
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return vnome;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return "erro";
		} 

		
	}
	
	///?????????????
	/*public InputStream arquivoStream(String vidarquivo)

	{
		InputStream is = null;
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), "internauta", "internauta");

		   //Acessando os dados no banco
		   String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho, ar.pasta_fisica " +
		          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
				  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      
		   

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidarquivo);

		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
			   is = resultSet.getBinaryStream("arquivo");
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return null;
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return is;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return null;
		} 

		
	}
	*/
	
	public String gravar(String vidarquivo, String vdiretorio, String vusuario, String vsenha)
	{
		String vnome = "";
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

		   //Acessando os dados no banco
		   String vsql = "select a.arquivo, a.nome, a.descricao, nvl(dbms_lob.getlength(a.arquivo),0) AS tamanho, ar.pasta_fisica " +
		          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
				  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidarquivo);
		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
		     vnome                   		= resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
		     if (!vusuario.equals(""))
		    	 vnome = vnome.substring(0, vnome.lastIndexOf(".")) + "-" + vusuario + vnome.substring(vnome.lastIndexOf(".")); //coloco o nome do usuario no nome do arquivo  
			 //String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
		     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
		     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024
		     
		     if (vtamanho_arquivo > 0)
		     {

			     //Indica onde arquivo será gravado
				 //java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
			     //java.io.File varquivo = new File("/gecoi.3.0/webtemp/" + vnome);
			     if (vdiretorio.equals(""))
			    	 vdiretorio = resultSet.getString("pasta_fisica");
			     java.io.File varquivo = new File(vdiretorio + "\\" + vnome);
				 //Grava o arquivo na pasta
			     //FileOutputStream fos = new FileOutputStream(varquivo);
			     BufferedWriter fon = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(varquivo),"UTF-8"));
			     
	
			     //Configura o tamanho do buffer que será usado para gravar o arquivo
			     char[] buffer       = new char[1025];
			     char[] sobra_buffer = new char[vresto_arquivo]; 
	
			     //Grava o arquivo na pasta especificada com o tamanho especificado
			     //InputStream is = resultSet.getBinaryStream("arquivo");
			     BufferedReader in = new BufferedReader(new InputStreamReader(resultSet.getBinaryStream("arquivo"), "UTF-8"));
			     for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
			     {  
			    	in.read(buffer);
			    	fon.write(buffer);
			     }
			     in.read(sobra_buffer);
			     fon.write(sobra_buffer);
	
			     //fecha o objeto
			     fon.close();
		     }
		     else
			 {
		    	 System.out.println("O arquivo não foi encontrado.");
		    	 return "erro";
			 }
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return "erro";
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return vnome;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return "erro";
		} 

		
	}
	
	// Grava o arquivo do banco a partir de um conteúdo e extensão (passados como parametro) para o diretório passado como parametro
	public String gravar(String vidConteudo, String vextensao, String vdiretorio, String vusuario, String vsenha)
	{
		String vnome = "";
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			
		   //Acessando os dados no banco
		   String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho " +
		          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
				  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and ca.id_conteudo = ? " +
		          "and SubStr(nome,InStr(nome, '.')+1, 3) = ?";	      

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidConteudo);
		   pstm.setString(2,vextensao);

		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
		     vnome                   		= resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
		     if (!vusuario.equals(""))
		    	 vnome = vnome.substring(0, vnome.lastIndexOf(".")) + "-" + vusuario + vnome.substring(vnome.lastIndexOf(".")); //coloco o nome do usuario no nome do arquivo  
			 //String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
		     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
		     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024

		     //Indica onde arquivo será gravado
		     java.io.File varquivo = new File(vdiretorio + "\\" + vnome);
			 
			 //Grava o arquivo na pasta
		     BufferedWriter fos = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(varquivo),"UTF-8"));
		     //FileOutputStream fos = new FileOutputStream(varquivo);

		     //Configura o tamanho do buffer que será usado para gravar o arquivo
		     //byte[] buffer       = new byte[1024];
		     //byte[] sobra_buffer = new byte[vresto_arquivo]; 

		     char[] buffer       = new char[1024];
		     char[] sobra_buffer = new char[vresto_arquivo]; 
		     
		     //Grava o arquivo na pasta especificada com o tamanho especificado
		     //InputStream is = resultSet.getBinaryStream("arquivo");
		     BufferedReader in = new BufferedReader(new InputStreamReader(resultSet.getBinaryStream("arquivo"), "UTF-8"));
		     //BufferedWriter fos = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(varquivo),"UTF-8"));
		     
		     for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
		     {  
		    	in.read(buffer);
		        
		        fos.write(sobra_buffer);
		     }
		     in.read();
		     fos.write(sobra_buffer);

		     //fecha o objeto
		     fos.close();
		     		     
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return "erro";
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return vnome;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return "erro";
		} 

		
	}
	
	public String gravarComHora(String vidarquivo, String vdiretorio, String vusuario, String vsenha)
	{
		String vnome = "";
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

		   //Acessando os dados no banco
		   String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho, ar.pasta_fisica " +
		          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
				  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidarquivo);

		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
		     vnome                   		= resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
		     Calendar c = Calendar.getInstance();
		     SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
		     String vagora = ft.format(c.getTime());
		     if (!vusuario.equals(""))
		    	 vnome = vnome.substring(0, vnome.lastIndexOf(".")) + "-" + vusuario + "-" + vagora + vnome.substring(vnome.lastIndexOf(".")); //coloco o nome do usuario no nome do arquivo  
			 //String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
		     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
		     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024

		     //Indica onde arquivo será gravado
			 //java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
		     //java.io.File varquivo = new File("/gecoi.3.0/webtemp/" + vnome);
		     if (vdiretorio.equals(""))
		    	 vdiretorio = resultSet.getString("pasta_fisica");
		     java.io.File varquivo = new File(vdiretorio + "\\" + vnome);
			 //Grava o arquivo na pasta
		     FileOutputStream fos = new FileOutputStream(varquivo);

		     //Configura o tamanho do buffer que será usado para gravar o arquivo
		     byte[] buffer       = new byte[1024];
		     byte[] sobra_buffer = new byte[vresto_arquivo]; 

		     //Grava o arquivo na pasta especificada com o tamanho especificado
		     InputStream is = resultSet.getBinaryStream("arquivo");
		     for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
		     {  
		        is.read(buffer);
		        fos.write(buffer);
		     }
		     is.read(sobra_buffer);
		     fos.write(sobra_buffer);

		     //fecha o objeto
		     fos.close();
		     		     
		   }
		   else
		   {
		     System.out.println("O arquivo não foi encontrado.");
		     return "erro";
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();
		   return vnome;

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		    return "erro";
		} 

		
	}
	
	
}
