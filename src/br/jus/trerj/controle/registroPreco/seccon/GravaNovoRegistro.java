package br.jus.trerj.controle.registroPreco.seccon;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
import br.jus.trerj.funcoes.CadastroReferencia;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;



public class GravaNovoRegistro extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String descricao = "";
		String fornecedor = "";
		int vidArea = 0;
				
		String vretorno = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vidArquivoPrincipal = "";
		String nomeArquivo = "";
		String arquivoObjeto = "";
		String dataPublicacao = "";
		String dataVigenciaInicial = "";
		String dataVigenciaFinal = "";
		String numAta = "";
		
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
			
			Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString()));
			vidArea = parametros.getVidAreaRegistroPrecosSeccon();
			int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
			int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
			
			vidArquivoPrincipal = multiparts.get(0).getString();			
			numAta = multiparts.get(3).getString() + "/" + multiparts.get(4).getString();
			dataPublicacao = multiparts.get(5).getString();
			dataVigenciaInicial = multiparts.get(6).getString();
			dataVigenciaFinal = multiparts.get(7).getString();
			fornecedor = multiparts.get(8).getString();
			descricao = multiparts.get(9).getString();
			nomeArquivo = multiparts.get(10).getName();
			PrintWriter out = response.getWriter();

			//if (multiparts.get(10).getContentType().lastIndexOf("pdf")>-1)
			//{
		        
		        //upload no objeto
				String extensao = "";
				extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".")+1, nomeArquivo.length());
				arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + " - " + request.getSession().getAttribute("login") + "." + extensao;
				if (arquivoObjeto.lastIndexOf("\\") > -1)
				{
					arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
				}
				try {
					// fazendo o upload do arquivo
					multiparts.get(10).write(new File(diretorio + arquivoObjeto));
						
					//Gravar Ata no banco
					try {			
						Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
						conexao.setAutoCommit(false);
						/*String vsql = "SELECT LPad(gecoi.sq_ata_registro_preco.NEXTVAL, 3, '0') AS proximo, To_Char(SYSDATE, 'yyyy') AS ano FROM dual";
						PreparedStatement pstm = conexao.prepareStatement(vsql);
						ResultSet rs = pstm.executeQuery();
						rs.next();
						numAta = rs.getString("proximo") + "/" + rs.getString("ano");*/
						descricao = "Ata de Registro de Preços nº " + numAta + " - " + fornecedor + "-" + descricao;
						vretorno = incluir.incluir(descricao, diretorio, arquivoObjeto, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, dataVigenciaInicial + " a " + dataVigenciaFinal, 0);
						vidArquivo = vretorno.substring(vretorno.lastIndexOf("#")+1);
						vidConteudo = vretorno.substring(vretorno.indexOf("#")+1);
						
						CadastroReferencia incluirReferencia = new CadastroReferencia();
						incluirReferencia.incluir(Integer.parseInt(vidArquivoPrincipal), Integer.parseInt(vidArquivo), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), 0);
						
						if ((!dataVigenciaInicial.equals("")) && (vretorno.indexOf("Erro") < 0))
							vretorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeInicial, dataVigenciaInicial, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
						if ((!dataVigenciaFinal.equals("")) && (vretorno.indexOf("Erro") < 0))
							vretorno = incluir.incluirCampoAdicional(vidArquivo, vidValidadeFinal, dataVigenciaFinal, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
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
				
				//out.print("<script>parent.atualizaTela('" + numAta + "');</script>");
				out.print("<script>parent.atualizaTela();</script>");
			/*}
			else
			{
				out.print("<script>alert('O ARQUIVO deve ser PDF!')</script>");
			}*/
		}		
	}
}
