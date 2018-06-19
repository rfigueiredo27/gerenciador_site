package br.jus.trerj.funcoes;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class ListaAmbiente {
	
	public String mostraAmbiente(String vusuario, String vsenha)  
	{
   	 	 String vambiente = "Produção";
		 Parametros parametros = new Parametros(vambiente);
		 Connection conexao = null;
		 if (vusuario.length() > 0)
		 {
			 try
			 {
				 //System.out.println(vusuario);
				 conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
				 String vsql = "SELECT Count(*) as conta FROM gecoi.permissao WHERE id_grupo = 0 AND UPPER(logon_usuario)=UPPER(?)";
				 PreparedStatement pstm = conexao.prepareStatement(vsql);
				 pstm.setString(1,vusuario);
				 ResultSet resultSet = pstm.executeQuery();
				 resultSet.next();
				 if (resultSet.getInt("conta") == 1)
				 {
		    	 
					 // localhost
					 String caminho = "o:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\gecoi.3.0\\apps\\troca_banco\\banco.txt";
					 // rjweb08
					 //caminho = "D:\\Apache Software Foundation\\Tomcat 7.0\\webapps\\gecoi.3.0\\apps\\troca_banco\\banco.txt";
					 // rjweb18
					 //caminho = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\gecoi.3.0\\apps\\troca_banco\\banco.txt";
					 File arqTexto = new File(caminho);
					 if (arqTexto.exists())
					 {
						 try
						 {
							 FileReader arq = new FileReader(caminho);		
							 BufferedReader lerArq = new BufferedReader(arq);
							 vambiente = lerArq.readLine(); // lê a primeira linha
							 arq.close();
						 }
						 catch (IOException ex)
						 {
							 System.out.println(ex.getMessage());
						 }
					 }
				 }
			 }
		     catch (Exception e)
		     {
		    	 
		     }
			 finally
			 {
				 if (!(conexao == null))
				 {
					 try
					 {
						 conexao.close();
					 }
					 catch (SQLException esql)
					 {
						 
					 }
				 }	
			 }
		 }
	     return vambiente.toLowerCase();

	}
}
