<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import = "java.text.*,java.util.*,java.sql.*" %>

<%
   int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer.parseInt(request.getParameter("grupo")));
   int varquivoreferencia = (request.getParameter("idarquivoreferencia") == null ? 0 : Integer.parseInt(request.getParameter("idarquivoreferencia")));
   int varquivoprincipal = (request.getParameter("idarquivoprincipal") == null ? 0 : Integer.parseInt(request.getParameter("idarquivoprincipal")));
   boolean continua = true;
   String vsql = "";
   PreparedStatement pstm = null;
   ResultSet rs = null;

   try
   {
	  vsql = "";  
		//Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				Connection con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

         vsql = "Insert Into gecoi.referencia(id_arquivo_principal, id_arquivo_referencia, data_inclusao, logon_usuario, id_grupo, id_cruzada) Values(?, ?, sysdate, ?, ?, 0) ";
								 
         pstm = con.prepareStatement(vsql);				 
         pstm.setInt(1,varquivoprincipal);
         pstm.setInt(2,varquivoreferencia);
         pstm.setString(3,vlogin);
         pstm.setInt(4,vgrupo);
         rs = pstm.executeQuery();  
		 rs.close();
							        
      // fecha os objetos 
      con.close();
      out.println("<span class='inserida'><input type='button' id='btn' class='btn btn-danger' value='inserido' /></span>");
//      out.println("<script language='javascript'>");
//      out.println("top.atualizaCombos();");
//      out.println("top.carregaRegistros();");
//      out.println("</script>");
	}
   catch (Exception erro)
   {
      out.println(erro.getMessage());
   }
%>
