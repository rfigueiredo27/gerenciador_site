<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>


<%

String vmsg    = ""; //mensagem para o usuário
String vsql    = ""; //instrução da consulta ao banco
int varea      = 0;  //id da área
int vgrupo     = 0;  //id do grupo
int vtipo      = 0;  //id do tipo de arquivo
int vprincipal  = 0;  //id do arquivo principal
int contaParam = 0;
int vano       = 0;

   //Recebe os parâmetros do formulário
   varea     =  (request.getParameter("area")==null) ? 0 : Integer.parseInt(request.getParameter("area").toString());
   vgrupo    =  (request.getParameter("grupo")==null) ? 0 : Integer.parseInt(request.getParameter("grupo").toString());
   vtipo     =  (request.getParameter("tipo")==null) ? 0 : Integer.parseInt(request.getParameter("tipo").toString());

   try
   {
   //Prepara as variáveis para o acesso ao banco
   Connection con;
   PreparedStatement pstm;
   ResultSet resultSet;
   
 //Configurando a conexão com o banco
   String vlogin = session.getAttribute("login").toString();
   String vsenha = session.getAttribute("senha").toString();
   Class.forName("oracle.jdbc.driver.OracleDriver");
   Parametros parametros = new Parametros(
			new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
			con = new ConnectionFactory().getConnection(
			parametros.getBanco(), vlogin, vsenha);   
   
        //seleciona os anos que tem arquivos cadastrados
        vsql = "SELECT distinct To_Char(ca.data_inicio_exib,'yyyy') as ano " +
               "FROM gecoi.area a, gecoi.grupo g, gecoi.grupo_area ga, gecoi.conteudo_area ca " +
               "where a.id_area = ga.id_area and ga.id_grupo = g.id_grupo AND a.id_area = ca.id_area ";			   
			   
	   if (varea > 0)
	   {
		   vsql = vsql + "AND a.id_area = ? ";
	   }
	   if (vgrupo > 0)
	   {
		   vsql = vsql + "AND g.id_grupo = ? ";
	   }
	   if (vtipo > 0)
	   {
		   vsql = vsql + "AND a.tipo_area = ? ";
	   }
		 
	   vsql = vsql + "order by 1 desc ";

        pstm = con.prepareStatement(vsql);
		if (varea > 0)
		{
			contaParam++;
            pstm.setInt(contaParam,varea);
		}
		if (vgrupo > 0)
		{
			contaParam++;
        	pstm.setInt(contaParam,vgrupo);
		}
		if (vtipo > 0)
		{
			contaParam++;
        	pstm.setInt(contaParam,vtipo);
		}

     resultSet = pstm.executeQuery();

     //out.println("<select name='ano' onchange='limpaConteudos();'>");
	 out.println("<select name='ano2' id='ano2' class='form-control'>");
	 if ( resultSet.next() )
     {
        out.println("<option value='0'>Todos</option>");
		do
		{
	       	out.println("<option value='" + resultSet.getString("ano") + "'>" + resultSet.getString("ano") + "</option>");
		}while(resultSet.next());
	 }
	 else
	 {
	    out.println("<option value='-10' selected>Não há arquivos disponíveis</option>");
	 }

     out.println("</select>");

     resultSet.close(); 
 	 con.close();

   }
   catch (Exception ex)
   {
      out.println("<select name='ano'>");
      out.println("<option>"+ex.getMessage()+"</option>");
      out.println("</select>");
   }
%>

