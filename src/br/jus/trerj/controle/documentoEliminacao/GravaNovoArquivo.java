package br.jus.trerj.controle.documentoEliminacao;

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

		//Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));

		int vidArea = 2658;
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vretorno = "";
		String nomeArquivo = "";
		String arquivoObjeto = "";
		String unidade ="";
		String edital = "";
		int ultimo = 4;
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String diretorio = getServletContext().getRealPath("/") + "webtemp\\";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		
		//Obter a data atual e converter para string, pois no m�todo incluir a data obrigatoriamente deve ser do tipo String
		Date data = new Date(System.currentTimeMillis());  
		SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
		String dataPublicacao = formatarDate.format(data);

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

			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));

			int totalAnexo = multiparts.size();
			
			
			unidade = ((FileItem)multiparts.get(0)).getString();
			edital = ((FileItem)multiparts.get(1)).getString();
			dataPublicacao = ((FileItem)multiparts.get(2)).getString();
			vdescricao = ((FileItem)multiparts.get(3)).getString();
			nomeArquivo = ((FileItem)multiparts.get(4)).getName();

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
				multiparts.get(4).write(new File(diretorio + arquivoObjeto));
				
				FileItem arquivo = multiparts.get(4);
				//Verifica se o arquivo � uma imagem para proceder o c�lculo do percentual de redu��o
				if (arquivo.getContentType().lastIndexOf("image")>-1)
				{
					ReduzirImagem redu = new ReduzirImagem();
					redu.ReduzImagem(arquivo, diretorio, arquivoObjeto);
				}

				//Gravar arquivo no banco
				try {
					Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					conexao.setAutoCommit(false);

					vretorno = incluir.incluir(vdescricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, unidade+","+edital, 0);
					System.out.println("Retorno 1: " + vretorno);
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#") + 1, vretorno.lastIndexOf("#"));
					
					//Se for imagem � verificado se precisa reduzir
					if (arquivo.getContentType().lastIndexOf("image")>-1)
						vretorno = incluir.incluirImagemReduzida(vidArquivo, diretorio, "redu" + arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());

					
					for(int i=1; i<= totalAnexo; i++){
					
						vdescricao = ((FileItem)multiparts.get(++ultimo)).getString();
						nomeArquivo = ((FileItem)multiparts.get(++ultimo)).getName();
						
						//upload no anexo
						extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1, nomeArquivo.length());
						arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
						if (arquivoObjeto.lastIndexOf("\\") > -1)
						{
							arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
						}

						// fazendo o upload do arquivo
						multiparts.get(ultimo).write(new File(diretorio + arquivoObjeto));
						
						arquivo = multiparts.get(ultimo);
						//Verifica se o arquivo � uma imagem para proceder o c�lculo do percentual de redu��o
						if (arquivo.getContentType().lastIndexOf("image")>-1)
						{
							ReduzirImagem redu = new ReduzirImagem();
							redu.ReduzImagem(arquivo, diretorio, arquivoObjeto);
						}
						
						vretorno = incluir.incluirAnexo(vidConteudo, vdescricao, diretorio, arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), i, 0, unidade+","+edital);
						vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
						
						if (arquivo.getContentType().lastIndexOf("image")>-1)
							vretorno = incluir.incluirImagemReduzida(vidArquivo, diretorio, "redu" + arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					
					}
					
					
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


			pw.print("<script>top.carregaAPP('/gecoi.3.0/apps/documentos_eliminacao/index.jsp','');</script>");
		}		
	}
}
