<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File, br.jus.trerj.funcoes.GravarArquivo;"%>

<%
//String vdiretorio = request.getParameter("diretorio");
String vdiretorio = application.getRealPath("/") + "webtemp";
//String vnome = request.getParameter("nome");

GravarArquivo gravarArquivo = new GravarArquivo();
//String vnome = gravarArquivo.gravar(vidConteudo, "htm", vdiretorio);
String vnome = gravarArquivo.gravar(vidArquivoTexto, vdiretorio, session.getAttribute("login").toString());
if (!vnome.equals("erro"))
{
try
{
   /*//Configurando a conex�o com o banco
   Class.forName("oracle.jdbc.driver.OracleDriver");
   Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + vbanco, vlogin, vsenha);

   //Acessando os dados no banco
   vsql = "select a.arquivo, a.nome, a.descricao, dbms_lob.getlength(a.arquivo) AS tamanho " +
          "from gecoi.arquivo a, gecoi.conteudo c, gecoi.conteudo_area ca, gecoi.area ar " +
		  "where a.id_conteudo=c.id_conteudo AND c.id_conteudo = ca.id_conteudo AND ca.id_area = ar.id_area and a.id_arquivo=?";	      

   PreparedStatement pstm = con.prepareStatement(vsql);
   pstm.setString(1,vidarquivo);

   ResultSet resultSet = pstm.executeQuery();

   //Se encontrou o registro
   if(resultSet.next())
   {
     String vnome                   = resultSet.getString("nome").toLowerCase();    //guarda o nome do arquivo
	 String vtitulo                 = resultSet.getString("descricao");             //guardao t�tulo da not�cia
	 vpasta                         = "webtemp";                                    //guarda o caminho onde ser� gravado o arquivo
     int vtamanho_arquivo           = resultSet.getInt("tamanho");                  //guarda o tamanho do arquivo
     int vresto_arquivo             = vtamanho_arquivo%1024;                        //guarda o resto do arquivo dividido em blocos de 1024

     //Indica onde arquivo ser� gravado
	 java.io.File varquivo = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
	 
	 //Grava o arquivo na pasta
     FileOutputStream fos = new FileOutputStream(varquivo);

     //Configura o tamanho do buffer que ser� usado para gravar o arquivo
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
*/
     //Prepara��o para ler o arquivo
     File varquivo = new File(vdiretorio + "\\" + vnome);
     StringBuffer contents = new StringBuffer();
     BufferedReader reader = null;
 
     reader = new BufferedReader(new FileReader(varquivo));
     String text = null;
 
     // L� o arquivo, substituindo as quebras de linha pela tag </br>
     while ((text = reader.readLine()) != null) {
		 
		 //Se no texto tiver as seguintes tags: <p>, <ul>, <li>, <h1>, <h2>, <h3>
		 //n�o � necess�rio pular uma linha com a tag <br>
         if(text.indexOf("ul>")>0 || text.indexOf("li>")>0 || text.indexOf("p>")>0 || text.indexOf("h1>")>0 || text.indexOf("h2>")>0 || text.indexOf("h3>")>0)
		   contents.append(text);
		 else
           contents.append(text + "<br>");
     }

     //retorna o texto lido
     out.println(contents.toString());
	 
     //Apaga o arquivo no webtemp
     varquivo.delete();
   /*}
   else
   {
     out.println("O arquivo n�o foi encontrado."); 
   }

   //fecha os objetos do banco
   resultSet.close();
   con.close();
*/
}
catch (Exception ex)
{
    out.println("Ocorreu um erro: " + ex.getMessage());
} 
}
%>
