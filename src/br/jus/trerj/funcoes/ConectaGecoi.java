package br.jus.trerj.funcoes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;
import br.jus.trerj.funcoes.ListaAmbiente;

public class ConectaGecoi {
	
	public String conecta(String vusuario, String vsenha) throws ClassNotFoundException, SQLException {
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String vmsg = "";
		   try
		   {
			  
			  conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
			  
		      int vqtd_app = 0;
		      String vsql = "select Count(ga.id_app) AS app  " +
		             "from gecoi.permissao p, gecoi.grupo_app ga " +
		             "WHERE UPPER(p.logon_usuario)=UPPER(?) AND p.id_grupo(+)=ga.id_grupo";
			  
		      PreparedStatement pstm = conexao.prepareStatement(vsql);
		      pstm.setString(1,vusuario);
		      ResultSet resultSet = pstm.executeQuery();      
		      if (resultSet.next())
			  {  
			     vqtd_app = Integer.parseInt(resultSet.getString("app"));
			  }
		      else
			  {
			     vmsg = "O login e senha informados não tem acesso aos recursos GECOI.";
			  }
		      
			  if(vqtd_app>0)
			  {
				   vmsg = "sucesso";
			  }
			  else
			  {
		  	      vmsg = "O usuário informado não tem acesso a nenhuma APP do GECOI.";
			  }

		    }
		    catch (Exception ex)
		    {
		    	if (ex.getMessage().contains("ORA-01017"))
		    	{
		    		vmsg = "O login ou senha informados são inválidos.";
		    	}
		    	else
		    	{
		    		vmsg = "Ocorreu um erro:: " + ex.getMessage();
		    	}
		       System.out.println(vmsg);
		    } 
			finally
		    {
		      if(conexao != null && !conexao.isClosed())
		       conexao.close();
		    } 
		   
		   return vmsg;

	}

}
