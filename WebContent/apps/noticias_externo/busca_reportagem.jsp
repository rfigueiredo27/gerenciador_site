
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
request.setCharacterEncoding("ISO-8859-1");
int vid_area1 = 2661;
int vid_area2 = 42;
int vid_area3 = 22;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT to_char(data_inicio_exib, 'yyyy') as data " +
                   "FROM gecoi.conteudo_area ca " +
                   "WHERE ca.id_area in (?,?,?) " +
   				   "group by to_char(data_inicio_exib, 'yyyy') ORDER BY to_char(data_inicio_exib, 'yyyy') desc";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area1);
	pstm.setInt(2, vid_area2);
	pstm.setInt(3, vid_area3);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			out.print("<option value='" + resultSet.getString("data") + "'>" + resultSet.getString("data") + "</option>");
		}while (resultSet.next());
	}
	resultSet.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
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