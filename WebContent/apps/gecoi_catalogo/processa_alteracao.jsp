<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>

<%
	//criação de variáveis

	int vidconteudo = 0; //id do conteudo para gravar o arquivo
	int vidcatalogo = 0; //
	int vidarquivo = 0; //
	String descricao = "";
	
	//recupera os parâmetros
	vidconteudo = Integer.parseInt(request.getParameter("idConteudo"));
	vidcatalogo = Integer.parseInt(request.getParameter("idCatalogo"));
	descricao = request.getParameter("descricao");
	
	out.print(vidconteudo);
	out.print(vidarquivo);
	out.print(vidcatalogo);

	////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Se ação for igual a excluir
	////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Prepara as variáveis para o acesso ao banco
	Connection con;
	PreparedStatement pstm;

	try {
		//Configurando a conexão com o banco
		String vlogin = session.getAttribute("login").toString();
		String vsenha = session.getAttribute("senha").toString();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
		con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

			/////////////////////////////////////////////////////////////////////////////////////////////////////
			//Atualiza a tabela de conteudo_assunto
			String vsql = "update gecoi.conteudo_catalogo set id_catalogo=?, descricao=? " + 
			"where id_conteudo=? and id_catalogo = ?";
			pstm = con.prepareStatement(vsql);
			pstm.setInt(1,vidcatalogo);
			pstm.setString(2,descricao);
			pstm.setInt(3,vidconteudo);	    
			pstm.setInt(4,vidcatalogo);

		pstm.executeQuery();

		con.commit();
		con.close();

		
	} catch (Exception ex) {
		String vmsg = "Não foi possível atualizar a tabela conteudo_catalogo. Ocorreu o seguinte erro: "
				+ ex.getMessage();
	}
%>

