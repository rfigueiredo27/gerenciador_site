<%@include file="/includes/autoriza.jsp"%>
<%@page language="java" import="java.sql.*" %>
<%@include file="/includes/conexao.jsp"%>
<%

if(vlogin.compareToIgnoreCase("")!=0)
{
  try
  {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    con = DriverManager.getConnection(vbanco,vlogin,vsenha);
	
    vsql = "SELECT ap.id_app, ap.nome, ap.caminho, ap.icone, ap.descricao " +
           "FROM gecoi.app ap, gecoi.grupo_app ga, gecoi.permissao pe " +
           "WHERE ap.id_app=ga.id_app AND ga.id_grupo=pe.id_grupo " +
           "AND Upper(pe.logon_usuario) = Upper(?)" +
           "ORDER BY ap.nome";
	  
    pstm = con.prepareStatement(vsql);
    pstm.setString(1,vlogin);
    String appAnterior = "";

    resultSet = pstm.executeQuery();      
	  
    if (resultSet.next())
    {  
      do
      {
    	  if (!appAnterior.equals(resultSet.getString("nome")))
			out.println("<div id='app'><a href='javascript:void(0)' onclick='carregaAPP(\"" + vraiz + resultSet.getString("caminho") + "\",\"" + resultSet.getString("descricao") + "\");'>" +
		             "<img src='/gecoi.3.0/includes/mostra_imagem.jsp?id=" + resultSet.getString("id_app") + "' onerror=\"this.src='/gecoi.3.0/img/imagem_indisponivel.jpg';\" title='" + resultSet.getString("nome") + "'/><p>" + resultSet.getString("nome") + "</p></a></div>");
    	  appAnterior = resultSet.getString("nome");

	  }  while (resultSet.next());
	  
      resultSet.close(); 
    }
    else
  	  vmsg = "Não há aplicativos cadastrados para esse usuário.";
	  out.println(vmsg);
  
  }
  catch (SQLException ex)
  {
       vmsg = "xxOcorreu um erro:: " + ex.getMessage();
 	   out.println(vmsg);	   
  } 
  finally
  {
    if(con!=null && !con.isClosed())
       con.close();
  } 
}
%>