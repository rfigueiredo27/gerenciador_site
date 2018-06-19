<%@include file="autoriza.jsp"%>
<%@ page language="java" import="java.io.*,oracle.sql.BLOB,java.sql.Blob,java.sql.*,java.util.*,java.text.*"%>
<%@include file="/jsp/conexao_pool.jsp"%>

<%
//criação de variáveis
String vtexto_arquivo = ""; //mensagem para o usuário
int vidarquivo        = 0;  //id do arquivo
int vidconteudo       = 0;  //id do conteudo do arquivo
String vpasta         = ""; //pasta onde será gravado o arquivo temporário
String vpasta_fisica  = ""; //pasta física onde está gravado o arquivo no servidor web
String vnome          = ""; //nome do arquivo que será gravado
String vmsg           = ""; //mensagem para o usuário
String vsql           = ""; //instruções do banco
File varquivo;              //arquivo gravado no disco

//Se algum dado foi enviado
Enumeration e = request.getParameterNames();
if(e.hasMoreElements())
{
	
   ////////////////////////////////////////////////////////////////////////////////////////////////////////
   //Recupera o valor dos campos do formulário
   //Grava o arquivo na pasta webtemp do GECOI
   ////////////////////////////////////////////////////////////////////////////////////////////////////////
   
   //Recebe os parâmetros do formulário
   vtexto_arquivo  = request.getParameter("texto");
   vidarquivo      = Integer.parseInt(request.getParameter("idarquivo"));
   vpasta          = request.getParameter("pasta");
   vnome           = vlogin + "_" + vidarquivo + ".txt";
   varquivo        = new File(application.getRealPath("/" + vpasta) + "/" + vnome);
	   
   //Gravar o arquivo para inserir no banco
   try {
	   FileOutputStream gravador = new FileOutputStream(varquivo);
	   gravador.write(vtexto_arquivo.getBytes());
	   gravador.close();
   }
   catch(Exception ex){
	   vmsg = "Ocorreu o seguinte erro na gravação do arquivo: " + ex.getMessage(); 
   }


   ////////////////////////////////////////////////////////////////////////////////////////////////////////
   //Grava os valores enviados do formulário nas tabelas conteúdo, arquivo e conteudo_area
   ////////////////////////////////////////////////////////////////////////////////////////////////////////
   try
   {
      if (vmsg.compareToIgnoreCase("")==0)
	  {
	     //////////////////////////////////////////////////////////////////////////////////////////////////
         //variáveis usadas no acesso ao banco
		 //////////////////////////////////////////////////////////////////////////////////////////////////
         Connection con;
         PreparedStatement pstm;
		 ResultSet resultSet;

         Class.forName("oracle.jdbc.driver.OracleDriver");
         con = DriverManager.getConnection("jdbc:oracle:thin:@" + vbanco,vlogin,vsenha);
         con.setAutoCommit(false);
		 
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
         //Recuperando o idconteudo do arquivo
		 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 vsql = "select id_conteudo from gecoi.arquivo where id_arquivo=?";

         pstm = con.prepareStatement(vsql);
         pstm.setInt(1,vidarquivo);

         resultSet = pstm.executeQuery();
		 if (resultSet.next())
 		    vidconteudo   = resultSet.getInt("id_conteudo");


         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
         //Alterando as informações sobre o conteúdo
		 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 vsql = "update gecoi.conteudo set " +
				"data_ult_alteracao=sysdate, logon_usuario_ult_alteracao=? " +
                "where id_conteudo=?";

         pstm = con.prepareStatement(vsql);
         pstm.setString(1,vlogin);		 
         pstm.setInt(2,vidconteudo);

         pstm.executeQuery();
		 
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
         //Preparando o arquivo Blob para o update
		 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 vsql = "update gecoi.arquivo set nome=?, arquivo=empty_blob() where id_arquivo=?";
		 NumberFormat format = new DecimalFormat("000000");

         pstm = con.prepareStatement(vsql);
		 pstm.setString(1,"arq_" + format.format(vidarquivo) + ".htm");
         pstm.setInt(2,vidarquivo);

         pstm.executeQuery();

		 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //atualizando o arquivo no campo blob
		 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////        
		 
		 //bloqueia o registro para alterar o arquivo
		 vsql = "select arquivo from gecoi.arquivo where id_arquivo=? for update";
		 
         pstm = con.prepareStatement(vsql);
         pstm.setInt(1,vidarquivo);
		 
		 resultSet = pstm.executeQuery();
         resultSet.next();

         // copia arquivo para campo blob
         Blob blob = resultSet.getBlob("arquivo");
         byte[] bbuf = new byte[1024];  
         InputStream bin = new FileInputStream(varquivo);  
         OutputStream bout = ((BLOB) blob).getBinaryOutputStream(); // específico driver oracle  

         int bytesRead = 0;  
         while ((bytesRead = bin.read(bbuf)) != -1)
	     {  
            bout.write(bbuf, 0, bytesRead); 
         }  
      
	     bin.close();
         bout.close();

         // comita transação
         con.commit();
         resultSet.close();
	     con.close();
		 
         //Apaga o arquivo no webtemp
         varquivo.delete();

         vmsg = "Arquivo gravado com sucesso!";
      }
	  
   }catch (Exception ex) {
       vmsg = "Ocorreu o seguinte erro: " + ex.getMessage(); 
   }	
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script language="javascript">
//função que altera a mensagem da processa_substituicao.jsp
function goMsg(msg)
{  
   parent.document.getElementById("mensagem_caixa").innerHTML = "<%=vmsg%>";
<%if(vmsg.indexOf("sucesso")>0)
   out.print("parent.document.getElementById(\"mensagem_caixa\").className = \"sucesso\";");
else
   out.print("parent.document.getElementById(\"mensagem_caixa\").className = \"erro\";");   
%>
   parent.document.getElementById("mensagem_caixa").style.display = "block";
}
</script>
</head>
<body>
<script language="javascript"> 
    var msg = "<%=vmsg%>"; //Guarda a mensagem do jsp na variável do javascript
    goMsg(msg); //informa ao usuário o resultado da substituição
</script>

</body>
</html>