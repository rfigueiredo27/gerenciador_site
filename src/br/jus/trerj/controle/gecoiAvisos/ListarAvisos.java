package br.jus.trerj.controle.gecoiAvisos;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.GecoiAviso;
import br.jus.trerj.modelo.Parametros;

/**
 * Servlet implementation class ListarAvisos
 */
@WebServlet("/ListarAvisos")
public class ListarAvisos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListarAvisos() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 int varea   = Integer.parseInt((String) request.getParameter("area"));
		 int vano    = Integer.parseInt((String) request.getParameter("ano"));
		 String String   = request.getParameter("area");
		 String String2    = request.getParameter("ano");
		 
		 try {
			
			List<GecoiAviso> avisos = new ListaGecoiAviso().getListaAvisos(varea, vano, String, String2 );
			request.getServletContext().setAttribute("avisos", avisos);
			request.setAttribute("avisos", request.getServletContext().getAttribute("avisos"));
			
			RequestDispatcher rd = request.getRequestDispatcher("lista_avisos.jsp");
			rd.forward(request, response);
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
		
		 
	}
		 
		
		
		
	

}
