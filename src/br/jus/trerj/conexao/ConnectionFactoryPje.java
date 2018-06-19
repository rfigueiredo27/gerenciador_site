package br.jus.trerj.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionFactoryPje {
	
	private static final String URL_POSTGRES = "jdbc:postgresql://";
	private static final String IP = "pjebdrj.tse.jus.br:5444";
	private static final String NOME_BANCO = "pje";
	private static final String URL_DA_CONEXAO = URL_POSTGRES + IP + "/" + NOME_BANCO;
	private static final String login = "consulta_tre";
	private static final String senha = "consulta_tre";
	private static final String driver = "org.postgresql.Driver";
	
	public Connection getConnection(){
				
		try{
			Class.forName(driver);
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		
		Connection conexao = null;
		
		try{
			conexao = (Connection)DriverManager.getConnection(URL_DA_CONEXAO , login , senha);
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return conexao;
	}
	
	public static void main(String[] args) throws SQLException {
		Connection conexao = DriverManager.getConnection(URL_DA_CONEXAO , login , senha);
		System.out.println("Conectado!");
		conexao.close();
	}
	
}
