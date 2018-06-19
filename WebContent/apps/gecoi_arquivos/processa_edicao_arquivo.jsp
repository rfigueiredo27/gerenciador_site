<%@page import="java.util.Date"%>
<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.* ,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.AlterarGecoiArquivo,br.jus.trerj.funcoes.IncluirGecoiArquivo, br.jus.trerj.funcoes.UltimasNoticiasComImagem, br.jus.trerj.funcoes.UltimasNoticiasSemImagem, br.jus.trerj.funcoes.UltimasNoticiasInternet, java.nio.charset.StandardCharsets" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);


out.print("<br>Tamanho="+multiparts.size());  // vou guardar no campo publicado
out.print("<br>0="+multiparts.get(0).getFieldName());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getFieldName());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getFieldName());
out.print("<br>3="+multiparts.get(3).getFieldName());
out.print("<br>4="+multiparts.get(4).getFieldName());
out.print("<br>5="+multiparts.get(5).getFieldName());



out.print("<br>0="+multiparts.get(0).getString());  // vou guardar no campo publicado
out.print("<br>1="+multiparts.get(1).getString());  // vou guardar em observação
out.print("<br>2="+multiparts.get(2).getString());
out.print("<br>3="+multiparts.get(3).getString());
out.print("<br>4="+multiparts.get(4).getString());
out.print("<br>5="+multiparts.get(5).getName());



int vidArea = Integer.parseInt(multiparts.get(0).getString());

//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
Date data = new Date(System.currentTimeMillis());  
SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
String vdata = formatarDate.format(data);

String vtitulo = multiparts.get(1).getString();
vtitulo = new String (vtitulo.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String vtexto = multiparts.get(3).getString();
vtexto = new String (vtexto.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String vidArquivo = multiparts.get(4).getString();// id do arquivo html

String vidConteudo = multiparts.get(5).getString();

String vextensao = "";

String vretorno = "";

String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vnomeArquivoHTML = "arq_" + vusuario + ".htm";

AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();

Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());
try
{
	
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
						
				//multiparts.get(5).write(new File(vdiretorio + vnomeArquivoHTML));
			
		} 
		catch (Exception e) 
		{
			out.print(e.getMessage());
		}
		
		vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vtitulo, vdiretorio, vnomeArquivoHTML, vusuario, vsenha);

		
			
			if (vretorno.indexOf("Err") == -1)
			{

				//Alterando a descrição de todos as arquivos do conteúdo
				vsql = "{call gecoi.g_alterar_descricao_arquivo(?, ?, ?) }";
							
				cs = con.prepareCall(vsql);
					
				// retorno
				cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
									
				cs.setString(2,vidConteudo); //id_conteudo
				cs.setString(3,vtitulo); //descricao

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
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if (vretorno.indexOf("Err") == -1)
	{
		con.commit();
		out.print("<script>top.listar();</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>