<%@ page language="java" import="java.sql.*,java.io.*, java.util.*" %>
<%@include file="/jsp/conexao_pool_gecoi.jsp"%>

<%
//recebe os parâmetros do arquivo
String vlink      = "";  //link do arquivo no site
String vnome_area = "";  //descrição da área
String vaplicacao = "";  //nome da aplicação

int vidarquivo;
try {
  vidarquivo = Integer.parseInt(request.getParameter("id"));
}
catch (NumberFormatException ex) {
  vidarquivo = 0;
}

if (vidarquivo>0) {
   try
   {
     java.io.File varquivo          = null;   //arquivo que será gravado
     java.io.File vdiretorio        = null;   //pasta onde será gravado o arquivo
     String vnome_arquivo           = "";     //nome do arquivo
     java.util.Date vdata_alteracao = null;   //data da última alteração do arquivo
     int vtamanho_arquivo = 0;                //tamanho do arquivo
     int vresto_arquivo = 0;                  //resto do tamanho do arquivo dividido por 1024

     //Verifica qual foi a última vez que o arquivo foi gerado
     Class.forName("oracle.jdbc.driver.OracleDriver");
     //con = DriverManager.getConnection(vbanco, vlogin, vsenha);
	 con = connectionFactory.getConnection(identificador);

     String vsql = "SELECT Nvl(co.data_ult_alteracao,co.data_criacao) AS data_ult_alteracao, ar.pasta_fisica, aq.nome, aq.arquivo, dbms_lob.getlength(aq.arquivo) AS tamanho, ar.descricao " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca, gecoi.area ar " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo AND ca.id_area=ar.id_area " +
                   "AND aq.id_arquivo=?";

     PreparedStatement pstm = con.prepareStatement(vsql);
     pstm.setInt(1,vidarquivo);   
	  
     resultSet = pstm.executeQuery();		  
     if(resultSet.next())
     {
		//recuperando dados do banco
        vdata_alteracao  = resultSet.getTimestamp("data_ult_alteracao"); //guarda a data da última alteração do arquivo
	    vnome_arquivo    = resultSet.getString("nome").toLowerCase();
	    vnome_area       = resultSet.getString("descricao");
	    vlink            = resultSet.getString("pasta_fisica") + "/" + vnome_arquivo;
  	    vtamanho_arquivo = resultSet.getInt("tamanho");
		
		//Criando variáveis para gravação do arquivo
        varquivo         = new File(application.getRealPath("/" + vlink));
	    vdiretorio       = new File(application.getRealPath("/" + resultSet.getString("pasta_fisica")));
 	    vresto_arquivo   = vtamanho_arquivo%1024;
		
		//descobrindo o nome da aplicação para colocar no link
   	    vaplicacao              = application.getRealPath("/");
	    String[] Arrayaplicacao = vaplicacao.split("/");
	    vaplicacao              = "/" + Arrayaplicacao[Arrayaplicacao.length-1] + "/";
     }
  
     //Verifica se pasta já existe, se não existir cria
     if (!vdiretorio.exists()) {  
        vdiretorio.mkdirs(); //mkdir() cria somente um diretório, mkdirs() cria diretórios e subdiretórios.  
     }   
     //Verifica se o arquivo já está gravado no servidor ou se
     //o arquivo no banco é mais atual que o gravado na pasta
     if (!varquivo.exists() || (vdata_alteracao.getTime() > varquivo.lastModified())) {
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
	  vlink = "/jsp/erro.htm"; 
  }
  finally
  {
    if(con!=null && !con.isClosed())
       con.close();
  }
} else {
  vlink = "/jsp/erro.htm";
}

//Para contabilizar os acessos pelo Google, decidimos utilizar o redirecionamento pelo código HTML
//Caso contrário poderíamos utilizar o sendredirect
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html dir="ltr" xml:lang="pt-br" lang="pt-br" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>TRE-RJ - <%=vnome_area%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta http-equiv="Cache-Control" content="no cache">
  <meta http-equiv="Pragma" content="no cache">
  <meta http-equiv="Expires" content="0">
  <meta http-equiv="refresh" content="1;URL=<%=vaplicacao+vlink%>">

  <!--Estatistica do Google-->
  <script type="text/javascript" src="/site/scripts/estatistica_google.js"></script>  
</head>
<body>
</body>
</html>