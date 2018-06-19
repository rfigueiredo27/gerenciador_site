<!-- essa CSS é necessária para anular a configuração do bootstrap -->
<style>
legend
{
	margin-bottom:0px;
	border-bottom: none;
	width: auto;
}
</style>

<script>
function atualizaTelaLegislacao()
{
	document.fincLegislacao.reset();
	$("#tipo_norma").hide();
	$("z").remove();
	limpaProgress();
}


function criticaLegislacao()
{
	critica_inclusao_legislacao(document.fincLegislacao);
}

function verificaTipo()
{
	if ($("#tipoLegislacao").val() ==  "50") // indice de normas
	{
		$("#tipo_norma").hide();
		$("#numero_norma").hide();
		$("#assunto_legislacao").hide();
		$("#descricao_auxiliar").val("\u00cdndice dos Atos da Presid\u00eancia do TRE-RJ.");
	}
	else
	{
		if ( ($("#tipoLegislacao").val() ==  "47") || ($("#tipoLegislacao").val() ==  "48") || ($("#tipoLegislacao").val() ==  "53") )
		{
			$("#tipo_norma").show();
			$("#numero_norma").show();
			$("#assunto_legislacao").show();
			$("#div_label_numero_norma").text("N\u00famero da Norma");
			$("#descricao_auxiliar").val(" n\u00ba ");
		}
		else
		{
			$("#tipo_norma").hide();
			$("#numero_norma").show();
			$("#assunto_legislacao").show();
			if ( ($("#tipoLegislacao").val() ==  "20") || ($("#tipoLegislacao").val() ==  "36") || ($("#tipoLegislacao").val() ==  "2434") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Resolu\u00e7\u00e3o");
				$("#descricao_auxiliar").val("Resolu\u00e7\u00e3o n\u00ba ");
			}
			if ( ($("#tipoLegislacao").val() ==  "33") || ($("#tipoLegislacao").val() ==  "39") || ($("#tipoLegislacao").val() ==  "38") )
			{
				$("#div_label_numero_norma").text("N\u00famero do Ato");
				if ($("#tipoLegislacao").val() ==  "33")
				{
					$("#descricao_auxiliar").val("Ato n\u00ba ");
				}
				if ($("#tipoLegislacao").val() ==  "39")
				{
					$("#descricao_auxiliar").val("Ato VP n\u00ba ");
				}
				if ($("#tipoLegislacao").val() ==  "38")
				{
					$("#descricao_auxiliar").val("Ato Conjunto n\u00ba ");
				}
			}
			if ( ($("#tipoLegislacao").val() ==  "45") || ($("#tipoLegislacao").val() ==  "49") || ($("#tipoLegislacao").val() ==  "2631") || ($("#tipoLegislacao").val() ==  "46") || ($("#tipoLegislacao").val() ==  "2560") || ($("#tipoLegislacao").val() ==  "77") || ($("#tipoLegislacao").val() ==  "2652") || ($("#tipoLegislacao").val() ==  "76") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Portaria");
				$("#descricao_auxiliar").val("Portaria n\u00ba ");
			}
			if ( ($("#tipoLegislacao").val() ==  "1747") || ($("#tipoLegislacao").val() ==  "90") || ($("#tipoLegislacao").val() ==  "2587") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Instru\u00e7\u00e3o Normativa");
				$("#descricao_auxiliar").val("Instru\u00e7\u00e3o Normativa n\u00ba ");
			}
			if ( ($("#tipoLegislacao").val() ==  "65") || ($("#tipoLegislacao").val() ==  "44") )
			{
				$("#div_label_numero_norma").text("N\u00famero da Ordem de Servi\u00e7o");
				$("#descricao_auxiliar").val("Ordem de Servi\u00e7o n\u00ba ");
			}
			if ($("#tipoLegislacao").val() ==  "2502")
			{
				$("#div_label_numero_norma").text("N\u00famero da Provimento");
				$("#descricao_auxiliar").val("Provimento n\u00ba ");
			}
		}
	}
}
</script>

<form name="fincLegislacao" action="/gecoi.3.0/apps/legislacao/processa_incluir_legislacao.jsp" method="post" target="rodape" enctype="multipart/form-data">
<div id="tipo_legislacao">
	<fieldset>
    	<legend>Legisla&ccedil;&atilde;o</legend>
    	<select name="tipoLegislacao" id="tipoLegislacao" onchange="verificaTipo();" >
			<option value="0">-----------</option>
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
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataLegislacao" id="dataLegislacao" size="10" maxlength="10" value="<%=vhoje%>"/>
        	</fieldset>
	    </div>
<div id="tipo_norma">
    		<fieldset>
                <legend>Norma</legend>
                <select name="tipoNorma" id="tipoNorma" >        				
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
				   String vnorma = "";
					if ( resultSet.next() )
					{
						do 
						{
							String[] anorma = resultSet.getString("norma").split(" n[º]",2);
							if (!vanterior.equals(anorma[0]))
							{
								out.print("<option value='" + anorma[0] + "'>" + anorma[0] + "</option>");
								vanterior = anorma[0];
							}
							/*out.print("<option value=''>1</option>");
							out.print("<option value=''>"+resultSet.getString("norma").indexOf("[º]")+"</option>");
							out.print("<option value=''>"+resultSet.getString("norma").indexOf("º")+"</option>");
							vnorma = resultSet.getString("norma").substring(1,resultSet.getString("norma").indexOf("[º]"));
							if (!vanterior.equals(vnorma))
							{
								out.print("<option value='" + vnorma + "'>" + vnorma + "</option>");
								vanterior = vnorma;
							}*/
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
                <legend><div id="div_label_numero_norma">N&uacute;mero da Norma</div></legend>
                <input title="N&uacute;mero da norma" alt="N&uacute;mero da norma" type="text" name="num_norma" id="num_norma" size="6" onkeyup="SoNumero(event, this)" /> / 
                <input title="Ano da norma" alt="Ano da norma" type="text" name="ano_norma" id="ano_norma" size="2" maxlength="2" value="<%=vano %>" />
            </fieldset>
	    </div>
<div id="assunto_legislacao">
    		<fieldset>
                <legend>Assunto</legend>
				<input title="Assunto da Legisla&ccedil;&atilde;o" alt="Assunto da Legisla&ccedil;&atilde;o" type="text" name="assuntoLegislacao" id="assuntoLegislacao" />
        	</fieldset>
	    </div>
        <div id="incluir_arquivo">
      		<fieldset>
        	<legend>Selecione o arquivo da Legisla&ccedil;&atilde;o</legend>
            <input name="arquivo" type="file" id="arquivo" onchange="">
   		  </fieldset>
      </div>
   			 <div id="campoArquivo"></div>
			 <div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
    <input type="hidden" name="descricao_auxiliar" id="descricao_auxiliar" />
	<div id="dynamicDiv3">

			<a class="add" style="text-decoration:none" href="javascript:void(0)" id="addInput3">
				(+) Adicionar Anexo(s)
			</a>
	
	</div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTelaLegislacao();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaLegislacao();"  />
      </div>
</form>


<!--<div id="summernote">Digite a legislacao</div> -->
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>


<script>
	$(function() {
		var scntDiv = $('#dynamicDiv3');
		$(document)
				.on(
						'click',
						'#addInput3',
						function() {
							$(
									'<z><br><br>'
									
									+	'<div id="titulo_anexo" align="left">'
									+	'<fieldset>'
									+	'<legend>Descri&ccedil;&atilde;o</legend>'
									+	'<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descanexo" id="descanexo" required/>'
									+	'</fieldset>'
									+	'</div>'
									+	'<div id="arquivo_anexo" align="left">'
									+   '<fieldset>'
									+   '<legend>Incluir Arquivo</legend>'
									+	'<input type="file" name="anexo" id="anexo" alt="Arquivo a ser inserido" required />' 
									+	'</fieldset>'
									+	'</div>'
									+	'</div>'
									+	'<div id="progressBar" style="display: none;">'
									+	'<div id="theMeter">'
									+	'<div id="progressBarText"></div>'
									+	'<div id="progressBarBox">'
									+	'<div id="progressBarBoxContent"></div>'
									+	'</div>'
									+	'</div>'
									+	'</div>'
									+ '<a class="rem" style="text-decoration:none" href="javascript:void(0)" id="remInput">'
									+ '<br>'
									+ '(-) Remover Arquivo' + '</a>'
									+ '<z>').appendTo(scntDiv);
							return false;
						});
		$(document).on('click', '#remInput3', function() {
			$(this).parents('z').remove();
			return false;
		});
	});
</script>

