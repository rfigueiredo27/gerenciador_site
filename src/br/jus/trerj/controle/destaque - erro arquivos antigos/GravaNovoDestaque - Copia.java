package br.jus.trerj.controle.destaque;

/*
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
*/
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;



public class GravaNovoDestaque extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("11");
		/*String vdescricao = "";
		System.out.println("00");
		String vlink = "";
		String vidConteudo = "";
		String vdataIni = "";
		String vdataFim = "";
		int vpublicado = 1;
		String objeto = "";
		String vsql = "";
		Connection conexao = null;
		//int vidArea = 60;
		//vidArea = 1622;  //teste
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		
		
		int vidArea = parametros.getVidAreaDestaque();
		System.out.println("000");
		String nomeArquivo = "";
		String vnomeAnexo = "";
		String arquivoAnexo = "";
		String vdescricaoAnexo = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		// 
		// process only if its multipart content
		if (isMultipart) {
			// Pegando os dados do formulario
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> multiparts = null;
			try {
				multiparts = upload.parseRequest(request);
			} catch (FileUploadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			vdescricao = multiparts.get(0).getString();
			vlink = multiparts.get(1).getString();
			vdescricaoAnexo = multiparts.get(2).getString();
			vnomeAnexo = multiparts.get(3).getName();
			vdataIni = multiparts.get(4).getString();
			vdataFim = multiparts.get(5).getString();
			vpublicado = Integer.parseInt(multiparts.get(6).getString());
			objeto = multiparts.get(7).getString();
			nomeArquivo = multiparts.get(7).getName();
			System.out.println("11");
			//upload no objeto
			String extensao = "";
			extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
			arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
			if (arquivoObjeto.lastIndexOf("\\") > -1)
			{
				arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
			}

			try {
				// fazendo o upload do arquivo
				multiparts.get(7).write(new File(diretorio + arquivoObjeto));
					
				//Gravar licitacao no banco
				try {
					vdescricao = tipo + "-" + numPregao + "/" + anoPregao + "-" + numProcesso + "/" + anoProcesso + "-" + objeto;
					vobservacao = "";
					vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataAbertura, dataFechamento, 0, vobservacao, 0);
					//vidConteudo = vidConteudo.substring(vidConteudo.lastIndexOf("#")+1);
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#")+1,vretorno.lastIndexOf("#"));

					if ((!dataPublicacao.equals("")) && (vretorno.indexOf("Erro") < 0))
						vretorno = incluir.incluirCampoAdicional(vidArquivo, vidDataPublicacao, dataPublicacao, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
				}
				catch(Exception ex){
					System.out.println("grava arquivo no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
				}
					
				
				try{
					File apagar = new File(diretorio + arquivoObjeto); 
					apagar.delete();
				}
				catch (Exception e)
				{
					System.out.println("Erro ao apagar: " + e.getMessage());
					request.getSession().setAttribute("erro", "Erro ao apagar: " + e.getMessage());						
				}
					
				request.getSession().setAttribute("erro", "");					
			} 
			catch (Exception e) 
			{
				System.out.println("File upload failed: " + e.getMessage());
				request.getSession().setAttribute("erro", "Erro no Upload: " + e.getMessage());
			}
			
			PrintWriter out = response.getWriter();
			out.print("<script>top.carregaAPP('/gecoi.3.0/apps/destaques_intranet/index.jsp','');</script>");
		}*/		
	}
}
