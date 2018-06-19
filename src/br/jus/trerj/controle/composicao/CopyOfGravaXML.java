package br.jus.trerj.controle.composicao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import br.jus.trerj.modelo.Componente;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class CopyOfGravaXML extends HttpServlet implements Servlet{

	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)        	throws ServletException, IOException {
	//protected void service(HttpServletRequest request, HttpServletResponse response)        	throws ServletException, IOException {
			Connection conexao = null;
			Parametros parametros = new Parametros();
 			PrintWriter out = response.getWriter();

			
			try {
				//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), parametros.getUsuario(), parametros.getSenha());
				conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				//conexao = new ConnectionFactory().getConnection("jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm", "internauta", "internauta");
				
	     		try 
	    		{
	    			int contador = 17;
	    			List<Componente> listaComponentes = new ArrayList<Componente>();
	    			Componente componente = null;
	    			for (int i = 1; i <= contador; i++)
	    			{
	    				componente = new Componente();
	    				componente.setId(request.getParameter("curriculo" + i));
	    				componente.setClasse(request.getParameter("classe" + i));
	    				componente.setTipo(request.getParameter("tipo" + i));
	    				componente.setCargo(request.getParameter("cargo" + i));
	    				componente.setNome(request.getParameter("nome" + i));
	    				componente.setMandatoInicial(request.getParameter("mandatoInicial" + i));
	    				componente.setMandatoFinal(request.getParameter("mandatoFinal" + i));
	    				componente.setBienio(request.getParameter("bienio" + i));
	    				componente.setObs(request.getParameter("obs" + i));
	    				listaComponentes.add(componente);
	    			}
	    			
	    			XStream stream = new XStream(new DomDriver());
	    			stream.alias("componentes", List.class);
	    			stream.alias("componente", Componente.class);
	    			
	    			File arquivo = new File(parametros.getLocalXML());
	    			FileWriter arquivoXML = new FileWriter(arquivo);
	    			stream.toXML(listaComponentes, arquivoXML);

	    			String vsql = "Select gecoi.sq_conteudo.NEXTVAL as proximo from dual";
	    			PreparedStatement pstm = conexao.prepareStatement(vsql);    		    
	    			ResultSet rs = pstm.executeQuery();
	    			rs.next();
	    			int vidConteudo = rs.getInt("proximo");
	    			/*
	    			//String vlogon_usuario_criacao = request.getParameter("logon_usuario_criacao");
	    		    vsql = "INSERT INTO gecoi.conteudo(id_conteudo, descricao, observacao, data_criacao, data_ult_alteracao, logon_usuario_criacao, logon_usuario_ult_alteracao) " +
	    		     	   "VALUES (?, 'Composição da Corte', null, sysdate, sysdate, ?, ?)";
	    			pstm = conexao.prepareStatement(vsql);
	    		    pstm.setInt(1,vidConteudo);
	    		    //pstm.setString(2,vlogon_usuario_criacao);
	    		    //pstm.setString(3,vlogon_usuario_criacao);
	    		    pstm.setString(2,request.getSession().getAttribute("login").toString());
	    		    pstm.setString(3,request.getSession().getAttribute("login").toString());
	    			pstm.executeQuery();
	    			
	    		    vsql = "INSERT INTO gecoi.conteudo_area(id_conteudo, id_area, data_inicio_exib, data_fim_exib) VALUES (?, ?, Sysdate, Sysdate+365) ";
	     			pstm = conexao.prepareStatement(vsql);
	     		    pstm.setInt(1,vidConteudo);
	     		    //pstm.setInt(2,1622);
	     		    pstm.setInt(2,73);
	     			pstm.executeQuery();
	     			
	    			vsql = "Select gecoi.sq_arquivo.NEXTVAL as proximo from dual";
	    			pstm = conexao.prepareStatement(vsql);    		    

	    			rs = pstm.executeQuery();
	    			rs.next();
	    			int vidArquivo = rs.getInt("proximo");


	    			FileInputStream fis = new FileInputStream(arquivo);
	    		    vsql = "INSERT INTO gecoi.arquivo(id_arquivo, id_conteudo, descricao, arquivo, nome, arquivo_reduzido, data_inclusao, nome_arquivo_reduzido, ordem) " +
	    		    		"VALUES ( ?, ?, 'Composição da Corte', ?, 'arq_' || To_Char( ?,'000000') || '.xml', empty_blob(), SYSDATE, null, 0)";
	     			pstm = conexao.prepareStatement(vsql);
	     		    pstm.setInt(1,vidArquivo);
	     		    pstm.setInt(2,vidConteudo);
	     		    pstm.setBinaryStream(3, fis, (int)arquivo.length());     		   
	     		    pstm.setInt(4,vidArquivo);     		   
	     			pstm.executeQuery();
	     				*/     			
	     			rs.close();
	     			rs = null;
	     			conexao.commit();
	     			conexao.close();
	     			
	     			//if (!parametros.getCaminho().equals(""))
	     				//response.sendRedirect(parametros.getCaminho() + "grava_componente.jsp");
	     			out.print("<script>top.atualizaMSG('Informações atualizadas com sucesso.');</script>");
	     			//out.print(parametros.getCaminho() + "grava_componente.jsp");
	     			//else
	     				//response.sendRedirect("/grava_componente.jsp");
	    			
	    		} 
	    		catch (Exception e) 
	    		{
	    			e.printStackTrace();
	    			try {
						conexao.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						//e1.printStackTrace();
						out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
					}
	    		} 
			} catch (ClassNotFoundException e2) {
				// TODO Auto-generated catch block
				//e2.printStackTrace();
				out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
			}

    	}       
}
