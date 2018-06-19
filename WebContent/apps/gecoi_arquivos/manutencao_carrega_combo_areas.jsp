<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import = "java.text.*,java.util.*,java.sql.*" %>

<%
   int vtipo  = (request.getParameter("tipo") == null ? 0 : Integer.parseInt(request.getParameter("tipo")));
   int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer.parseInt(request.getParameter("grupo")));
   int conta_var = 0;
   int conta;
   String vsql;

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
	  						      vsql = "select distinct a.id_area, a.descricao " +
       						             "FROM  gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga " +
								         "where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo ";										 
							  if (vtipo > 0)
							  {
	  						     vsql = vsql + "AND a.tipo_area = ? ";
							  }
							  if (vgrupo > 0)
							  {
	  						     vsql = vsql + "AND g.id_grupo = ? ";
							  }
	  						  vsql = vsql + "ORDER BY a.descricao ";
							  
   	                          PreparedStatement pstm = con.prepareStatement(vsql);				 
							  if (vtipo > 0)
							  {
								 conta_var++;						
								 pstm.setInt(conta_var,vtipo);
							  }
							  if (vgrupo > 0)
							  {
								 conta_var++;
								 pstm.setInt(conta_var,vgrupo);
							  }                                                            							  
							  
							  ResultSet rs = pstm.executeQuery();  

							  out.println("<select class='form-control' name='area' onchange='atualiza_ano();'>");
							  out.println("<option value='0'>------------------------</option>");
							  conta = 0;                              
							  while (rs.next())
	  						  {
								if (conta == 0) 
								{
								   out.println("<option value='-1'>Todas</option>");
								}
								conta++;
								out.println("<option value='" + rs.getString("id_area") + "'>" + rs.getString("descricao") + "</option>");
							  }
							  if (conta == 0) 
								 out.println("<option value='0'>--</option>");
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