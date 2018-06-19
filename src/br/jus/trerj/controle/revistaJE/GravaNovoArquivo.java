package br.jus.trerj.controle.revistaJE;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory;
import be.telio.mediastore.ui.upload.UploadListener;
import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;

import java.util.Date;



public class GravaNovoArquivo extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public GravaNovoArquivo() {}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		int vidArea = 74;
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vretorno = "";
		String nomeArquivo = "";
		String arquivoObjeto = "";
		String volume ="";
		String numero = "";
		String mes_inicio = "";
		String mes_fim = "";
		String ano_inicial = "";
		String ano_final = "";
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		
		//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
		Date data = new Date(System.currentTimeMillis());  
		SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
		String dataPublicacao = formatarDate.format(data);

		// process only if its multipart content
		if (isMultipart) {
			//Listener para a barra de progresso
			UploadListener listener = new UploadListener(request, 30);
			// Create a factory for disk-based file items
			FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> multiparts = null;
			try {
				multiparts = upload.parseRequest(request);
			} catch (FileUploadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));

			int totalAnexo = multiparts.size();
			
			volume = ((FileItem)multiparts.get(0)).getString();
			numero = ((FileItem)multiparts.get(1)).getString();
			mes_inicio = ((FileItem)multiparts.get(2)).getString();
			ano_inicial = ((FileItem)multiparts.get(3)).getString();
			mes_fim = ((FileItem)multiparts.get(4)).getString();
			ano_final = ((FileItem)multiparts.get(5)).getString();
			nomeArquivo = ((FileItem)multiparts.get(6)).getName();
						
			if(ano_inicial.equals(ano_final))
			{
				vdescricao = "Revista Jusciça Eleitoral em Debate - Volume "+volume+" - Número "+numero+" - "+mes_inicio+" a "+mes_fim+" de "+ano_final;
			}	
			else
			{
				vdescricao = "Revista Jusciça Eleitoral em Debate - Volume "+volume+" - Número "+numero+" - "+mes_inicio+" de " +ano_inicial+" a "+mes_fim+" de "+ano_final;
			}
			
			
			PrintWriter pw = response.getWriter();

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
				multiparts.get(6).write(new File(diretorio + arquivoObjeto));
				
				//Gravar arquivo no banco
				try {
					Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					conexao.setAutoCommit(false);

					vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, "", 0);
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#") + 1, vretorno.lastIndexOf("#"));
					
					conexao.commit();

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


			pw.print("<script>top.carregaAPP('/gecoi.3.0/apps/revista_je/index.jsp','');</script>");
		}		
	}
}
