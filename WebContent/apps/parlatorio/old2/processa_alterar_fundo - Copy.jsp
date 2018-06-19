<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.* ,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.AlterarGecoiArquivo" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);
String vid_arquivo = "";
int vedicao = Integer.parseInt(multiparts.get(0).getString());  // vou guardar no campo publicado
String vsecao = multiparts.get(1).getString();  // vou guardar em observação
String vdata = multiparts.get(2).getString();
String vtitulo = multiparts.get(3).getString();
String vresumo = multiparts.get(4).getString();
String varquivoImagem = multiparts.get(5).getName();
String vtexto = multiparts.get(6).getString();
// o multiparts.get(7).getString(); é um input do tipo file escondido
String vidArquivoHTML = multiparts.get(8).getString();
String vidArquivoImagem = multiparts.get(9).getString();
String vidConteudo = multiparts.get(10).getString();

String vextensao = "";
String vnomeArquivoImagem = "";
int vidArea = 2620;
String vretorno = "";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vnomeArquivoHTML = "reportagem-" + vusuario + ".htm";
AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();

Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());

try
{
	if (!varquivoImagem.equals(""))
	{
		// fazendo o upload do arquivo
		vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
		vnomeArquivoImagem = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivoImagem.lastIndexOf("\\") > -1)
		{
			vnomeArquivoImagem = vnomeArquivoImagem.substring(vnomeArquivoImagem.lastIndexOf("\\")+1);
		}
		multiparts.get(5).write(new File(vdiretorio + vnomeArquivoImagem));
	}

	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, ?, " + //alteracao do conteudo 
				//"?, null, to_date(?,'dd/mm/yyyy hh24:mi'), to_date(?,'dd/mm/yyyy'), " + //alteracao do conteudo_area
				//"?, null, ?, ?, " + //alteracao do conteudo_area
				"?, null, ?, null, " + //alteracao do conteudo_area
				"?, ?, null, ?)"; //alteracao do arquivo
 			
	CallableStatement cs;
	cs = con.prepareCall(vsql);

	// alterando o html
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
	// variáveis da alteração de conteudo
	cs.setString(2,vtitulo + "@@" + vresumo); //descricao
	cs.setString(3,vusuario); //usuario
	cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
	cs.setString(5,vsecao); //observacao

	// variáveis da alteração de conteudo_area
	cs.setInt(6,vidArea); //idArea
	cs.setString(7,vdata); //data_inicio_exib
	//cs.setString(7,vdataFechamento); //data_fim_exib
     			
	// variáveis da alteração de arquivo
	cs.setInt(8,Integer.parseInt(vidArquivoHTML)); //idArquivo
	cs.setString(9,vtitulo + "@@" + vresumo); //descricao
	cs.setInt(10,vedicao); // publicado

	cs.execute();
	vretorno = cs.getString(1);
	if (vretorno.indexOf("Err") == -1)
	{
		//gravando o arquivo html de novo. 
		// Não tá funcionando o salvar_tinymce.jsp via post
		try
		{
			byte[] contentInBytes = vtexto.getBytes();
			File file = new File(vdiretorio + vnomeArquivoHTML);
			FileOutputStream fop = new FileOutputStream(file);
			fop.write(contentInBytes);
			fop.flush();
			fop.close();
		} 
		catch (Exception e) 
		{
			out.print(e.getMessage());
		}
		//substituirArquivo(String idConteudo, String idArquivo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha)
		vretorno = alterar.substituirArquivo(vidConteudo, vidArquivoHTML, vtitulo + "@@" + vresumo, vdiretorio, vnomeArquivoHTML, vusuario, vsenha);

		if (vretorno.indexOf("Err") == -1)
		{
			//Alterando a imagem
			vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, ?, " + //alteracao do conteudo 
						//"?, null, to_date(?,'dd/mm/yyyy hh24:mi'), to_date(?,'dd/mm/yyyy'), " + //alteracao do conteudo_area
						//"?, null, ?, ?, " + //alteracao do conteudo_area
						"?, null, ?, null, " + //alteracao do conteudo_area
						"?, ?, null, ?)"; //alteracao do arquivo
						
			cs = con.prepareCall(vsql);
				
			// retorno
			cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
								
			// variáveis da alteração de conteudo
			cs.setString(2,vtitulo + "@@" + vresumo); //descricao
			cs.setString(3,vusuario); //usuario
			cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
			cs.setString(5,vsecao); //observacao
			
			// variáveis da alteração de conteudo_area
			cs.setInt(6,vidArea); //idArea
			cs.setString(7,vdata); //data_inicio_exib
			//cs.setString(8,vdataFechamento); //data_fim_exib
							
			// variáveis da alteração de arquivo
			cs.setInt(8,Integer.parseInt(vidArquivoImagem)); //idArquivo
			cs.setString(9,vtitulo + "@@" + vresumo); // descricao
			cs.setInt(10,vedicao); // publicado
	
			cs.execute();
								
			vretorno = cs.getString(1);
				
			if (vretorno.indexOf("Err") == -1)
			{
				if (!varquivoImagem.equals(""))
				{
					//substituirArquivo(String idConteudo, String idArquivo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha)
					vretorno = alterar.substituirArquivo(vidConteudo, vidArquivoImagem, vtitulo + "@@" + vresumo, vdiretorio, vnomeArquivoImagem, vusuario, vsenha);
	
					if (vretorno.indexOf("Err") == -1)
					{
					}
					else
					{
						out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
					}
				}
			}
			else
			{
				out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
			}
		}
		else
		{
			out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
		}
	}
	else
	{
		out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
	}
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if (vretorno.indexOf("Err") == -1)
	{
		con.commit();
		out.print("<script>top.atualizaTela();</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>