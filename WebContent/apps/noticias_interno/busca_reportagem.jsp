<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page import="java.sql.*,java.io.*"%>

<div id="formulario_busca">
<form name="fbusca" method="post" id="formulario" >

	<div class="flex_box">
        <div id="secao_reportagem">
            <fieldset>
                <legend>Ambiente da Publica&ccedil;&atilde;o</legend>
                <select name="ambienteAlteraReportagem" id="ambienteAlteraReportagem" >
                    <option value="2661" selected="selected">Internet e Intranet</option>
                    <option value="42">Internet</option>
                    <option value="22">Intranet</option>
                </select>
            </fieldset>
        </div>
		<div id="secao_reportagem">
			<fieldset>
				<legend>Anos</legend>
				<select name='ano' id='ano'>
<% 
request.setCharacterEncoding("UTF-8");
int vid_area1 = 2661;
int vid_area2 = 42;
int vid_area3 = 22;
int vid_area4 = 2662;

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
                   "WHERE ca.id_area in (?,?,?,?) " +
   				   "group by to_char(data_inicio_exib, 'yyyy') ORDER BY to_char(data_inicio_exib, 'yyyy') desc";
	stm = conexao.prepareStatement(vsql);
	stm.setInt(1, vid_area1);
	stm.setInt(2, vid_area2);
	stm.setInt(3, vid_area3);
	stm.setInt(4, vid_area4);
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