<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import = "java.text.*,java.util.*,java.sql.*" %>
<%
   int vtipo  = Integer.parseInt(request.getParameter("tipo"));

                            try
							{
                            	//Configurando a conexão com o banco
                         	   String vlogin = session.getAttribute("login").toString();
                         	   String vsenha = session.getAttribute("senha").toString();
                         	   Class.forName("oracle.jdbc.driver.OracleDriver");
                         	   Parametros parametros = new Parametros(
                         				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
                         				Connection con = new ConnectionFactory().getConnection(
                         				parametros.getBanco(), vlogin, vsenha);
							   
	  						   String vsql = "select DISTINCT g.id_grupo, g.descricao " +
       						                 "FROM gecoi.grupo g, gecoi.grupo_area ga, gecoi.area a " +
											 "Where g.id_grupo = ga.id_grupo and ga.id_area = a.id_area ";
							
							  if (vtipo > 0)
							  {
	  						     vsql = vsql + "AND a.tipo_area = ? ";
							  }
	  						  vsql = vsql + "ORDER BY g.descricao ";
							  
   	                          PreparedStatement pstm = con.prepareStatement(vsql);				 
							  if (vtipo > 0)
							  {
								 pstm.setInt(1,vtipo);
							  }
							  
							  ResultSet rs = pstm.executeQuery();  

							  out.println("<select name='grupo' class='form-control' onchange='atualiza_area();'>");
							  out.println("<option value='-2'>--</option>"); 						      
							  //out.println("<option value='-1'>Todas</option>"); 						      
							  while (rs.next())
	  						  {
								out.println("<option value='" + rs.getString("id_grupo") + "'>" + rs.getString("descricao") + "</option>");
							  }
         					  out.println("</select>");
							  
					          // fecha os objetos 
                              rs.close();
                              con.close();
							}
                            catch (Exception erro)
                            {
                                 out.println(erro.getMessage());
                            }
%>
