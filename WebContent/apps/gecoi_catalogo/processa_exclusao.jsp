<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>


<%   
//cria��o de vari�veis

int vidconteudo  = 0;  //id do conteudo para gravar o arquivo
int vidcatalogo  = 0;  //
int vidarquivo   = 0;  //

//recupera os par�metros
vidconteudo = Integer.parseInt(request.getParameter("id_conteudo"));
vidarquivo  = Integer.parseInt(request.getParameter("id_arquivo"));
vidcatalogo = Integer.parseInt(request.getParameter("id_catalogo"));

out.print(vidconteudo);
out.print(vidarquivo);
out.print(vidcatalogo);


////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se a��o for igual a excluir
////////////////////////////////////////////////////////////////////////////////////////////////////////

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
      String vsql = "DELETE gecoi.arquivo_catalogo WHERE id_conteudo = ? and id_arquivo = ? and id_catalogo = ? ";

      pstm = con.prepareStatement(vsql);
      pstm.setInt(1,vidconteudo);
      pstm.setInt(2,vidarquivo);	  
      pstm.setInt(3,vidcatalogo);

      pstm.executeQuery();	  	  
	  
   // comita transa��o  
      con.commit();
   	  con.close(); 
	  
      String vmsg = "O arquivo foi exclu�do com sucesso!";
      
	  

   }
   catch (Exception ex)
   {
      ///////////////////////////////////////////////////////////////////////////////////////////////
      String vmsg = "O arquivo n�o foi exclu�do. Ocorreu o seguinte erro: " + ex.getMessage();
     ////////////////////////////////////////////////////////////////////////////////////////////////
   }	  
%>   

