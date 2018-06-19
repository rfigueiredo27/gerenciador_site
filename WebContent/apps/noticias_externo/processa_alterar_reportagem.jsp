<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.* ,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.AlterarGecoiArquivo,br.jus.trerj.funcoes.IncluirGecoiArquivo, br.jus.trerj.funcoes.UltimasNoticiasComImagem, br.jus.trerj.funcoes.UltimasNoticiasSemImagem, br.jus.trerj.funcoes.UltimasNoticiasInternet" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("ISO-8859-1");
UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);

/*out.print("<br>0="+multiparts.get(0).getFieldName());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getFieldName());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getFieldName());
out.print("<br>3="+multiparts.get(3).getFieldName());
out.print("<br>4="+multiparts.get(4).getFieldName());
out.print("<br>5="+multiparts.get(5).getFieldName());
out.print("<br>6="+multiparts.get(6).getFieldName());
out.print("<br>7="+multiparts.get(7).getFieldName());
out.print("<br>8="+multiparts.get(8).getFieldName());
out.print("<br>9="+multiparts.get(9).getFieldName());
out.print("<br>10="+multiparts.get(10).getFieldName());
out.print("<br>11="+multiparts.get(11).getFieldName());
out.print("<br>5="+multiparts.get(5).getString());
/*out.print("<br>0="+multiparts.get(0).getString());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getString());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getString());
out.print("<br>3="+multiparts.get(3).getString());
out.print("<br>4="+multiparts.get(4).getString());
out.print("<br>5="+multiparts.get(5).getName());
out.print("<br>6="+multiparts.get(6).getString());
out.print("<br>7="+multiparts.get(7).getString());
out.print("<br>8="+multiparts.get(8).getString());
out.print("<br>9="+multiparts.get(9).getString());
out.print("<br>10="+multiparts.get(10).getString());
out.print("<br>11="+multiparts.get(11).getString());
*/

int vidArea = Integer.parseInt(multiparts.get(0).getString());
String vdata = multiparts.get(1).getString();
String vtitulo = multiparts.get(2).getString();
String varquivoImagem = multiparts.get(3).getName();

// o multiparts.get(4).getString(); é um input do tipo file escondido  ??????????????
String vtexto = multiparts.get(5).getString();
// o multiparts.get(6).getString(); é um input do tipo file escondido
String vidArquivo = multiparts.get(7).getString();// id do arquivo html ou video
String vidArquivoImagem = multiparts.get(8).getString();
String vidConteudo = multiparts.get(9).getString();
boolean vArquivoImagemNovo = multiparts.get(10).getString().equals("-");
String vano = multiparts.get(11).getString();

String vextensao = "";
String vnomeArquivoImagem = "";
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
	// se troquei o arquivo de imagem da capa
	if (!varquivoImagem.equals(""))
	{
		// fazendo o upload do arquivo
		vextensao = varquivoImagem.substring(varquivoImagem.lastIndexOf(".")+1, varquivoImagem.length());
		vnomeArquivoImagem = varquivoImagem.substring(0, varquivoImagem.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivoImagem.lastIndexOf("\\") > -1)
		{
			vnomeArquivoImagem = vnomeArquivoImagem.substring(vnomeArquivoImagem.lastIndexOf("\\")+1);
		}
		multiparts.get(3).write(new File(vdiretorio + vnomeArquivoImagem));
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

	// alterando o html ou  video
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	    			
	// variáveis da alteração de conteudo
	cs.setString(2,vtitulo); //descricao
	cs.setString(3,vusuario); //usuario
	cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
	cs.setString(5,""); //observacao

	// variáveis da alteração de conteudo_area
	cs.setInt(6,vidArea); //idArea
	cs.setString(7,vdata); //data_inicio_exib
	//cs.setString(7,vdataFechamento); //data_fim_exib
     			
	// variáveis da alteração de arquivo
	
	cs.setInt(8,Integer.parseInt(vidArquivo)); //idArquivo html ou video	
	cs.setString(9,vtitulo); //descricao
	cs.setInt(10,9); // publicado
	cs.execute();
	vretorno = cs.getString(1);
	if (vretorno.indexOf("Err") == -1)
	{
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
		vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vtitulo, vdiretorio, vnomeArquivoHTML, vusuario, vsenha);

		
		if ( (vretorno.indexOf("Err") == -1) && (!varquivoImagem.equals("")) )
		{
			if (vArquivoImagemNovo)
			{
				IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
				vretorno = incluir.incluir(vidConteudo, vtitulo, vdiretorio, vnomeArquivoImagem, vusuario, vsenha, 1, 9, "");
			}
			else
			{
				//substituirArquivo(String idConteudo, String idArquivo, String descricao, String diretorio, String nomeArquivo, String vusuario, String vsenha)
				vretorno = alterar.substituirArquivo(vidConteudo, vidArquivoImagem, vtitulo, vdiretorio, vnomeArquivoImagem, vusuario, vsenha);
			}

				
			if (vretorno.indexOf("Err") == -1)
			{
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
					cs.setString(2,vtitulo); //descricao
					cs.setString(3,vusuario); //usuario
					cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
					cs.setString(5,""); //observacao
					
					// variáveis da alteração de conteudo_area
					cs.setInt(6,vidArea); //idArea
					cs.setString(7,vdata); //data_inicio_exib
					//cs.setString(8,vdataFechamento); //data_fim_exib
									
					// variáveis da alteração de arquivo
					cs.setInt(8,Integer.parseInt(vidArquivoImagem)); //idArquivo
					cs.setString(9,vtitulo); // descricao
					cs.setInt(10,9); // publicado
			
					cs.execute();
										
					vretorno = cs.getString(1);

					if ( (vidArea == 22) || (vidArea == 2661) )
					{
						UltimasNoticiasComImagem ultimasNoticiasComImagem = new UltimasNoticiasComImagem();
						vretorno = ultimasNoticiasComImagem.ultimasTV(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 
				
						UltimasNoticiasSemImagem ultimasNoticiasSemImagem = new UltimasNoticiasSemImagem();
						vretorno = ultimasNoticiasSemImagem.ultimas(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 
					}
					if ( (vidArea == 42) || (vidArea == 2661) )
					{
						UltimasNoticiasInternet ultimasNoticiasInternet = new UltimasNoticiasInternet();
						vretorno = ultimasNoticiasInternet.ultimasTV(session.getAttribute("login").toString(), session.getAttribute("senha").toString());			 
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
		out.print("<script>top.atualizaTela(" + vano + ");</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>