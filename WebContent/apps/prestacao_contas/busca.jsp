<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>
<div id="formulario_busca">
<%int id_area = 2694;%>

<form name="fbusca" method="post" id="formulario" >
	<div class="flex_box">
		<div id="ano_busca">
			<fieldset>
				<legend>Ano da Prestação de Contas</legend>
				<select name='ano' id='ano'>
<% 
request.setCharacterEncoding("UTF-8");

//Prepara as variáveis para o acesso ao banco
Connection conexao;
PreparedStatement stm;
ResultSet rs;

try
{
	
	//Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
	   conexao = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);

	String vsql = "SELECT to_char(data_inicio_exib, 'yyyy') as data " +
                   "FROM gecoi.conteudo_area ca " +
                   "WHERE ca.id_area in (?) " +
   				   "group by to_char(data_inicio_exib, 'yyyy') ORDER BY to_char(data_inicio_exib, 'yyyy') desc";
	stm = conexao.prepareStatement(vsql);
	stm.setInt(1, id_area);
	rs = stm.executeQuery();
   
	if ( rs.next() )
	{
		do 
		{
			out.print("<option value='" + rs.getString("data") + "'>" + rs.getString("data") + "</option>");
		}while (rs.next());
	}
	rs.close();
	stm.close();
	conexao.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}

%>
				</select>
			</fieldset>
		</div>
	</div>
    <div id="botao">
			 <input type="button" name="buscar" id="buscar" value="Buscar" onclick="top.listar(this.form);" />
		</div>
</form>
<br />
</div>
<div id="resultado"></div>