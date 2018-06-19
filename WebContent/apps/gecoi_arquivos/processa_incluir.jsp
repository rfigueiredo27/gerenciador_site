<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.File"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="br.jus.trerj.controle.gecoiArquivos.ReduzirImagem"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="be.telio.mediastore.ui.upload.UploadListener"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="br.jus.trerj.funcoes.IncluirGecoiArquivo"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%

		int vidArea = 0;
		String vdescricao = "";
		String vidConteudo = "";
		String vidArquivo = "";
		String vretorno = "";
		String nomeArquivo = "";
		String obs="";
		String descricao_conteudo = "";
		String vtexto = "";
		int ultimo = 5;
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String vdiretorio = application.getRealPath("/") + "webtemp\\";
		String vusuario = session.getAttribute("login").toString();
		String vsenha = session.getAttribute("senha").toString();
		String vnomeArquivo = "gecoi_arquivo-" + vusuario + ".htm";
		IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
		
		//salvando a prestação em arquivo htm
		Calendar c = Calendar.getInstance();
		SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
		String vagora = ft.format(c.getTime());
		
		//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
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

			int totalAnexo = (multiparts.size() - ultimo - 1) / 2;
			//System.out.println(totalAnexo);

			
			vidArea = Integer.parseInt(((FileItem)multiparts.get(0)).getString());
			dataPublicacao = ((FileItem)multiparts.get(1)).getString();
			descricao_conteudo = URLDecoder.decode(multiparts.get(2).getString(), "UTF-8");
			obs = URLDecoder.decode(multiparts.get(3).getString(), "UTF-8");
			vdescricao = URLDecoder.decode(multiparts.get(4).getString(), "UTF-8");
			vtexto = multiparts.get(5).getString();
			vtexto = new String (vtexto.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

			PrintWriter pw = response.getWriter();

			//criando o htm
			try
			{
				byte[] contentInBytes = vtexto.getBytes();
				File file = new File(vdiretorio + vnomeArquivo);
				FileOutputStream fop = new FileOutputStream(file);
				fop.write(contentInBytes);
				fop.flush();
				fop.close();
			} 
			catch (Exception e) 
			{
				out.print(e.getMessage());
			}
			
			//Gravar arquivo no banco
			try {
					Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					conexao.setAutoCommit(false);

					vretorno = incluir.incluir(vdescricao, vdiretorio, vnomeArquivo, vidArea, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), dataPublicacao, "", 0, obs, 0);
					
					vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
					vidConteudo = vretorno.substring(vretorno.indexOf("#") + 1, vretorno.lastIndexOf("#"));
					
					//System.out.println(descricao_conteudo);
					if(!descricao_conteudo.equals("")){
						//System.out.println("Passou aqui: "+ descricao_conteudo);
						vretorno = incluir.incluirDescCont(descricao_conteudo, vidConteudo, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					}
					
					for(int i=1; i <= totalAnexo; i++){
					
						String vdescricao2 = ((FileItem)multiparts.get(++ultimo)).getString();
						nomeArquivo = ((FileItem)multiparts.get(++ultimo)).getName();
						
						//upload no anexo
						String extensao = nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1, nomeArquivo.length());
						String arquivoObjeto = nomeArquivo.substring(0, nomeArquivo.lastIndexOf(".")) + "-" + request.getSession().getAttribute("login") + "." + extensao;
						if (arquivoObjeto.lastIndexOf("\\") > -1)
						{
							arquivoObjeto = arquivoObjeto.substring(arquivoObjeto.lastIndexOf("\\")+1);
						}

						// fazendo o upload do arquivo
						multiparts.get(ultimo).write(new File(vdiretorio + arquivoObjeto));
						
						FileItem arquivo = multiparts.get(ultimo);
						//Verifica se o arquivo é uma imagem para proceder o cálculo do percentual de redução
						if (arquivo.getContentType().lastIndexOf("image")>-1)
						{
							ReduzirImagem redu = new ReduzirImagem();
							redu.ReduzImagem(arquivo, vdiretorio, arquivoObjeto);
						}
						
						vretorno = incluir.incluirAnexo(vidConteudo, vdescricao2, vdiretorio, arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString(), i, 0, obs);
						vidArquivo = vretorno.substring(vretorno.lastIndexOf("#") + 1);
						
						if (arquivo.getContentType().lastIndexOf("image")>-1)
							vretorno = incluir.incluirImagemReduzida(vidArquivo, vdiretorio, "redu" + arquivoObjeto, request.getSession().getAttribute("login").toString(), request.getSession().getAttribute("senha").toString());
					
						
					}
					
					
					conexao.commit();

				}
				catch(Exception ex){
					vretorno = "3"+ex.getMessage();
					System.out.println("grava arquivo no GECOI: " + ex.getMessage());
					request.getSession().setAttribute("erro", "Erro na gravacao do arquivo no GECOI: " + ex.getMessage());
				}


				request.getSession().setAttribute("erro", "");					
			


			pw.print("<script>top.carregaAPP('/gecoi.3.0/apps/gecoi_arquivos/index.jsp','');</script>");
		}		
 %>