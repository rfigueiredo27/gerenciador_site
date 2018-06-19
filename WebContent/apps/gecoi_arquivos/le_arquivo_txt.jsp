<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%
try
{
   //Configurando a conexão com o banco
   String vidarquivo = request.getParameter("idArquivo");
   String vpasta = "";
   String vlogin = session.getAttribute("login").toString();
   String vsenha = session.getAttribute("senha").toString();
   Class.forName("oracle.jdbc.driver.OracleDriver");
   Parametros parametros = new Parametros(
			new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
	Connection con = new ConnectionFactory().getConnection(
			parametros.getBanco(), vlogin, vsenha);

   //Acessando os dados no banco
   String vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho " +
          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
		  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      

   PreparedStatement pstm = con.prepareStatement(vsql);
   pstm.setString(1,vidarquivo);

   ResultSet resultSet = pstm.executeQuery();

   //Se encontrou o registro
   if(resultSet.next())
   {
     String vnome                   = resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
	 String vtitulo                 = resultSet.getString("descricao");             //guardao título da notícia
	 vpasta                         = "webtemp";                                    //guarda o caminho onde será gravado o arquivo
     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024

     //Indica onde arquivo será gravado
	 java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
	 
	 //Grava o arquivo na pasta
     FileOutputStream fos = new FileOutputStream(varquivo);

     //Configura o tamanho do buffer que será usado para gravar o arquivo
     byte[] buffer       = new byte[1024];
     byte[] sobra_buffer = new byte[vresto_arquivo]; 

     //Grava o arquivo na pasta especificada com o tamanho especificado
     InputStream is = resultSet.getBinaryStream("arquivo");
     for (int ind = 0; ind < (vtamanho_arquivo/1024); ind++)  
     {  
        is.read(buffer);
        fos.write(buffer);
     }
     is.read(sobra_buffer);
     fos.write(sobra_buffer);

     //fecha o objeto
     fos.close();

     //Preparação para ler o arquivo
     StringBuffer contents = new StringBuffer();
     BufferedReader reader = null;
 
     reader = new BufferedReader(new FileReader(varquivo));
     String text = null;
 
     // Lê o arquivo, substituindo as quebras de linha pela tag </br>
     while ((text = reader.readLine()) != null) {
		 
		 //Se no texto tiver as seguintes tags: <p>, <ul>, <li>, <h1>, <h2>, <h3>
		 //não é necessário pular uma linha com a tag <br>
         if(text.indexOf("ul>")>0 || text.indexOf("li>")>0 || text.indexOf("p>")>0 || text.indexOf("h1>")>0 || text.indexOf("h2>")>0 || text.indexOf("h3>")>0)
		   contents.append(text);
		 else
           contents.append(text + "<br>");
     }

     //retorna o texto lido
     out.println(contents.toString());
	 
     //Apaga o arquivo no webtemp
     varquivo.delete();
     reader.close();
   }
   else
   {
     out.println("O arquivo não foi encontrado."); 
   }

   //fecha os objetos do banco
   
   resultSet.close();
   con.close();

}
catch (Exception ex)
{
    out.println("Ocorreu um erro: " + ex.getMessage());
} 

%>
