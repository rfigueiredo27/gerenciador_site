<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.* ,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.AlterarGecoiArquivo, br.jus.trerj.funcoes.IncluirGecoiArquivo" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%!
public String alterarArquivo(String vdescricao, String vusuario, String vidConteudo, String vcaminho, int vidArea, String vdata, int vidArquivo, int vedicao, String vdiretorio, String vnomeArquivo, String vsenha, Connection con, CallableStatement cs, AlterarGecoiArquivo alterar)
{
	String vretorno = "";
	try
	{
		String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, ?, " + //alteracao do conteudo 
					//"?, null, to_date(?,'dd/mm/yyyy hh24:mi'), to_date(?,'dd/mm/yyyy'), " + //alteracao do conteudo_area
					//"?, null, ?, ?, " + //alteracao do conteudo_area
					"?, null, ?, null, " + //alteracao do conteudo_area
					"?, ?, null, ?)"; //alteracao do arquivo
				
		cs = con.prepareCall(vsql);
	
		// retorno
		cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
						
		// variáveis da alteração de conteudo
		cs.setString(2,vdescricao); //descricao
		cs.setString(3,vusuario); //usuario
		cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
		cs.setString(5,vcaminho); //observacao
	
		// variáveis da alteração de conteudo_area
		cs.setInt(6,vidArea); //idArea
		cs.setString(7,vdata); //data_inicio_exib
		//cs.setString(7,vdataFechamento); //data_fim_exib
					
		// variáveis da alteração de arquivo
		cs.setInt(8,vidArquivo); //idArquivo
		cs.setString(9,vdescricao); //descricao
		cs.setInt(10,vedicao); // publicado
	
		cs.execute();
		vretorno = cs.getString(1);
		if ( (vretorno.indexOf("Err") == -1) && (!vnomeArquivo.equals("")) )
		{
			vretorno = alterar.substituirArquivo(vidConteudo, ""+vidArquivo, vdescricao, vdiretorio, vnomeArquivo, vusuario, vsenha);
	
			if (vretorno.indexOf("Err") == -1)
			{
			}
			else
			{
				//out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
				vretorno = "Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno;
			}
		}
		else
		{
			//out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno );
			vretorno = "Ocorreu o seguinte erro na gravacao do arquivo: " + vretorno ;
		}
	}
	catch (Exception ex)
	{
		vretorno = "Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage();
	}
	return vretorno;
}

%>
<%
request.setCharacterEncoding("ISO-8859-1");
UploadListener listener = new UploadListener(request, 30);
FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> multiparts = null;
multiparts = upload.parseRequest(request);
int vedicao = Integer.parseInt(multiparts.get(0).getString());  // vou guardar no campo publicado
String vdata = multiparts.get(1).getString();
String vcaminho = multiparts.get(2).getString();
String varquivoPdf = multiparts.get(3).getName();
String varquivoWord = multiparts.get(4).getName();
String varquivoCapa = multiparts.get(5).getName();
String vidConteudo = multiparts.get(6).getString();
int vidArquivoPdf = Integer.parseInt(multiparts.get(7).getString());
int vidArquivoWord = Integer.parseInt(multiparts.get(8).getString());
int vidArquivoCapa = Integer.parseInt(multiparts.get(9).getString());
out.print(varquivoPdf);
String vextensao = "";
String vnomeArquivo = "";
int vidArea = 13;
vidArea = 1622;
String vretorno = "";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();
IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();

Calendar c = Calendar.getInstance();
SimpleDateFormat ft = new SimpleDateFormat ("hh_mm_ss");
String vagora = ft.format(c.getTime());
String vdescricao = "Edi��o n� " + vedicao + " do Jornal Parlat�rio";
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
	// primeiro altero os dados, depois os arquivos
	String vsql = "";
	CallableStatement cs = null;
	// se fiz alteração nos campos edicao, data e caminho e não alterei nenhum arquivo
	if ( (varquivoPdf.equals("")) && (varquivoWord.equals("")) && (varquivoCapa.equals("")) )
	{
		// preciso alterar a edição para cada arquivo existente
		if (vidArquivoPdf > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoPdf, vedicao, vdiretorio, "", vsenha, con, cs, alterar);
		if (vidArquivoWord > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoWord, vedicao, vdiretorio, "", vsenha, con, cs, alterar);
		if (vidArquivoCapa > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoCapa, vedicao, vdiretorio, "", vsenha, con, cs, alterar);
	}
	if (!varquivoPdf.equals(""))
	{
		// fazendo o upload do arquivo Pdf
		vextensao = varquivoPdf.substring(varquivoPdf.lastIndexOf(".")+1, varquivoPdf.length());
		vnomeArquivo = varquivoPdf.substring(0, varquivoPdf.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivo.lastIndexOf("\\") > -1)
		{
			vnomeArquivo = vnomeArquivo.substring(varquivoPdf.lastIndexOf("\\")+1);
		}
		multiparts.get(3).write(new File(vdiretorio + varquivoPdf));
		cs = null;
		if (vidArquivoPdf > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoPdf, vedicao, vdiretorio, vnomeArquivo, vsenha, con, cs, alterar);
		else
			vretorno = incluir.incluir(vidConteudo, vdescricao, vdiretorio, vnomeArquivo, vusuario, vsenha, 0, vedicao, vcaminho);
	}
	if (!varquivoWord.equals(""))
	{
		// fazendo o upload do arquivo Word
		vextensao = varquivoWord.substring(varquivoWord.lastIndexOf(".")+1, varquivoWord.length());
		vnomeArquivo = varquivoWord.substring(0, varquivoWord.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivo.lastIndexOf("\\") > -1)
		{
			vnomeArquivo = vnomeArquivo.substring(vnomeArquivo.lastIndexOf("\\")+1);
		}
		multiparts.get(4).write(new File(vdiretorio + vnomeArquivo));
		cs = null;
		if (vidArquivoWord > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoWord, vedicao, vdiretorio, vnomeArquivo, vsenha, con, cs, alterar);
		else
			vretorno = incluir.incluir(vidConteudo, vdescricao, vdiretorio, vnomeArquivo, vusuario, vsenha, 1, vedicao, vcaminho);
	}
	if (!varquivoCapa.equals(""))
	{
		// fazendo o upload do arquivo Capa
		vextensao = varquivoCapa.substring(varquivoCapa.lastIndexOf(".")+1, varquivoCapa.length());
		vnomeArquivo = varquivoCapa.substring(0, varquivoCapa.lastIndexOf(".")) + "-" + vusuario + "." + vextensao;
		if (vnomeArquivo.lastIndexOf("\\") > -1)
		{
			vnomeArquivo = vnomeArquivo.substring(vnomeArquivo.lastIndexOf("\\")+1);
		}
		multiparts.get(5).write(new File(vdiretorio + vnomeArquivo));
		cs = null;
		if (vidArquivoCapa > 0)
			alterarArquivo(vdescricao, vusuario, vidConteudo, vcaminho, vidArea, vdata, vidArquivoCapa, vedicao, vdiretorio, vnomeArquivo, vsenha, con, cs, alterar);
		else
			vretorno = incluir.incluir(vidConteudo, vdescricao, vdiretorio, vnomeArquivo, vusuario, vsenha, 2, vedicao, vcaminho);
	}	
	out.print(vretorno);
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
		//out.print("<script>top.atualizaTela();</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>