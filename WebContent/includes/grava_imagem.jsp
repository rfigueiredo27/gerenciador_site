<%@ page language="java" import="java.sql.*,java.io.*, java.util.*" %>
<%@include file="/includes/conexao.jsp"%>

<%
//recebe os parâmetros do arquivo
String vlink      = "";  //link do arquivo no site
String vaplicacao = "";

int vidapp;
try {
  vidapp = Integer.parseInt(request.getParameter("id"));
}
catch (NumberFormatException ex) {
  vidapp = 0;
}

if (vidapp>0) {
   try
   {
     java.io.File varquivo          = null;   //arquivo que será gravado
     java.io.File vdiretorio        = null;   //pasta onde será gravado o arquivo
     String vnome_arquivo           = "";     //nome do arquivo
     int vtamanho_arquivo = 0;                //tamanho do arquivo
     int vresto_arquivo = 0;                  //resto do tamanho do arquivo dividido por 1024

     //Verifica qual foi a última vez que o arquivo foi gerado
     Class.forName("oracle.jdbc.driver.OracleDriver");
     con = DriverManager.getConnection(vbanco, vlogin, vsenha);

     vsql = "SELECT a.icone, dbms_lob.getlength(a.icone) AS tamanho, a.id_app, a.icone_extensao " +
                   "FROM gecoi.app a " +
                   "WHERE a.id_app = ?";

     pstm = con.prepareStatement(vsql);
     pstm.setInt(1,vidapp);   
	  
     resultSet = pstm.executeQuery();		  
     if(resultSet.next())
     {
		//recuperando dados do banco
	    vnome_arquivo    = "icone_app" + resultSet.getString("id_app") + "." + resultSet.getString("icone_extensao");
	    vlink            = "/img/icones/" + vnome_arquivo;
  	    vtamanho_arquivo = resultSet.getInt("tamanho");
		
		//Criando variáveis para gravação do arquivo
        varquivo         = new File(application.getRealPath("/" + vlink));
 	    vresto_arquivo   = vtamanho_arquivo%1024;
		
		//descobrindo o nome da aplicação para colocar no link
   	    vaplicacao              = application.getRealPath("/");
	    String[] Arrayaplicacao = vaplicacao.split("/");
	    vaplicacao              = "/" + Arrayaplicacao[Arrayaplicacao.length-1] + "/";
     }

     //Verifica se o arquivo já está gravado no servidor ou se
     //o arquivo no banco é mais atual que o gravado na pasta
     if (!varquivo.exists()) {

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
     }
      
     resultSet.close();
  }
  catch (Exception ex)
  {
 	  out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
	  vlink = "/gecoi.3.0/img/imagem_indisponivel.jpg"; 
  }
  finally
  {
    if(con!=null && !con.isClosed())
       con.close();
  }
} else {
  vlink = "/gecoi.3.0/img/imagem_indisponivel.jpg";
}

response.sendRedirect("/gecoi.3.0/" + vlink);
//response.sendRedirect(vlink);
//out.print(vlink);
%>