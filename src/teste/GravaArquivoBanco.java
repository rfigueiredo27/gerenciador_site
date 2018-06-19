package teste;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItem;

import oracle.jdbc.OracleTypes;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.modelo.Parametros;

public class GravaArquivoBanco extends HttpServlet {

	private static final long serialVersionUID = 1L;
	//private final String UPLOAD_DIRECTORY = "C:/Files/";

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Connection conexao = null;
		Parametros parametros = new Parametros();
		//PrintWriter out = response.getWriter();
		String retorno = "";
		try {
			//conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), "internauta", "internauta");
     		try 
    		{
			String vsql = "{call gecoi.g_proc_inc_arq_cont_exist(?, ?, ?, ?, ?, ?, ?, ?, ?)";
 			
 			CallableStatement cs;
 			cs = conexao.prepareCall(vsql);

			// retorno
			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
			// variáveis da alteração do conteúdo
			cs.setString(2,"77584"); //id do conteudo
			cs.setString(3,"teste de progress Bar"); //descricao
			cs.setString(4,""); //observacao
			cs.setString(5,"gdebossa"); //usuario

			// variáveis da inclusão de arquivo
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
			String nomeArquivo = items.get(0).getName();
			FileItem arquivoUp = items.get(0);
			//arquivoUp.write(new File(diretorio + nomeArquivo));
			File arquivo = new File(diretorio + nomeArquivo);
			//File arquivo = new File(nomeArquivo);
			//FileInputStream fis = new FileInputStream(arquivo);
			//cs.setBinaryStream(6, fis, (int)arquivo.length());
			cs.setBinaryStream(6,arquivoUp.getInputStream(), (int) arquivoUp.getSize()); //arquivo
			cs.setString(7,nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1));//extensao
			cs.setInt(8,5); //ordem
			cs.setInt(9,2);//publicado

			cs.execute();
	    			
			retorno = cs.getString(1);
 			conexao.commit();
 			conexao.close();
 			System.out.println(retorno); 			 			
    		} 
    		catch (Exception e) 
    		{
    			e.printStackTrace();
    			try {
					conexao.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					//e1.printStackTrace();
					//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e.getMessage() + "');</script>");
				}
    		} 
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			//e2.printStackTrace();
			//out.print("<script>top.atualizaMSG('OCORREU UM ERRO: " + e2.getMessage() + "');</script>");
		}
	}
    	
}
