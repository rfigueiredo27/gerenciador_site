<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>

<%   
//cria��o de vari�veis
String vmsg         = "";  //mensagem para o usu�rio
String vsql         = "";  //vari�vel onde ser�o armazenadas as instru��es de banco

//recupera os par�metros
String vidarquivoprincipal = request.getParameter("idarquivoprincipal");
String vidarquivoreferencia = request.getParameter("idarquivoreferencia");
String vdescricao = request.getParameter("descricao_principal");

//Prepara as vari�veis para o acesso ao banco
Connection con;
PreparedStatement pstm;
   
try
{
	//Configurando a conex�o com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);
	  
   //////////////////////////////////////////////////////////////////
   //Cria o sql para exclus�o do arquivo
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
   vmsg = "N�o foi poss�vel excluir o arquivo. Ocorreu o seguinte erro: " + ex.getMessage();
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