package br.jus.trerj.controle.licitacao;

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
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;



public class GravaNovaLicitacao extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String numProcesso = "";
		String anoProcesso = "";
		String numPregao = "";
		String anoPregao = "";
		String objeto = "";
		String dataAbertura = "";
		String dataFechamento = "";
		String dataPublicacao = "";
		String tipo = "";
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
		int vidDataPublicacao = parametros.getVidDataPublicacao();
		int vidArea = 0;
				
		String vdescricao = "";
		String vobservacao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vretorno = "";
		String nomeArquivo = "";
		String arquivoObjeto = "";
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
			tipo = multiparts.get(0).getString();
			numPregao = multiparts.get(1).getString();
			anoPregao = multiparts.get(2).getString();
			numProcesso = multiparts.get(3).getString();
			anoProcesso = multiparts.get(4).getString();
			dataAbertura = multiparts.get(5).getString();
			//dataFechamento = multiparts.get(6).getString();
			dataPublicacao = multiparts.get(6).getString();
			objeto = multiparts.get(7).getString();
			nomeArquivo = multiparts.get(8).getName();
			
			if (tipo.equals("PE"))
				vidArea = parametros.getVidAreaLicitacaoPregaoEletronico();
			if (tipo.equals("PERP"))
				vidArea = parametros.getVidAreaLicitacaoPregaoEletronicoRegistroPreco();
			if (tipo.equals("PP"))
				vidArea = parametros.getVidAreaLicitacaoPregaoPresencial();
			if (tipo.equals("PPRP"))
				vidArea = parametros.getVidAreaLicitacaoPregaoPresencialRegistroPreco();
			if (tipo.equals("CO")) 
				vidArea = parametros.getVidAreaLicitacaoConvite();
			if (tipo.equals("TP")) 
				vidArea = parametros.getVidAreaLicitacaoTomadaPreco();
			if (tipo.equals("CP")) 
				vidArea = parametros.getVidAreaLicitacaoConcorrenciaPublica();
			
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
				multiparts.get(8).write(new File(diretorio + arquivoObjeto));
					
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
			out.print("<script>top.carregaAPP('/gecoi.3.0/apps/licitacao/index.jsp','');</script>");
		}		
	}
}
