package teste;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class LerArquivoTxt {

	public void leitura(String vidarquivo)
	{
		try
		{
			//Connection conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
			Parametros parametros = new Parametros();
			Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), "internauta", "internauta");

			
		   //Acessando os dados no banco
		   String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho " +
		          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
				  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      

		   PreparedStatement pstm = conexao.prepareStatement(vsql);
		   pstm.setString(1,vidarquivo);

		   ResultSet resultSet = pstm.executeQuery();

		   //Se encontrou o registro
		   if(resultSet.next())
		   {
		     String vnome                   = resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
			 //String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
		     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
		     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024

		     //Indica onde arquivo será gravado
			 //java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
		     java.io.File varquivo = new File("/gecoi.3.0/webtemp/" + vnome);
			 
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
/*
		     //Preparação para ler o arquivo
		     StringBuffer contents = new StringBuffer();
		     BufferedReader reader = null;
		 
		     reader = new BufferedReader(new FileReader(varquivo));
		     String text = null;
		 
		     // Lê o arquivo, substituindo as quebras de linha pela tag </br>
		     while ((text = reader.readLine()) != null) {
				 
				 //Se no texto tiver as seguintes tags: <p>, <ul>, <li>, <h1>, <h2>, <h3>
				 //não é necessário pular uma linha com a tag <br>
		         if(text.indexOf("ul>")>0 || text.indexOf("li>")>0 || text.indexOf("p>")>0 || text.indexOf("h1>")>0 || text.indexOf("h2>")>0 || text.indexOf("h3>")>0)
				   contents.append(text);
				 else
		           contents.append(text + "<br>");
		     }
		     reader.close();
	     
		     //retorna o texto lido
		     //PrintWriter out = response.getwriter();
		     //out.println(contents.toString());
*/			 
		     //Apaga o arquivo no webtemp
		     //varquivo.delete();
		   }
		   else
		   {
		     //out.println("O arquivo não foi encontrado."); 
		   }

		   //fecha os objetos do banco
		   resultSet.close();
		   conexao.close();

		}
		catch (Exception ex)
		{
		    System.out.println("Ocorreu um erro: " + ex.getMessage());
		} 

		
	}
}
