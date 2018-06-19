<%@ page import="java.io.*,java.sql.*,java.util.*" %>
<%@include file="/includes/autoriza.jsp"%>
<%@include file="/includes/conexao.jsp"%>

<%
//recebe os parâmetros do usuário
int vidapp;
try {
  vidapp = Integer.parseInt(request.getParameter("id"));
}
catch (NumberFormatException ex) {
  vidapp = 0;
}

try
{
   Class.forName("oracle.jdbc.driver.OracleDriver");
   con = DriverManager.getConnection(vbanco,vlogin,vsenha);

   vsql = "SELECT a.icone, dbms_lob.getlength(a.icone) AS tamanho, a.id_app, a.icone_extensao " +
          "FROM gecoi.app a " +
          "WHERE a.id_app = ?";
   pstm = con.prepareStatement(vsql);
   pstm.setInt(1,vidapp);
   
   resultSet = pstm.executeQuery();
   resultSet.next();

   //recuperando dados do banco
   String vnome_arquivo = "icone_app" + resultSet.getString("id_app") + "." + resultSet.getString("icone_extensao");
   
   byte[] bytearray = new byte[4096];
   int size=0;
   InputStream arquivo; 
   arquivo = resultSet.getBinaryStream(1);
   OutputStream os = response.getOutputStream();

   //tipo do arquivo
   response.reset();
   response.setContentType("application/x-download");
   response.addHeader("Content-Disposition","attachment; name=" + vnome_arquivo + "; filename=" + vnome_arquivo);
   
   while((size=arquivo.read(bytearray))!= -1 ){os.write(bytearray,0,size);}
   response.flushBuffer();
   arquivo.close();
   resultSet.close(); 
}
catch (Exception ex)
{
   out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
   //vlink = "/gecoi.3.0/img/imagem_indisponivel.jpg"; 
}
finally
{
   if(con!=null && !con.isClosed())
      con.close();
}
%>