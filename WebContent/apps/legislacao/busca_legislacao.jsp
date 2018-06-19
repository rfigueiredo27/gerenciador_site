<% 
request.setCharacterEncoding("UTF-8");
%>

<div id="formulario_busca">
<form name="fbusca" method="post" id="formulario" >

	<div class="flex_box">
        <div id="tipo_legislacao">
            <fieldset>
                <legend>Legisla&ccedil;&atilde;o</legend>
                <select name="tipoAlteraLegislacao" id="tipoAlteraLegislacao" >
                    <option value="0">-----------</option>
                    <option value="1622">TESTE</option>
                    <option value="38">Atos Conjuntos</option>
                    <option value="33">Atos da Presid&ecirc;ncia</option>
                    <option value="39">Atos da Vice-Presid&ecirc;ncia</option>
                    <option value="50">&Iacute;ndice dos Atos da Presid&ecirc;ncia</option>
                    <option value="90">Instru&ccedil;&otilde;es Normativas da Diretoria-Geral</option>
                    <option value="1747">Instru&ccedil;&otilde;es Normativas da Presid&ecirc;ncia</option>
                    <option value="2587">Instru&ccedil;&otilde;es Normativas do TSE</option>
                    <option value="48">Legisla&ccedil;&atilde;o Correlata</option>
                    <option value="47">Legisla&ccedil;&atilde;o Eleitoral</option>
                    <option value="53">Legisla&ccedil;&atilde;o Partid&aacute;ria</option>
                    <option value="44">Ordens de Servi&ccedil;o da Diretoria-Geral</option>
                    <option value="65">Ordens de Servi&ccedil;o da Presid&ecirc;ncia</option>
                    <option value="76">Portarias CFPE</option>
                    <option value="46">Portarias da Diretoria-Geral</option>
                    <option value="2631">Portarias da Ouvidoria</option>
                    <option value="2560">Portarias da SGP</option>
                    <option value="45">Portarias da Presid&ecirc;ncia</option>
                    <option value="49">Portarias da Vice-Presid&ecirc;ncia</option>
                    <option value="2652">Portarias do CNJ</option>
                    <option value="77">Portarias do TSE</option>
                    <option value="2502">Provimentos do CNJ</option>
                    <option value="2434">Resolu&ccedil;&otilde;es do CNJ</option>
                    <option value="20">Resolu&ccedil;&otilde;es do TRE-RJ</option>
                    <option value="36">Resolu&ccedil;&otilde;es do TSE</option>
                </select>
            </fieldset>
        </div>
		<div id="data_legislacao">
			<fieldset>
				<legend>Anos</legend>
				<select name='ano' id='ano'>
<% 
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT to_char(data_inicio_exib, 'yyyy') as data " +
                   "FROM gecoi.conteudo_area ca " +
                   "WHERE ca.id_area in (47,48,53,20,50,33,39,38,45,49,2631,46,2560,1747,90,65,44,2587,36,77,2434,2652,2502,76) " +
   				   "group by to_char(data_inicio_exib, 'yyyy') ORDER BY to_char(data_inicio_exib, 'yyyy') desc";
	PreparedStatement pstm = con.prepareStatement(vsql);
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