<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes, br.jus.trerj.funcoes.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
request.setCharacterEncoding("UTF-8");

int vidArea = Integer.parseInt(request.getParameter("tipoAlteraLegislacao"));  
String vdata = request.getParameter("dataAlteraLegislacao");
String vnorma = request.getParameter("tipoAlteraNorma");
String vnumero_norma = request.getParameter("numAlteraNorma");
String vano_norma = request.getParameter("anoAlteraNorma");
String vassunto = request.getParameter("assuntoAlteraLegislacao");
String vdescricao_aux = request.getParameter("AlteraDescricaoAuxiliar");
String vidConteudo = request.getParameter("idConteudo");
String vidArquivo = request.getParameter("idArquivo");
String vanoBusca = request.getParameter("anoBusca");
String vLegislacaoBusca = request.getParameter("legislacaoBusca");
String vretorno = "";

String vdescricao = "";
if ( (vidArea == 47) || (vidArea == 48) || (vidArea == 53) )
	vdescricao = vnorma + vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
else
	if (vidArea == 50) 
		vdescricao = vdescricao_aux;
	else
		vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
/*
if ( (vidArea == 47) || (vidArea == 48) || (vidArea == 53) )
	//vdescricao = vnorma + " nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vnorma + vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vidArea == 20) || (vidArea == 36) || (vidArea == 2434) )
	//vdescricao = "Resolução nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vidArea == 50) 
	//vdescricao = "Índice dos Atos da Presidência do TRE-RJ.";
	vdescricao = vdescricao_aux;
if (vidArea == 33) 
	//vdescricao = "Ato nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vidArea == 39) 
	//vdescricao = "Ato VP nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vidArea == 38)
	//vdescricao = "Ato Conjunto nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vidArea == 45) || (vidArea == 49) || (vidArea == 2631) || (vidArea == 46) || (vidArea == 2560) || (vidArea == 76) || (vidArea == 77) || (vidArea == 2652) )
	//vdescricao = "Portaria nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vidArea == 1747) || (vidArea == 90) || (vidArea == 2587) )
	//vdescricao = "Instrução Normativa nº " + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if ( (vidArea == 65) || (vidArea == 44) )
	//vdescricao = "Ordem de Serviço nº" + vnumero_norma + "/" + vano_norma + " - " + vassunto;
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
if (vidArea == 2502) 
	vdescricao = vdescricao_aux + vnumero_norma + "/" + vano_norma + " - " + vassunto;
*/

String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();

AlterarGecoiArquivo alterar = new AlterarGecoiArquivo();

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
	cs.setString(2,vdescricao); //descricao
	cs.setString(3,vusuario); //usuario
	cs.setInt(4,Integer.parseInt(vidConteudo)); //idconteudo
	cs.setString(5,""); //observacao

	// variáveis da alteração de conteudo_area
	cs.setInt(6,vidArea); //idArea
	cs.setString(7,vdata); //data_inicio_exib
	//cs.setString(7,vdataFechamento); //data_fim_exib
     			
	// variáveis da alteração de arquivo
	
	cs.setInt(8,Integer.parseInt(vidArquivo)); //idArquivo html ou video	
	cs.setString(9,vdescricao); //descricao
	cs.setInt(10,9); // publicado
	cs.execute();
	vretorno = cs.getString(1);

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
		out.print("<script>top.atualizaTela(" + vanoBusca + "," + vLegislacaoBusca + ");</script>");
	}
	if(con!=null && !con.isClosed())
		con.close();
}

%>