<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.text.*,java.util.*,java.sql.*"%>

<%
int vcatalogo = (request.getParameter("idcatalogo") == null ? 0 : Integer.parseInt(request.getParameter("idcatalogo")));
int vconteudo = (request.getParameter("idconteudo") == null ? 0 : Integer.parseInt(request.getParameter("idconteudo")));
int varquivo = (request.getParameter("idarquivo") == null ? 0 : Integer.parseInt(request.getParameter("idarquivo")));
boolean continua = true;
String vsql;
PreparedStatement pstm;
ResultSet rs;
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

				// antes de inserir na tabela conteudo_catalogo eu verifico se já existe o conteúdo (apenas para álbum)
				  if (varquivo == 0)
				  {
			         vsql = "Insert Into gecoi.conteudo_catalogo(id_conteudo, id_catalogo, descricao) Values(?, ?, null) ";
											 
			         pstm = con.prepareStatement(vsql);				 
			         pstm.setInt(1,vconteudo);
			         pstm.setInt(2,vcatalogo);
			         rs = pstm.executeQuery();  
					 rs.close();
				  }
				  else
				  {
					  vsql = "Insert Into gecoi.arquivo_catalogo(id_conteudo, id_arquivo, id_catalogo, descricao) Values(?, ?, ?, null) ";
					  pstm = con.prepareStatement(vsql);
					  pstm.setInt(1,vconteudo);
					  pstm.setInt(2,varquivo);
					  pstm.setInt(3,vcatalogo);
					  rs = pstm.executeQuery();  		  
					  rs.close();
				  }
										        
			      // fecha os objetos 
			      con.close();
			      out.println("<span class='inserida'><input type='button' id='btn' class='btn btn-danger' value='inserido' /></span>");
//			      out.println("<script language='javascript'>");
//			      out.println("top.atualizaCombos();");
//			      out.println("top.carregaRegistros();");
//			      out.println("</script>");
				}
			   catch (Exception erro)
			   {
			      out.println(erro.getMessage());
			   }
			%>
