package br.jus.trerj.controle.contrato;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.CadastroReferencia;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;



public class GravaNovoContrato extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String numProcesso = "";
		
		String numContrato = "";
		String anoContrato = "";
		String vigenciaIni = "";
		String vigenciaFim = "";
		String descContrato = "";
		String dataPublicacao = "";		
		String vidArquivoPrincipal = "";
		String vidArquivo = "";
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		int vidArea = parametros.getVidAreaContrato();
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		
		String vretorno = "";
		String vdescricao = "";
		String vobservacao = "";
		String vidConteudo = "";
		String nomeArquivo = "";
		String arquivoContrato = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		// 
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
			
			vidArquivoPrincipal = multiparts.get(0).getString();
			numProcesso = multiparts.get(1).getString();
			descContrato = multiparts.get(2).getString();
			numContrato = multiparts.get(3).getString();
			anoContrato = multiparts.get(4).getString();
			dataPublicacao = multiparts.get(5).getString();
			vigenciaIni = multiparts.get(6).getString();
			vigenciaFim = multiparts.get(7).getString();
			nomeArquivo = multiparts.get(8).getName();
			
			//upload no contrato
			String extensao = "";
			extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
			arquivoContrato = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
			if (arquivoContrato.lastIndexOf("\\") > -1)
			{
				arquivoContrato = arquivoContrato.substring(arquivoContrato.lastIndexOf("\\")+1);
			}
				
			try {
				// fazendo o upload do arquivo
				multiparts.get(8).write(new File(diretorio + arquivoContrato));
					
				//Gravar contrato no banco
				try {
					//vdescricao = numProcesso + "-" + numContrato + "/" + anoContrato + "-" + descContrato;
					vdescricao = numContrato + "/" + anoContrato + "-" + numProcesso + "-";
					//vobservacao = vigenciaIni + " a " + vigenciaFim;
					vretorno = incluir.incluir(vdescricao, diretorio, arquivoContrato, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, vobservacao, 0);
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#")+1);
					
					CadastroReferencia incluirReferencia = new CadastroReferencia();
					incluirReferencia.incluir(Integer.parseInt(vidArquivoPrincipal), Integer.parseInt(vidArquivo), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 0);

					if ((!vigenciaIni.equals("")) && (vretorno.indexOf("Erro") < 0))
						vretorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeInicial, vigenciaIni, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					if ((!vigenciaFim.equals("")) && (vretorno.indexOf("Erro") < 0))
						vretorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeFinal, vigenciaFim, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					
														
				}
				catch(Exception ex){
					System.out.println("grava arquivo no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
				}
					
				
				try{
					File apagar = new File(diretorio + arquivoContrato); 
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
			out.print("<script>parent.atualizaTela();</script>");
		}		
	}
}
