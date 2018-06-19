package br.jus.trerj.funcoes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.App;
import br.jus.trerj.modelo.Parametros;

public class ListaApp {
	
	public  ArrayList<App> getListaApp(String vcaminho, String vusuario, String vsenha) throws ClassNotFoundException, SQLException{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		ArrayList<App> listaApp = new ArrayList<App>();

		if(vusuario.compareToIgnoreCase("")!=0)
		{
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			ResultSet resultSet = null; 
			try
			{	
				String vsql = "SELECT ap.id_app, ap.nome, ap.caminho, ap.icone, ap.descricao, pe.id_grupo, ap.icone_extensao " +
						"FROM gecoi.app ap, gecoi.grupo_app ga, gecoi.permissao pe " +
						"WHERE ap.id_app=ga.id_app AND ga.id_grupo=pe.id_grupo " +
						"AND Upper(pe.logon_usuario) = Upper(?) and ap.id_app <> 27 " +
						"ORDER BY ap.nome";
	 
				PreparedStatement pstm = conexao.prepareStatement(vsql);
				pstm.setString(1,vusuario);
				String appAnterior = "";

				resultSet = pstm.executeQuery();      
    
				if (resultSet.next())
				{
					GravarArquivo gravarArquivo = new GravarArquivo();
					do
					{
						if (!appAnterior.equals(resultSet.getString("nome")))
						{
							App app = new App();
							app.setId_app(resultSet.getInt("id_app"));
							app.setNome(resultSet.getString("nome"));
							app.setNomeArquivo("icone_app" + resultSet.getString("id_app") + "." + resultSet.getString("icone_extensao"));  			
							app.setCaminho(resultSet.getString("caminho"));
							app.setDescricao(resultSet.getString("descricao"));
							listaApp.add(app);  
							//grava imagem
							gravarArquivo.gravarApp(app.getId_app(), vcaminho, vusuario, vsenha);
						}
						appAnterior = resultSet.getString("nome");
    	  
					}  while (resultSet.next());
	  
					//if (resultSet.getInt("id_grupo") == 0)
						//out.println("<div id='app'><img src='/gecoi.3.0/img/banco_desenv.jpg';' title='Banco de Desenvolvimento'/><p>Banco de Desenvolvimento</p></div>");
					//resultSet.close();
				}
				/*else
    			{
  	  				vmsg = "Não há aplicativos cadastrados para esse usuário.";
	  				out.println(vmsg);
  
    			}*/
			}
			catch (SQLException ex)
			{
				//vmsg = "Ocorreu um erro:: " + ex.getMessage();
				//out.println(vmsg);	   
				System.out.println( ex.getMessage());
			} 
			finally
			{
				if(conexao!=null && !conexao.isClosed())
					conexao.close();
				resultSet.close();
				resultSet = null;
			} 
		}	
		return listaApp;
	}
		public  ArrayList<App> getListaAppExterno(String vcaminho, String vusuario, String vsenha) throws ClassNotFoundException, SQLException{
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
			Connection conexao = null;
			ArrayList<App> listaApp = new ArrayList<App>();

			if(vusuario.compareToIgnoreCase("")!=0)
			{
				conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
				ResultSet resultSet = null; 
				try
				{	
					String vsql = "SELECT ap.id_app, ap.nome, ap.caminho, ap.icone, ap.descricao, pe.id_grupo, ap.icone_extensao " +
							"FROM gecoi.app ap, gecoi.grupo_app ga, gecoi.permissao pe " +
							"WHERE ap.id_app=ga.id_app AND ga.id_grupo=pe.id_grupo " +
							"AND Upper(pe.logon_usuario) = Upper(?) and ap.id_app = 27 " +
							"ORDER BY ap.nome";
		 
					PreparedStatement pstm = conexao.prepareStatement(vsql);
					pstm.setString(1,vusuario);
					String appAnterior = "";

					resultSet = pstm.executeQuery();      
	    
					if (resultSet.next())
					{
						GravarArquivo gravarArquivo = new GravarArquivo();
						do
						{
							if (!appAnterior.equals(resultSet.getString("nome")))
							{
								App app = new App();
								app.setId_app(resultSet.getInt("id_app"));
								app.setNome(resultSet.getString("nome"));
								app.setNomeArquivo("icone_app" + resultSet.getString("id_app") + "." + resultSet.getString("icone_extensao"));  			
								app.setCaminho(resultSet.getString("caminho"));
								app.setDescricao(resultSet.getString("descricao"));
								listaApp.add(app);  
								//grava imagem
								gravarArquivo.gravarApp(app.getId_app(), vcaminho, vusuario, vsenha);
							}
							appAnterior = resultSet.getString("nome");
	    	  
						}  while (resultSet.next());
		  
						//if (resultSet.getInt("id_grupo") == 0)
							//out.println("<div id='app'><img src='/gecoi.3.0/img/banco_desenv.jpg';' title='Banco de Desenvolvimento'/><p>Banco de Desenvolvimento</p></div>");
						//resultSet.close();
					}
					/*else
	    			{
	  	  				vmsg = "Não há aplicativos cadastrados para esse usuário.";
		  				out.println(vmsg);
	  
	    			}*/
				}
				catch (SQLException ex)
				{
					//vmsg = "Ocorreu um erro:: " + ex.getMessage();
					//out.println(vmsg);	   
					System.out.println( ex.getMessage());
				} 
				finally
				{
					if(conexao!=null && !conexao.isClosed())
						conexao.close();
					resultSet.close();
					resultSet = null;
				} 
			}	
			return listaApp;
		}
	
}