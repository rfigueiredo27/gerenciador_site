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


int vidArea = 2694;

//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
Date data = new Date(System.currentTimeMillis());  
SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
String vdata = formatarDate.format(data);

String vedital = multiparts.get(0).getString();;
String vano = multiparts.get(1).getString();
String prestacao = multiparts.get(2).getString();
prestacao = new String (prestacao.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String partido = multiparts.get(3).getString();
partido = new String (partido.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String vtexto = multiparts.get(4).getString();
vtexto = new String (vtexto.getBytes (StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

String vidArquivo = multiparts.get(5).getString();// id do arquivo html ou video

String vidConteudo = multiparts.get(6).getString();


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

//Guarda as informações do Edital, Ano, Prestação e Partido no campo descrição
String vtitulo = vedital+"@@"+vano+"@@"+prestacao+"@@"+partido;

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

	// alterando o html
	// retorno
	cs.registerOutParameter(1, OracleTypes.VARCHAR); //retorno
	
	// Variáveis da alteração de conteudo
	cs.setString(2,vtitulo); //descricao
	cs.setString(3,vusuario); //usuario
	cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
	cs.setString(5,""); //observacao

	// Variáveis da alteração de conteudo_area
	cs.setInt(6,vidArea); //idArea
	cs.setString(7,vdata); //data_inicio_exib
	//cs.setString(7,vdataFechamento); //data_fim_exib
     			
	// variáveis da alteração de arquivo
	
	cs.setInt(8,Integer.parseInt(vidArquivo)); //idArquivo html 	
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
		vretorno = alterar.substituirArquivo(vidConteudo, vidArquivo, vtitulo, vdiretorio, vnomeArquivoHTML, vusuario, vsenha);

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