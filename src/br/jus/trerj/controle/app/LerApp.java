package br.jus.trerj.controle.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.App;
import br.jus.trerj.modelo.Parametros;

public class LerApp {

	public ArrayList<App> getListaApp(String vusuario, String vsenha) throws ClassNotFoundException, SQLException
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

		String vsql = "SELECT a.id_app, a.nome FROM gecoi.grupo_app ga, gecoi.app a, gecoi.permissao p "+
					  "WHERE ga.id_grupo = p.id_grupo AND ga.id_app = a.id_app AND Upper(p.logon_usuario) = Upper(?) ";
		PreparedStatement pstm = conexao.prepareStatement(vsql);
		pstm.setString(1,vusuario);
		ResultSet rs = pstm.executeQuery();
		ArrayList<App> listaApp = new ArrayList<App>();
		while (rs.next())
		{
			App app = new App();
			app.setId_app(rs.getInt("id_app"));
			app.setNome(rs.getString("nome"));
			listaApp.add(app);
		}
		 
		rs.close();
		rs = null;
		conexao.close();
		return listaApp;
		
	}	
}
