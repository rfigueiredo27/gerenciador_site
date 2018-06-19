<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import = "java.text.*,java.util.*,java.sql.*" %>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_arquivos/DataTable/js/referencia.js"></script>
<h3>Resultados da Busca</h3>

<%
   int vprincipal  = (request.getParameter("pprincipal") == null ? 0 : Integer.parseInt(request.getParameter("pprincipal")));
   int vtipo  = (request.getParameter("ptipo") == null ? 0 : Integer.parseInt(request.getParameter("ptipo")));
   int varea  = (request.getParameter("parea") == null ? 0 : Integer.parseInt(request.getParameter("parea")));
   int vgrupo = (request.getParameter("pgrupo") == null ? 0 : Integer.parseInt(request.getParameter("pgrupo")));
   int vano   = (request.getParameter("pano") == null ? 0 : Integer.parseInt(request.getParameter("pano")));
   String vtexto = (request.getParameter("pchave") == null ? "" : request.getParameter("pchave"));
   int conta_var = 1;
   String vselecao = "";                       //determina a aba que ficará selecionanda
   String vestilo  = "style='display: none;'"; //determina se o conteúdo da aba ficará visível ou não
   int num_ano     = 0;                        //recebe numero do ano
   int num_aba     = 0;                        //recebe o indice da aba e da layer
   int qtd_aba     = 0;                        //recebe a quantidade total de abas
   int tot_arq     = 0;                        //recebe a quantidade total de arquivos por mês
   String vsql     = "";
   boolean zebra   = true;
   
   Connection con;
   PreparedStatement pstm;
   ResultSet resultSet;
   
//    out.println(vprincipal);
//    out.println(vtipo);
//    out.println(vgrupo);
//    out.println(varea);
//    out.println(vano);
//    out.println(vtexto);
   
   
   try
   {
	 //Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);
	
      

//       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       // Identifica a quantidade de anos
// 		  vsql = "SELECT Count(*) AS qtd FROM (SELECT Count(To_Char(ca.data_inicio_exib,'yyyy')) AS ano " +
// 	             "FROM gecoi.arquivo aq, gecoi.area a, gecoi.conteudo_area ca, gecoi.grupo g, gecoi.grupo_area ga " +
// 	             "WHERE aq.id_conteudo = ca.id_conteudo AND ca.id_Area = a.id_area " +
// 	             "AND a.id_area = ga.id_area AND ga.id_grupo = g.id_grupo " +
//  				 "AND aq.id_arquivo NOT IN (SELECT r.id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = ?) " +
//  				 "AND aq.id_arquivo <> ? ";
// 		  if (!vtexto.equals(""))
//           {
//               vsql = vsql + "and Upper(aq.descricao) like Upper(?) "; 
//               vtexto = "%" + vtexto + "%";
//           }
//       if (vtipo > 0)
// 	  {
// 	      vsql = vsql + "AND a.tipo_area = ? ";
// 	  }
// 	  if (varea > 0)
// 	  {
// 	     vsql = vsql + "AND a.id_area = ? ";
// 	  }
// 	  if (vgrupo > 0)
// 	  {
// 	     vsql = vsql + "AND g.id_grupo = ? ";
// 	  }                                                            							  							  
// 	  if (vano > 0)
// 	  {
// 	     vsql = vsql + "AND To_Char(ca.data_inicio_exib,'yyyy') = ? ";
// 	  }                                                            							  							  

//       vsql = vsql + "GROUP BY To_Char(ca.data_inicio_exib,'yyyy')) ";
//       pstm = con.prepareStatement(vsql);
//       pstm.setInt(1,vprincipal);
//       pstm.setInt(2,vprincipal);
// 	  conta_var = 2;
//       if (!vtexto.equals(""))
//       {
//          conta_var++;
//          pstm.setString(conta_var,vtexto);
//       }
//       if (vtipo > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vtipo);
//       }
//       if (varea > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,varea);
//       }
//       if (vgrupo > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vgrupo);
//       }                                                            							  
//       if (vano > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vano);
//       }                                                            							  
							  
//       resultSet = pstm.executeQuery();  

// 	  if (resultSet.next())
// 	      qtd_aba = Integer.valueOf(resultSet.getString("qtd"));

//       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       // Seleciona os anos
// 		  vsql = "SELECT distinct To_Char(ca.data_inicio_exib, 'yyyy') as ano " +
// 	             "FROM gecoi.arquivo aq, gecoi.area a, gecoi.conteudo_area ca, gecoi.grupo g, gecoi.grupo_area ga " +
// 	             "WHERE aq.id_conteudo = ca.id_conteudo AND ca.id_Area = a.id_area " +
// 	             "AND a.id_area = ga.id_area AND ga.id_grupo = g.id_grupo " +
// 				 "AND aq.id_arquivo NOT IN (SELECT r.id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = ?) " +
//  				 "AND aq.id_arquivo <> ? ";
// 		  if (!vtexto.equals(""))
//           {
//               vsql = vsql + "and Upper(aq.descricao) like Upper(?) "; 
//               vtexto = "%" + vtexto + "%";
//           }
//       if (vtipo > 0)
// 	  {
// 	      vsql = vsql + "AND a.tipo_area = ? ";
// 	  }
// 	  if (varea > 0)
// 	  {
// 	     vsql = vsql + "AND a.id_area = ? ";
// 	  }
// 	  if (vgrupo > 0)
// 	  {
// 	     vsql = vsql + "AND g.id_grupo = ? ";
// 	  }                                                            							  
// 	  if (vano > 0)
// 	  {
// 	     vsql = vsql + "AND To_Char(ca.data_inicio_exib,'yyyy') = ? ";
// 	  }                                                            							  							  

//       vsql = vsql + "ORDER BY To_Char(ca.data_inicio_exib,'yyyy') ";
//       pstm = con.prepareStatement(vsql);
//       pstm.setInt(1,vprincipal);
//       pstm.setInt(2,vprincipal);
// 	  conta_var = 2;
//       if (!vtexto.equals(""))
//       {
//          conta_var++;
//          pstm.setString(conta_var,vtexto);
//       }
//       if (vtipo > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vtipo);
//       }
//       if (varea > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,varea);
//       }
//       if (vgrupo > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vgrupo);
//       }                                                            							  
//       if (vano > 0)
//       {
//          conta_var++;
//          pstm.setInt(conta_var,vano);
//       }                                                            							  
							  
//       resultSet = pstm.executeQuery();  
	
// 	  if (resultSet.next())
// 	  {
        
// 		 //out.println("<div class='promotion'>");
//          //out.println("<div class='tabs'><ul>");
	          
// 		 do
// 		 {
// 			  num_aba = num_aba + 1;
			  
// 			  if (num_aba==qtd_aba)
// 			      vselecao = "class='selected'";
				  
// 			  //out.println("<li id='A" + num_aba + "' style='z-index: " + num_aba + ";' " + vselecao + " >");
// 			  //out.println("<a onclick=\"switchTab('A','C', " + num_aba + ", " + qtd_aba + ", 'SS');\">" + resultSet.getString("ano") + "</a></li>");                                    			  
			  
// 		 }while (resultSet.next());
		 
// 		  //out.println("</ul></div>");
// 	  }

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	  //seleciona os avisos com os parâmetros informados
		  vsql = "SELECT distinct aq.id_conteudo, aq.descricao, To_Char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, To_Char(ca.data_inicio_exib,'mm') AS mes, "+
		         "To_Char(ca.data_inicio_exib,'yyyy') AS Ano, aq.id_arquivo, To_Char(ca.data_inicio_exib,'dd') as dia, decode(aq.ordem,0,'Principal','Anexo') as Tipo " +
	             "FROM gecoi.arquivo aq, gecoi.area a, gecoi.conteudo_area ca, gecoi.grupo g, gecoi.grupo_area ga " +
	             "WHERE aq.id_conteudo = ca.id_conteudo AND ca.id_Area = a.id_area " +
	             "AND a.id_area = ga.id_area AND ga.id_grupo = g.id_grupo " +
 				 "AND aq.id_arquivo NOT IN (SELECT r.id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = ?) " +
 				 "AND aq.id_arquivo <> ? ";
		  if (!vtexto.equals(""))
          {
              vsql = vsql + "and Upper(aq.descricao) like Upper(?) "; 
              vtexto = "%" + vtexto + "%";
          }
      if (vtipo > 0)
	  {
	      vsql = vsql + "AND a.tipo_area = ? ";
	  }
	  if (varea > 0)
	  {
	     vsql = vsql + "AND a.id_area = ? ";
	  }
	  if (vgrupo > 0)
	  {
	     vsql = vsql + "AND g.id_grupo = ? ";
	  }                                                            							  
	  if (vano > 0)
	  {
	     vsql = vsql + "AND To_Char(ca.data_inicio_exib,'yyyy') = ? ";
	  }                                                            							  							  

      vsql = vsql + "ORDER BY To_Char(ca.data_inicio_exib,'yyyy'), To_Char(ca.data_inicio_exib,'mm'), To_Char(ca.data_inicio_exib,'dd') ";
	  if (vtipo == 3) // album
	  {
		  vsql = vsql + ", aq.descricao";
	  }
	  else
	  {
		  vsql = vsql + ", aq.descricao";
	  }

      pstm = con.prepareStatement(vsql);
      pstm.setInt(1,vprincipal);
      pstm.setInt(2,vprincipal);
	  conta_var = 2;
      if (!vtexto.equals(""))
      {
         conta_var++;
         pstm.setString(conta_var,vtexto);
      }
      if (vtipo > 0)
      {
         conta_var++;
         pstm.setInt(conta_var,vtipo);
      }
      if (varea > 0)
      {
         conta_var++;
         pstm.setInt(conta_var,varea);
      }
      if (vgrupo > 0)
      {
         conta_var++;
         pstm.setInt(conta_var,vgrupo);
      }                                                            							  
      if (vano > 0)
      {
         conta_var++;
         pstm.setInt(conta_var,vano);
      }                                                            							  
							  
      resultSet = pstm.executeQuery();  
	  
	  resultSet.next();
	  num_ano = Integer.parseInt(resultSet.getString("ano"));
	  
	  num_aba = 1;

      if(qtd_aba==num_aba)
	     vestilo="";
	  out.println("<input type='hidden' name='acao' id='acao' value='' /><input type='hidden' name='idprincipal' id='idprincipal' value='" + vprincipal + "' />");
      //cabeçalho da tabela
	  //out.println("</br><div class='productInformation'>");
      //out.println("<div class='ficheTechnique' id='C" + num_aba + "' " + vestilo + ">");
	  out.println("<table id='referencia' class='table table-striped table-bordered' cellspacing='0' width='100%'><thead><tr>");
      out.println("<th scope='col'>TIPO</th>");
      out.println("<th scope='col'>T&Iacute;TULO</th>");
	  if (vtipo == 3)
	     out.println("<th scope='col'>VISUALIZAR</th><th scope='col'>A&Ccedil;&Atilde;O</th></tr></thead><tbody>");
	  else
         out.println("<th scope='col'>A&Ccedil;&Atilde;O</th></tr></thead><tbody>");
		 

      do
	  {
		 if (num_ano != Integer.parseInt(resultSet.getString("ano")) && num_ano > 0)
	     {
            //cabeçalho da tabela
			num_aba = num_aba + 1;
			
 		    if (num_aba==qtd_aba)
			   vestilo="";

			out.println("");
            out.println("</tbody></table></div><div class='ficheTechnique' id='C" + num_aba + "' " + vestilo + ">");           
 		    out.println("<table id='referencia' class='table table-striped table-bordered' cellspacing='0' width='100%'><thead><tr>");
            out.println("<th scope='col'>TIPO</th>");
            out.println("<th scope='col'>T&Iacute;TULO</th>");
            out.println("<th scope='col' colspan='2'>A&Ccedil;&Atilde;O</th></tr></thead><tbody>");

			tot_arq = 1;
		 }
		 else
            tot_arq = tot_arq+1;				
           if (zebra)
		   {
		    //out.println("<tr bgcolor='#eeeeee'>");
		   }
		   else
		   //out.println("<tr bgcolor='#ffffff'>");
		   	zebra=!zebra;

		 out.println("<td width='10%'>" + resultSet.getString("tipo") + "</td>");
		 out.println("<td width='80%'>" + resultSet.getString("descricao") + "</td>");
         
		 if (vtipo == 3)
		    out.println("<td align='center'><a href='/gecoi.3.0/apps/gecoi_arquivos/download_arquivo_reduzido.jsp?idarquivo=" + resultSet.getString("id_arquivo") +  "&keepThis=true&TB_iframe=false&height=300&width=400;' class='thickbox' title='Visualização do Arquivo' alt='Visualização do Arquivo' target='_blank'><img src='/gecoi.3.0/img/consulta.png' alt='Visualizar' border='0'></a>&nbsp;</td>");		 
		 out.println("<td width='10%'>");		 
		 out.println("<div align='center' id='divbotao" + resultSet.getString("id_arquivo") + "'>");
		 out.println("<input type='button' id='btn' class='btn btn-success'"  + resultSet.getString("id_arquivo")  + "' onclick='insere_referencia2(" + vprincipal + "," + resultSet.getString("id_arquivo") + "," + vgrupo + ");' value='inserir' />");
		 out.println("</div>");
		 out.println("</td></tr>");

 	     num_ano = Integer.parseInt(resultSet.getString("ano"));
	  }while(resultSet.next());

 	  if (vtipo == 3)
	     out.println("");
	  else
	     out.println("");
      out.println("</tbody></table></div></div>");
	 
      resultSet.close(); 
 	  con.close();

   }
   catch (Exception ex)
   {
	  if (ex.getMessage().compareToIgnoreCase("Conjunto de Resultados Esgotado")==0)
  	     out.println("<p class='destaque' align='center' >Não foram encontrados registros com os parâmetros informados.</p><p>&nbsp;</p>");
	  else
         out.println("<p class='destaque' align='center' >" + ex.getMessage() + vsql + vprincipal + varea + "</p><p>&nbsp;</p>");
   }

%>