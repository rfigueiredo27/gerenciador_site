<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>

<%   
//criação de variáveis
String vmsg         = "";  //mensagem para o usuário
String vsql         = "";  //variável onde serão armazenadas as instruções de banco

//recupera os parâmetros
String vidarquivoprincipal = request.getParameter("idarquivoprincipal");
String vidarquivoreferencia = request.getParameter("idarquivoreferencia");
String vdescricao = request.getParameter("descricao_principal");

//Prepara as variáveis para o acesso ao banco
Connection con;
PreparedStatement pstm;
   
try
{
	//Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);
	  
   //////////////////////////////////////////////////////////////////
   //Cria o sql para exclusão do arquivo
   vsql = "DELETE gecoi.referencia WHERE id_arquivo_principal = ? and id_arquivo_referencia = ?";

   pstm = con.prepareStatement(vsql);
   pstm.setString(1,vidarquivoprincipal);
   pstm.setString(2,vidarquivoreferencia);

   pstm.executeQuery();
	  
   con.close(); 
	  
}
catch (Exception ex)
{
   ///////////////////////////////////////////////////////////////////////////////////////////////
   vmsg = "Não foi possível excluir o arquivo. Ocorreu o seguinte erro: " + ex.getMessage();
  ////////////////////////////////////////////////////////////////////////////////////////////////
}	  
%>

<html>
<body>
<script language="javascript">
top.carregaPag("/gecoi.3.0/apps/gecoi_arquivos/manutencao_referencia.jsp?idprincipal=<%=vidarquivoprincipal%>&descricao=<%=vdescricao%>" ,"divbusca");
</script>
</body>
</html>