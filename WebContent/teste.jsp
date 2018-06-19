<%@page language="java" import="java.sql.*,java.util.*"%>
<%@include file="/jsp/conexao_pool_gecoi.jsp"%>

<%
// criacão de variveis
String vanexos = "";        //quantidade de anexos
String vmsg      = "";   //mensagem para o usurio
String vid_area  = "61"; //Declarao da rea do GECOI
String vtamanexo = "";

//recebe os parâmetros do usuário
int vidconteudo;
try {
  vidconteudo = Integer.parseInt(request.getParameter("idconteudo"));
}
catch (NumberFormatException ex) {
  vidconteudo = 0;
}

int vidarquivo;
try {
  vidarquivo = Integer.parseInt(request.getParameter("idarquivo"));
}
catch (NumberFormatException ex) {
  vidarquivo = 0;
}

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//con = DriverManager.getConnection(vbanco, vlogin, vsenha);
	con = connectionFactory.getConnection(identificador);
	String vsql = "SELECT (a.qtd + r.qtd) AS qtd from (" +
	              "SELECT Count(id_arquivo) AS qtd FROM gecoi.arquivo WHERE id_conteudo=? AND ordem>0) a, " +
                  "(SELECT Count(id_arquivo_referencia) AS qtd FROM gecoi.referencia WHERE id_arquivo_principal=?) r";

	// Assign Parameter Values
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1,vidconteudo);
	pstm.setInt(2,vidarquivo);	
	resultSet = pstm.executeQuery();
	resultSet.next();
   
	vanexos = resultSet.getString("qtd");

	//Se no houver anexos redireciona para o arquivo principal
	if (Integer.parseInt(vanexos)>0)
 	{  vtamanexo = "120";}
	else   
 	{  vtamanexo = "0";}
	resultSet.close(); 
} 
catch (Exception ex)
{
   ////////////////////////////////////////////////////////////////////////////////////////////
   out.println("No foi possvel conectar ao banco. Ocorreu o seguinte erro: " + ex.getMessage());
  ///////////////////////////////////////////////////////////////////////////////////////////
}
finally
{
    if(con!=null && !con.isClosed())
       con.close();	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GECOI Arquivos - Visualiza&ccedil;&atilde;o do Arquivo</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<frameset rows="*,<%=vtamanexo%>" cols="*" frameborder="no" border=0 framespacing=0>
  <frame src="grava_arquivo.jsp?id=<%=vidarquivo%>" name="aviso" title="Frame para download de arquivo" scrolling="auto">
  <frame src="visualizar_anexos.jsp?idconteudo=<%=vidconteudo%>&idarquivo=<%=vidarquivo%>" name="anexo"  title="Frame para visualização de arquivo"
 noresize frameborder="NO" scrolling="auto">
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>