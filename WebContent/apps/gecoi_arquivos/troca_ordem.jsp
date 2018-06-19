
<%@page import="java.sql.ResultSet"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%   
//criação de variáveis
String vmsg         = "";  //mensagem para o usuário
String vsql         = "";  //variável onde serão armazenadas as instruções de banco

//recupera os parâmetros
int vidarquivo      = Integer.parseInt(request.getParameter("atual"));
String vacao        = request.getParameter("acao");
int vidarquivo_ant  = Integer.parseInt(request.getParameter("anterior"));
int vidarquivo_prox = Integer.parseInt(request.getParameter("proximo"));
int vidConteudo = 0;

//Prepara as variáveis para o acesso ao banco

PreparedStatement pstm;
   
try
{
	vsql = "";  
	//Configurando a conexão com o banco
   String vlogin = session.getAttribute("login").toString();
   String vsenha = session.getAttribute("senha").toString();
   Class.forName("oracle.jdbc.driver.OracleDriver");
   Parametros parametros = new Parametros(
			new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
			Connection con = new ConnectionFactory().getConnection(
			parametros.getBanco(), vlogin, vsenha);
	
		
	if (vacao.compareToIgnoreCase("cima") == 0)
	{
		vsql = "Update gecoi.arquivo set ordem = ordem - 1 where id_arquivo = ?";
   		pstm = con.prepareStatement(vsql);
   		pstm.setInt(1,vidarquivo);
   		pstm.executeQuery();

		vsql = "Update gecoi.arquivo set ordem = ordem + 1 where id_arquivo = ?";
   		pstm = con.prepareStatement(vsql);
   		pstm.setInt(1,vidarquivo_ant);
   		pstm.executeQuery();	
   		
   		
	}
	else
	{
		vsql = "Update gecoi.arquivo set ordem = ordem + 1 where id_arquivo = ?";
   		pstm = con.prepareStatement(vsql);
   		pstm.setInt(1,vidarquivo);
   		pstm.executeQuery();
		
		vsql = "Update gecoi.arquivo set ordem = ordem - 1 where id_arquivo = ?";
   		pstm = con.prepareStatement(vsql);
   		pstm.setInt(1,vidarquivo_prox);
   		pstm.executeQuery();
   		
   		
   		
	}
	
	
	vsql = "SELECT id_conteudo FROM gecoi.arquivo where id_arquivo = ? ";
	pstm = con.prepareStatement(vsql);
	pstm.setInt(1,vidarquivo);
	ResultSet resultSet = pstm.executeQuery();
	
	if(resultSet.next())
	{
		vidConteudo = resultSet.getInt("id_conteudo");
	}
	
resultSet.close();
pstm.close();
con.close(); 
	  
}
catch (Exception ex)
{
   ///////////////////////////////////////////////////////////////////////////////////////////////
   vmsg = "Ocorreu o seguinte erro: " + ex.getMessage();
  ////////////////////////////////////////////////////////////////////////////////////////////////
}	  
%>

<html>
<body>
<script language="javascript">
<%-- 	alert("\n"<%=vidConteudo%>); --%>
<%-- 	alert("\n"<%=vidarquivo%>); --%>
<%-- 	alert("\n"<%=vidarquivo_ant%>); --%>
<%-- 	alert("\n"<%=vidarquivo_prox%>); --%>
<%-- 	alert("\n"<%=vacao%>); --%>
   	parent.atualizaTela2(<%=vidConteudo%>);
</script>
</body>
</html>