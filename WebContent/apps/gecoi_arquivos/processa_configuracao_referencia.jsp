<%@page import="br.jus.trerj.funcoes.UltimasNoticiasSemImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasComImagem"%>
<%@page import="br.jus.trerj.funcoes.UltimasNoticiasInternet"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page
	import="java.text.*,java.util.*,java.sql.*"%>
<%
   int vacao = (request.getParameter("acao") == null ? 0 : Integer.parseInt(request.getParameter("acao")));
   int vprincipal = (request.getParameter("principal") == null ? 0 : Integer.parseInt(request.getParameter("principal")));   
   int conta = 0;
   int vcruzada = (request.getParameter("cruzada") == null ? 0 : Integer.parseInt(request.getParameter("cruzada")));   
   int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer.parseInt(request.getParameter("grupo")));
   boolean continua = true;
   String vmsg = "";
   String vsql = "";
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
	  con.setAutoCommit(false);
	  /*	  
	  //pego o grupo do usuario logado
      vsql = "SELECT id_grupo " +
			 "FROM gecoi.permissao " +
			 "WHERE upper(logon_usuario) = Upper(?) ";

      pstm = con.prepareStatement(vsql);
      pstm.setString(1,vlogin);

      rs = pstm.executeQuery();
	  rs.next();
	  vgrupo = rs.getInt("id_grupo");
*/	  
      vsql = "select count(id_arquivo_referencia) as conta from gecoi.referencia Where id_arquivo_principal = ? ";
      pstm = con.prepareStatement(vsql);
      pstm.setInt(1,vprincipal);
      rs = pstm.executeQuery();
	  rs.next();

	  int[] acruzada = new int[rs.getInt("conta")];
	  if ((vacao == 1) || ((vacao == 2) && vcruzada == 0))
	  {
		 vmsg = "Inclusão das referências cruzadas - um para um realizada com sucesso.";
		 
	  	 if (vcruzada == 0)
		 {
		 	vsql = "SELECT gecoi.sq_cruzada.nextval as proximo from dual";
         	pstm = con.prepareStatement(vsql);				 
      	 	rs = pstm.executeQuery();
	  	 	rs.next();
	  	 	vcruzada = rs.getInt("proximo");
			
			vsql = "update gecoi.referencia set id_cruzada = ? Where id_arquivo_principal = ? ";
         	pstm = con.prepareStatement(vsql);				 
         	pstm.setInt(1,vcruzada);
         	pstm.setInt(2,vprincipal);
         	pstm.executeQuery();  
		 }
		 
         vsql = "select id_arquivo_referencia from gecoi.referencia Where id_arquivo_principal = ? order by id_arquivo_referencia";								 
         pstm = con.prepareStatement(vsql);				 
         pstm.setInt(1,vprincipal);
         rs = pstm.executeQuery();  
		 
		 while (rs.next())
		 {			 
			 vsql = "Insert Into gecoi.referencia(id_arquivo_principal, id_arquivo_referencia, data_inclusao, logon_usuario, id_grupo, id_cruzada) Values(?, ?, sysdate, ?, ?, ?) ";
			 pstm = con.prepareStatement(vsql);				 
			 pstm.setInt(1,rs.getInt("id_arquivo_referencia"));
			 pstm.setInt(2,vprincipal);
			 pstm.setString(3,vlogin);
			 pstm.setInt(4,vgrupo);
			 pstm.setInt(5,vcruzada);
			 pstm.executeQuery();  			 
			 acruzada[conta] = rs.getInt("id_arquivo_referencia");
			 conta++;
		 }
		 rs.close();
	  }
	  
	  if (vacao == 2)
	  {
		  vmsg = "Inclusão das referências cruzadas - um para muitos realizada com sucesso.";
		  conta = 0;
		  if (vcruzada != 0) // quando a vcruzada = 0 o array acruzada foi carregado no loop anterior
		  {
          	vsql = "select id_arquivo_referencia from gecoi.referencia Where id_arquivo_principal = ? order by id_arquivo_referencia";								 
          	pstm = con.prepareStatement(vsql);				 
          	pstm.setInt(1,vprincipal);
          	rs = pstm.executeQuery();  		 
		  	while (rs.next())
		  	{
			 	acruzada[conta] = rs.getInt("id_arquivo_referencia");
			 	conta++;
		  	}
		  	rs.close();
		  }
		  
		  for (int i = 0; i <= acruzada.length-1; i++)
		  {
			  for (int j = i + 1; j <= acruzada.length-1; j++)
			  {
				  	vsql = "Insert Into gecoi.referencia(id_arquivo_principal, id_arquivo_referencia, data_inclusao, logon_usuario, id_grupo, id_cruzada) Values(?, ?, sysdate, ?, ?, ?) ";
			 		pstm = con.prepareStatement(vsql);				 
			 		pstm.setInt(1,acruzada[i]);
			 		pstm.setInt(2,acruzada[j]);
			 		pstm.setString(3,vlogin);
			 		pstm.setInt(4,vgrupo);
					pstm.setInt(5,vcruzada);
			 		pstm.executeQuery();  
			 	
			 		vsql = "Insert Into gecoi.referencia(id_arquivo_principal, id_arquivo_referencia, data_inclusao, logon_usuario, id_grupo, id_cruzada) Values(?, ?, sysdate, ?, ?, ?) ";
			 		pstm = con.prepareStatement(vsql);				 
			 		pstm.setInt(1,acruzada[j]);
			 		pstm.setInt(2,acruzada[i]);
			 		pstm.setString(3,vlogin);
			 		pstm.setInt(4,vgrupo);
					pstm.setInt(5,vcruzada);
			 		pstm.executeQuery();  
			  }
		  }
	  }	  
	  if (vacao == 3)
	  {
		 vmsg = "Exclusão das referências cruzadas realizada com sucesso."; 
								 
         vsql = "DELETE FROM gecoi.referencia WHERE id_cruzada = ? and id_arquivo_principal <> ? ";
         pstm = con.prepareStatement(vsql);				 
		 pstm.setInt(1,vcruzada);
		 pstm.setInt(2,vprincipal);
         pstm.executeQuery();  
		 
         vsql = "update gecoi.referencia set id_cruzada = 0 WHERE id_cruzada = ? and id_arquivo_principal = ? and id_grupo = ?";
         pstm = con.prepareStatement(vsql);				 
		 pstm.setInt(1,vcruzada);
		 pstm.setInt(2,vprincipal);
		 pstm.setInt(3,vgrupo);
         pstm.executeQuery();  
	  }
	  
      // fecha os objetos 
	  con.commit();

	  	UltimasNoticiasComImagem ultimasNoticiasComImagem = new UltimasNoticiasComImagem();
		vmsg = ultimasNoticiasComImagem.ultimasTV(
				session.getAttribute("login").toString(), session
						.getAttribute("senha").toString());

		UltimasNoticiasSemImagem ultimasNoticiasSemImagem = new UltimasNoticiasSemImagem();
		vmsg = ultimasNoticiasSemImagem.ultimas(
				session.getAttribute("login").toString(), session
						.getAttribute("senha").toString());

		UltimasNoticiasInternet ultimasNoticiasInternet = new UltimasNoticiasInternet();
		vmsg = ultimasNoticiasInternet.ultimasTV(
				session.getAttribute("login").toString(), session
						.getAttribute("senha").toString());

      con.close();
      out.println("<span class='badge'><h4 class='display-4'>" + vmsg + "</h4></span>");
	  out.println("<script language='javascript'>parent.document.configuracao.bOK.disabled=true;");
	  if (vacao == 1)
	  {
		  out.println("parent.document.configuracao.radio1.disabled=true;");
		  out.println("parent.document.configuracao.radio2.disabled=false;");
		  out.println("parent.document.configuracao.radio3.disabled=false;");
		  out.println("parent.document.configuracao.cruzada.value=" + vcruzada + ";");
	  }
	  if (vacao == 2)
	  {
		  out.println("parent.document.configuracao.radio1.disabled=true;");
		  out.println("parent.document.configuracao.radio2.disabled=true;");
		  out.println("parent.document.configuracao.radio3.disabled=false;");
		  out.println("parent.document.configuracao.cruzada.value=" + vcruzada + ";");
	  }
	  if (vacao == 3)
	  {
		  out.println("parent.document.configuracao.radio1.disabled=false;");
		  out.println("parent.document.configuracao.radio2.disabled=false;");
		  out.println("parent.document.configuracao.radio3.disabled=true;");
		  vcruzada = 0;
		  out.println("parent.document.configuracao.cruzada.value=" + vcruzada + ";");
	  }
	  out.println("</script>");
	}
   catch (Exception erro)
   {
      //out.println(erro.getMessage() + vsql);
	  out.println("Erro na configuração." + erro.getMessage() + vsql);
   }
%>
