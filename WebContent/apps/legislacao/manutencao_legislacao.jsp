<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%//@include file="/includes/prepara_barra_progresso.jsp"%>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

  <script>
function atualizaTela(pano, plegislacao)
{
	carregaPag("/gecoi.3.0/apps/legislacao/lista_legislacao.jsp?ano=" + pano + "&legislacao=" + plegislacao,"resultado");
}


function criticaAlteraLegislacao()
{
	critica_alteracao_legislacao(document.falteraLegislacao);
}

function verificaTipo()
{
		if ($("#tipoAlteraLegislacao").val() ==  "1622") // indice de normas
	{
		$("#tipo_norma").hide();
		$("#numero_norma").hide();
		$("#assunto_legislacao").hide();
		$("#AlteraDescricaoAuxiliar").val("Resolu\u00e7\u00e3o n\u00ba ");
	}

	if ($("#tipoAlteraLegislacao").val() ==  "50") // indice de normas
	{
		$("#tipo_norma").hide();
		$("#numero_norma").hide();
		$("#assunto_legislacao").hide();
		$("#AlteraDescricaoAuxiliar").val("\u00cdndice dos Atos da Presid\u00eancia do TRE-RJ.");
	}
	else
	{
		if ( ($("#tipoAlteraLegislacao").val() ==  "47") || ($("#tipoAlteraLegislacao").val() ==  "48") || ($("#tipoAlteraLegislacao").val() ==  "53") )
		{
			$("#tipo_norma").show();
			$("#numero_norma").show();
			$("#assunto_legislacao").show();
			$("#div_label_numero_norma").text("N\u00famero da Norma");
			$("#AlteraDescricaoAuxiliar").val(" n\u00ba ");
		}
		else
		{
			$("#tipo_norma").hide();
			$("#numero_norma").show();
			$("#assunto_legislacao").show();
			if ( ($("#tipoAlteraLegislacao").val() ==  "20") || ($("#tipoAlteraLegislacao").val() ==  "36") || ($("#tipoAlteraLegislacao").val() ==  "2434") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Resolu\u00e7\u00e3o");
				$("#AlteraDescricaoAuxiliar").val("Resolu\u00e7\u00e3o n\u00ba ");
			}
			if ( ($("#tipoAlteraLegislacao").val() ==  "33") || ($("#tipoAlteraLegislacao").val() ==  "39") || ($("#tipoAlteraLegislacao").val() ==  "38") )
			{
				$("#div_label_numero_norma").text("N\u00famero do Ato");
				if ($("#tipoAlteraLegislacao").val() ==  "33")
				{
					$("#AlteraDescricaoAuxiliar").val("Ato n\u00ba ");
				}
				if ($("#tipoAlteraLegislacao").val() ==  "39")
				{
					$("#AlteraDescricaoAuxiliar").val("Ato VP n\u00ba ");
				}
				if ($("#tipoAlteraLegislacao").val() ==  "38")
				{
					$("#AlteraDescricaoAuxiliar").val("Ato Conjunto n\u00ba ");
				}
			}
			if ( ($("#tipoAlteraLegislacao").val() ==  "45") || ($("#tipoAlteraLegislacao").val() ==  "49") || ($("#tipoAlteraLegislacao").val() ==  "2631") || ($("#tipoAlteraLegislacao").val() ==  "46") || ($("#tipoAlteraLegislacao").val() ==  "2560") || ($("#tipoAlteraLegislacao").val() ==  "77") || ($("#tipoAlteraLegislacao").val() ==  "2652") || ($("#tipoAlteraLegislacao").val() ==  "76") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Portaria");
				$("#AlteraDescricaoAuxiliar").val("Portaria n\u00ba ");
			}
			if ( ($("#tipoAlteraLegislacao").val() ==  "1747") || ($("#tipoAlteraLegislacao").val() ==  "90") || ($("#tipoAlteraLegislacao").val() ==  "2587") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Instru\u00e7\u00e3o Normativa");
				$("#AlteraDescricaoAuxiliar").val("Instru\u00e7\u00e3o Normativa n\u00ba ");
			}
			if ( ($("#tipoAlteraLegislacao").val() ==  "65") || ($("#tipoAlteraLegislacao").val() ==  "44") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Ordem de Servi\u00e7o");
				$("#AlteraDescricaoAuxiliar").val("Ordem de Servi\u00e7o n\u00ba ");
			}
			if ($("#tipoAlteraLegislacao").val() ==  "2502")
			{
				$("#div_label_numero_norma").text("N\u00famero da Provimento");
				$("#AlteraDescricaoAuxiliar").val("Provimento n\u00ba ");
			}
		}
	}
}

$(document).ready(function(){
	$( "#dataAlteraLegislacao" ).datepicker();
	verificaTipo();
	/*if ( ($("#tipoAlteraLegislacao").val() ==  "47") || ($("#tipoAlteraLegislacao").val() ==  "48") || ($("#tipoAlteraLegislacao").val() ==  "53") )
		$("#tipo_altera_norma").show();
	else
		$("#tipo_altera_norma").hide();*/
});


</script>
<%
request.setCharacterEncoding("UTF-8");
String vselecao = "";
int vid_conteudo = (request.getParameter("idConteudo") == null) ? 0 : Integer.parseInt(request.getParameter("idConteudo"));
String vdataPublicacao = "";
String vid_area = "";
String vnorma = "";
String vnumero = "";
String vano_busca = (request.getParameter("ano") == null) ? "0" : request.getParameter("ano");
String vassunto = "";
String vid_arquivo = "";
String vano = "";
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data, ca.id_area " + 
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo and aq.ordem = 0 " +
                   "AND aq.id_conteudo = ? ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	resultSet = pstm.executeQuery();
	if (resultSet.next())
	{
		do
		{
			vid_area = resultSet.getString("id_Area");
			vdataPublicacao = resultSet.getString("data");
			vid_arquivo = resultSet.getString("id_arquivo");
			if (vid_area.equals("50"))
			{
				vnorma = "";
				vassunto = resultSet.getString("descricao");
			}
			else
			{
				String[] adescricao = resultSet.getString("descricao").split("-",2);
				vnorma = adescricao[0];
				vassunto = adescricao[1];
				String[] anorma = vnorma.split(" n[º]",2);
				vnorma = anorma[0];
				vnumero = anorma[1].substring(0,anorma[1].indexOf("/"));
				vano = anorma[1].substring(anorma[1].indexOf("/")+1,anorma[1].indexOf("/")+3);
			}
		} while  ( resultSet.next() );
	}
	resultSet.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
String vusuario = session.getAttribute("login").toString();
String vsenha = session.getAttribute("senha").toString();

%>

<div id="altera_ata">
<fieldset>
	<legend>Altera&ccedil;&atilde;o de Legisla&ccedil;&atilde;o</legend>
<form name="falteraLegislacao" action="/gecoi.3.0/apps/legislacao/processa_alterar_legislacao.jsp" method="post" target="rodapeAltera" >
<div id="tipo_legislacao">
	<fieldset>
    	<legend>Legisla&ccedil;&atilde;o</legend>
        <!-- campo 0 -->
    	<select name="tipoAlteraLegislacao" id="tipoAlteraLegislacao" onchange="verificaTipo();" >
            <%
				String vescolhido = "";
				if (vid_area.equals("38"))
					vescolhido = "selected='selected'";
			%>
            <option value="38" <%=vescolhido%>>Atos Conjuntos</option>
            <%
				vescolhido = "";
				if (vid_area.equals("1622"))
					vescolhido = "selected='selected'";
			%>
            <option value="1622" <%=vescolhido%>>Teste</option>
            <%
				vescolhido = "";
				if (vid_area.equals("33"))
					vescolhido = "selected='selected'";
			%>
            <option value="33" <%=vescolhido%>>Atos da Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("39"))
					vescolhido = "selected='selected'";
			%>
            <option value="39" <%=vescolhido%>>Atos da Vice-Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("50"))
					vescolhido = "selected='selected'";
			%>
            <option value="50" <%=vescolhido%>>&Iacute;ndice dos Atos da Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("90"))
					vescolhido = "selected='selected'";
			%>
            <option value="90" <%=vescolhido%>>Instru&ccedil;&otilde;es Normativas da Diretoria-Geral</option>
            <%
				vescolhido = "";
				if (vid_area.equals("1747"))
					vescolhido = "selected='selected'";
			%>
            <option value="1747" <%=vescolhido%>>Instru&ccedil;&otilde;es Normativas da Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2587"))
					vescolhido = "selected='selected'";
			%>
            <option value="2587" <%=vescolhido%>>Instru&ccedil;&otilde;es Normativas do TSE</option>
            <%
				vescolhido = "";
				if (vid_area.equals("48"))
					vescolhido = "selected='selected'";
			%>
            <option value="48" <%=vescolhido%>>Legisla&ccedil;&atilde;o Correlata</option>
            <%
				vescolhido = "";
				if (vid_area.equals("37"))
					vescolhido = "selected='selected'";
			%>
            <option value="47" <%=vescolhido%>>Legisla&ccedil;&atilde;o Eleitoral</option>
            <%
				vescolhido = "";
				if (vid_area.equals("53"))
					vescolhido = "selected='selected'";
			%>
            <option value="53" <%=vescolhido%>>Legisla&ccedil;&atilde;o Partid&aacute;ria</option>
            <%
				vescolhido = "";
				if (vid_area.equals("44"))
					vescolhido = "selected='selected'";
			%>
            <option value="44" <%=vescolhido%>>Ordens de Servi&ccedil;o da Diretoria-Geral</option>
            <%
				vescolhido = "";
				if (vid_area.equals("65"))
					vescolhido = "selected='selected'";
			%>
            <option value="65" <%=vescolhido%>>Ordens de Servi&ccedil;o da Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("76"))
					vescolhido = "selected='selected'";
			%>
            <option value="76" <%=vescolhido%>>Portarias CFPE</option>
            <%
				vescolhido = "";
				if (vid_area.equals("46"))
					vescolhido = "selected='selected'";
			%>
            <option value="46" <%=vescolhido%>>Portarias da Diretoria-Geral</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2631"))
					vescolhido = "selected='selected'";
			%>
            <option value="2631" <%=vescolhido%>>Portarias da Ouvidoria</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2560"))
					vescolhido = "selected='selected'";
			%>
            <option value="2560" <%=vescolhido%>>Portarias da SGP</option>
            <%
				vescolhido = "";
				if (vid_area.equals("45"))
					vescolhido = "selected='selected'";
			%>
            <option value="45" <%=vescolhido%>>Portarias da Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("49"))
					vescolhido = "selected='selected'";
			%>
            <option value="49" <%=vescolhido%>>Portarias da Vice-Presid&ecirc;ncia</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2652"))
					vescolhido = "selected='selected'";
			%>
            <option value="2652" <%=vescolhido%>>Portarias do CNJ</option>
            <%
				vescolhido = "";
				if (vid_area.equals("77"))
					vescolhido = "selected='selected'";
			%>
            <option value="77" <%=vescolhido%>>Portarias do TSE</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2502"))
					vescolhido = "selected='selected'";
			%>
            <option value="2502" <%=vescolhido%>>Provimentos do CNJ</option>
            <%
				vescolhido = "";
				if (vid_area.equals("2434"))
					vescolhido = "selected='selected'";
			%>
            <option value="2434" <%=vescolhido%>>Resolu&ccedil;&otilde;es do CNJ</option>
            <%
				vescolhido = "";
				if (vid_area.equals("20"))
					vescolhido = "selected='selected'";
			%>
            <option value="20" <%=vescolhido%>>Resolu&ccedil;&otilde;es do TRE-RJ</option>
            <%
				vescolhido = "";
				if (vid_area.equals("36"))
					vescolhido = "selected='selected'";
			%>
            <option value="36" <%=vescolhido%>>Resolu&ccedil;&otilde;es do TSE</option>
 		</select>
	</fieldset>
</div>
<div id="data_legislacao">
    		<fieldset>
        <!-- campo 1 -->
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataAlteraLegislacao" id="dataAlteraLegislacao" size="10" maxlength="10" value="<%=vdataPublicacao%>"/>
        	</fieldset>
	    </div>
<div id="tipo_altera_norma">
    		<fieldset>
            <!-- campo 2 -->
                <legend>Norma</legend>
                <select name="tipoAlteraNorma" id="tipoAlteraNorma" >        				
                <%
				try
				{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
					
					/*String vsql = "SELECT SubStr(descricao,1,InStr(descricao, 'nº')-2) as norma FROM gecoi.arquivo a, gecoi.conteudo_area ca " +
								"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area IN (47,48,53) " +
								"GROUP BY SubStr(descricao,1,InStr(descricao, 'nº')-2) ORDER BY 1 ";*/
					String vsql = "SELECT descricao as norma FROM gecoi.arquivo a, gecoi.conteudo_area ca " +
								"WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area IN (47,48,53)  " +
								"ORDER BY 1 ";
					PreparedStatement pstm = con.prepareStatement(vsql);
					resultSet = pstm.executeQuery();
					String vanterior = "";
				   String vseleciona = "";
					if ( resultSet.next() )
					{
						do 
						{
							String[] anorma = resultSet.getString("norma").split(" n[º]",2);
							if (!vanterior.equals(anorma[0]))
							{
								vseleciona = "";
								if (vnorma.equals(anorma[0]))
									vseleciona = "selected='selected'";
								out.print("<option value='" + anorma[0] + "'>" + anorma[0] + "</option>");
								vanterior = anorma[0];
							}
						}while (resultSet.next());
					}
					resultSet.close();
				}
				catch (Exception ex)
				{
					out.print("Ocorreu o seguinte erro : " + ex.getMessage() );
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
 		<div id="numero_norma">
    		<fieldset>
            <!-- campo 3 -->
                <legend><div id="div_label_numero_norma">N&uacute;mero da Norma</div></legend>
                <input title="N&uacute;mero da norma" alt="N&uacute;mero da norma" type="text" name="numAlteraNorma" id="numAlteraNorma" size="6" onkeyup="SoNumero(event, this)" value="<%=vnumero %>"/> / 
                <!-- campo 4 -->
                <input title="Ano da norma" alt="Ano da norma" type="text" name="anoAlteraNorma" id="anoAlteraNorma" size="2" maxlength="2" value="<%=vano %>" />
            </fieldset>
	    </div>
<div id="assunto_legislacao">
    		<fieldset>
                <legend>Assunto</legend>
                <!-- campo 5 -->
				<input title="Assunto da Legisla&ccedil;&atilde;o" alt="Assunto da Legisla&ccedil;&atilde;o" type="text" name="assuntoAlteraLegislacao" id="assuntoAlteraLegislacao" value="<%=vassunto%>" />
        	</fieldset>
	    </div>

        <!-- campo 6 -->
        <input type="hidden" name="AlteraDescricaoAuxiliar" id="AlteraDescricaoAuxiliar" value="" />
        <!-- campo 7 -->
		<input type="hidden" id="idConteudo" name="idConteudo" value="<%=vid_conteudo%>" />
		<input type="hidden" id="idArquivo" name="idArquivo" value="<%=vid_arquivo%>" />
		<input type="hidden" id="anoBusca" name="anoBusca" value="<%=vano_busca%>" />
		<input type="hidden" id="legislacaoBusca" name="legislacaoBusca" value="<%=vid_area%>" />
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela(<%=vano_busca%>,<%=vid_area%>);" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraLegislacao();"  />
      </div>
</form>
</fieldset>
</div>
<iframe name="rodapeAltera" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
