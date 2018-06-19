<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>

<script type="text/javascript" src="/gecoi.3.0/apps/estudos_preliminares/scripts/critica_estudo.js" charset="UTF-8"></script>
<script>
function poeZero()
{
	var numero = parseInt(document.fincAnexo.num_ata.value);
	//document.fincAnexo.num_ata.value = String.format("%03d", numero);
	if (numero < 10)
	{
		document.fincAnexo.num_ata.value = "00" + numero;
	}
	else
	{
		if (numero < 100)
		{
			document.fincAnexo.num_ata.value = "0" + numero;
		}
	}
}
</script>
<%
String vidLicitacao = request.getParameter("idLicitacao");
String vnumProcesso = request.getParameter("nProcesso");
String vnumPregao = request.getParameter("nPregao");
String vedital = request.getParameter("edital");

	Calendar c = Calendar.getInstance();
	String vano = "" + c.get(Calendar.YEAR);
%>


<div id="altera_ata">
<fieldset>
	<legend>Inclus&atilde;o de Estudos Preliminares</legend>
    <div id="numero">
    <div id="descricao_arquivo">
        <p>Edital: <strong><%=vedital%></strong></p>
	</div>
    <div id="numero_processo">
      <p>N&uacute;mero do processo: <br /><strong><%=vnumProcesso %></strong></p>
	</div>
	<div id="numero_pregao">
        <p>N&uacute;mero do preg&atilde;o: <br /><strong><%=vnumPregao %></strong></p>
	</div>
</div>
<form name="fincAnexo" action="/gecoi.3.0/IncluirEstudo" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="idArquivo" id="idArquivo" value="<%=vidLicitacao%>"/>
<input type="hidden" name="numProcesso" id="numProcesso" value="<%=vnumProcesso%>"/>
<input type="hidden" name="numPregao" id="numPregao" value="<%=vnumPregao%>"/>

        <div id="data_anexo">
    		<fieldset>
                <legend>Data de Publicação</legend>
                <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" />
	  		</fieldset>
	    </div>
      
        <div id="descricao_anexo">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o do Estudo Preliminar</legend>
        	 	<input type="text" title="Descrição" name="descricao" id="descricao" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"></input>
   			<span id="contadorDescricao" class="alert"></span>
        </fieldset>
	  </div>
      <div id="incluir_arquivo">
      	<fieldset>
        <legend>Incluir Arquivo</legend>
        	<div id="campoArquivo"><input type="file" name="anexo" id="anexo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
        </fieldset>
      </div>
      <div id="botao">
      	  <input type="hidden" name="edital" id="edital" value="<%=vedital%>"/>
          <input type="button" name="cancelar" value="Cancelar" onclick="carregaPag('/gecoi.3.0/apps/estudos_preliminares/lista_estudo.jsp?idLicitacao=<%=vidLicitacao%>&nPregao=<%=vnumPregao%>&nProcesso=<%=vnumProcesso%>&edital=<%=vedital %>','divbusca');" />
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo(this.form.anexo.value);"  />
       </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 
