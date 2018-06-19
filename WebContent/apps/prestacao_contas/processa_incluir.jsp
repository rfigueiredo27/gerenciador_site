<%@page import="java.sql.PreparedStatement"%>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>
<%String vidarea = "2694";%>
<script language="javascript" type="text/javascript">
function carregaRegistrosEliminacao(f)
{
   document.getElementById("gestao").innerHTML = "<div align='center' style='padding:20px;'><img src='/images/loading.gif' alt='Carregando Resultados'></div>";

   valor = Math.random();
   parametros = "?ano=" + f.ano.value + "&area=<%=vidarea%>";
   pag        = "/site/servicos_judiciais/publicacoes_oficiais/comunicacoes_judiciais/lista_execucao.jsp"
   $.post(pag + parametros, function(resposta){$("#gestao").html(resposta);});
}

</script>
<noscript><p>Seu navegador não suporta a execução de scripts ou está que está função desabilitada.</p></noscript>
<div id="texto">
<form name="form1" id="form1">
<fieldset>
<legend>Filtros</legend>


<div id="ano">
   <label for="ano">Ano:&nbsp;</label>
   <select name="ano" id="ano" onchange="atualiza_mes(this.form);">
   <option value="0" >----</option>

<%

try
{
   //Configurando a conexão com o banco
   Class.forName("oracle.jdbc.driver.OracleDriver");
   con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

   //Acessando os dados no banco
   String vsql = "SELECT to_char(ca.data_inicio_exib, 'yyyy') as ano " +
                 "from gecoi.conteudo_area ca, gecoi.area ar " +
                 "where ca.id_area = ar.id_area and ar.id_area in (?) " +
                 "GROUP BY to_char(ca.data_inicio_exib, 'yyyy') " + 
                 "order by to_char(ca.data_inicio_exib, 'yyyy') desc ";

   PreparedStatement pstm = con.prepareStatement(vsql);
   pstm.setString(1,vidarea);

   resultSet = pstm.executeQuery();

   //Se encontrou o registro
   if(resultSet.next())
   {

	 do 
	 {
		 out.println("<option value='" + resultSet.getString("ano") + "' >" + resultSet.getString("ano") + "</option>");
	 }while (resultSet.next());
	 
   }
   else
   {
     out.println("O arquivo não foi encontrado."); 
   }
   resultSet.close(); 
}
catch (Exception ex)
{
    out.println("Ocorreu um erro: " + ex.getMessage());
} 
finally
{
    if(con!=null && !con.isClosed())
       con.close(); 	
}

%>
    </select>
</div>


<div id="div_botao">
<input type="button" id="botao" name="pesquisar"   class="form-text"  value="Pesquisar" onclick="carregaRegistrosEliminacao(this.form);" onkeypress="carregaRegistrosEliminacao(this.form);" />
</div>

</fieldset>
</form>
</div>

<div id="gestao"></div>
  
<script>
  //carrega a combo ano ao abrir a página pela primeira vez
  //carregaRegistrosEliminacao(document.form1);
</script>
