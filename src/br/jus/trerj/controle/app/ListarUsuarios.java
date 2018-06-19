package br.jus.trerj.controle.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

public class ListarUsuarios extends HttpServlet implements Servlet{

	public void doPost(HttpServletRequest request, HttpServletResponse response)        	throws ServletException, IOException {
		
		Connection conexao = null;
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		PrintWriter out = response.getWriter();

		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			String vsql = "SELECT initcap(u.nome) AS nome, u.login FROM gecoi.permissao p, gecoi.grupo_app ga, guardiao.usuarios_gecoi u " + 
						  "WHERE p.id_grupo = ga.id_grupo AND ga.id_app = ? AND Upper(p.logon_usuario) = Upper(u.login) and ga.id_grupo > 0 " +
						  "order by nome";
			PreparedStatement pstm = conexao.prepareStatement(vsql);
			pstm.setInt(1,Integer.parseInt(request.getParameter("idApp")));
			ResultSet rs = pstm.executeQuery();
			
			out.println("Usu&aacute;rios com acesso:");
			out.println("<ul>");
			if (rs.next())
			{
				do
				{
					out.println("<li>" + rs.getString("nome") + " - " + rs.getString("login") + "</li>");
				}while (rs.next());
			}
			else
			{
				out.println("N&atilde;o h&aacute; usu&aacute;rios cadastrados");
			}
			out.println("</ul>");
		 
			rs.close();
			rs = null;
			conexao.close();
			
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
