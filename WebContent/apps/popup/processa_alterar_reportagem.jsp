<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*, org.apache.commons.fileupload.* ,org.apache.commons.fileupload.*,be.telio.mediastore.ui.upload.UploadListener,be.telio.mediastore.ui.upload.MonitoredDiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, br.jus.trerj.funcoes.AlterarGecoiArquivo,br.jus.trerj.funcoes.IncluirGecoiArquivo, br.jus.trerj.funcoes.UltimasNoticiasComImagem, br.jus.trerj.funcoes.UltimasNoticiasSemImagem, br.jus.trerj.funcoes.UltimasNoticiasInternet" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
int vidArea = 2471;
String vdataInicio = request.getParameter("data_inicio");
String vdataFim = request.getParameter("data_fim");
String vtitulo = request.getParameter("tituloAlteraReportagem");
String vtexto = request.getParameter("vtexto_altera");
out.print(vtexto);
String vidArquivo = request.getParameter("idArquivoHTML");
String vidConteudo = request.getParameter("idConteudo");
String vretorno = "";
String vdiretorio = application.getRealPath("/") + "webtemp\\";
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();
String vnomeArquivoHTML = "popup-" + vusuario + ".htm";

AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, ?, ?, null, ?, ?, ?, ?, null, ?)"; 
 			
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
	cs.setString(7,vdataInicio); //data_inicio_exib
	cs.setString(8,vdataFim); //data_fim_exib
	cs.setInt(9,Integer.parseInt(vidArquivo)); //idArquivo html ou video	
	cs.setString(10,vtitulo); //descricao
	cs.setInt(11,0); // publicado
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
		out.print("<script>alert('Altera\u00e7\u00e3o realizada')</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>