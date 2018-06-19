<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<script>

function atualizaTelaFundo()
{
	document.faltFundo.reset();
	carregaPag('/gecoi.3.0/apps/parlatorio/lista_fundo.jsp', 'listaFundo');
}


function criticaFundo()
{
	critica_alteracao_fundo(document.faltFundo);
}

$(document).ready(function(){
});

<%
request.setCharacterEncoding("ISO-8859-1");

String vid_conteudo = request.getParameter("idConteudo");
String vresumoAux = "";
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT  cc.descricao as resumo " +
                   "FROM  gecoi.conteudo_catalogo cc " +
                   "WHERE  cc.id_conteudo = ? ";
   				   
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setString(1, vid_conteudo);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		
			vresumoAux = resultSet.getString("resumo");
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
String[] vresumo = vresumoAux.split("@@");
%>
</script>
<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Reportagens	do Tipo Fundo do Ba&uacute;</legend>
	<form name="faltFundo" action="/gecoi.3.0/apps/parlatorio/processa_alterar_fundo.jsp" method="post" target="rodapeAlteraFundo" >
<div id="resumo_fundo">
    		<fieldset>
                <legend>Resumo</legend>
                <!--<input title="Resumo da Reportagem" alt="Resumo da Reportagem" type="text" name="resumoFundo" id="resumoFundo" value="" height="100" width="100" />-->
				<textarea name="resumoAlteraFundo" id="resumoAlteraFundo" title="Resumo da Reportagem" onKeyPress="javascript:resta(this.form.resumoAlteraFundo, 'contadorFundo', 214);" style="width:100%;height:50px; resize:none"><%=vresumo[1]%></textarea>
                </br><span class="alert"><span id="contadorFundo">Ainda restam 214 caracteres.</span></span>
								
							
        	</fieldset>
	    </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaFundo();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaFundo();"  />
      </div>
      <input type="hidden" name="idconteudo" id="idconteudo" value="<%=vid_conteudo%>" />
      
</form>
</fieldset>
</div>
<div id="teste"></div>
<iframe name="rodapeAlteraFundo" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
