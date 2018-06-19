
<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vnumProcesso = request.getParameter("nProcesso").substring(0,request.getParameter("nProcesso").indexOf("/"));
String vanoProcesso = request.getParameter("nProcesso").substring(request.getParameter("nProcesso").indexOf("/")+1);
String vnumPregao = request.getParameter("nPregao").substring(0,request.getParameter("nPregao").indexOf("/"));
String vanoPregao = request.getParameter("nPregao").substring(request.getParameter("nPregao").indexOf("/")+1);
String vdataAbertura = request.getParameter("dataAbertura");
String vdataFechamento = request.getParameter("dataFechamento");
String vtipo = request.getParameter("tipo");

%>
<script>
$(document).ready(function(){
	$( "#dataFechamento2" ).datepicker();
//	$( "#vigenciaIni" ).datepicker();
	  $("input[name*='num']").keypress(function (e) {
		     //if the letter is not digit then display error and don't type anything
		     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
		        //display error message
		        $("#errmsg").html("Digits Only").show().fadeOut("slow");
		               return false;
		    }
		   });
	  $("input[name*='ano']").keypress(function (e) {
		     //if the letter is not digit then display error and don't type anything
		     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
		        //display error message
		        $("#errmsg").html("Digits Only").show().fadeOut("slow");
		               return false;
		    }
		   });
});

function alterar()
{
	
	if (critica_altera_licitacao(document.flicitacao))
	{
	
		$.post("/gecoi.3.0/apps/licitacao/processa_alteracao.jsp", {idConteudo: document.flicitacao.idconteudo.value, 
										  idArquivo : document.flicitacao.idarquivo.value, 
										  descricao: document.flicitacao.descricao.value, 
										  dataAbertura: document.flicitacao.dataAbertura2.value, 
										  dataFechamento: document.flicitacao.dataFechamento2.value, 
										  tipo: document.flicitacao.tipo.value, 
										  numProcesso: document.flicitacao.numProcesso.value, 
										  anoProcesso: document.flicitacao.anoProcesso.value, 
										  numPregao: document.flicitacao.numPregao.value, 
										  anoPregao: document.flicitacao.anoPregao.value }, function(){listar();});
	}
}
</script>

<h1>Altera&ccedil;&atilde;o dos dados da licita&ccedil;&atilde;o</h1>
<form name="flicitacao" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr>
	 <td>Tipo</td>
	 <td>
	    <select title="Tipo" alt="tipo" name="tipo" id="tipo">
	    	<%
	    		if (vtipo.equals("PE"))
	    		{
	    	%>
  					<option value="PE" selected="selected">Preg&atilde;o Eletr&ocirc;nico</option>
  					<option value="PERP">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
  			<%
	    		}
  				else
  				{
  			%>
  					<option value="PE">Preg&atilde;o Eletr&ocirc;nico</option>
  					<option value="PERP" selected="selected">Preg&atilde;o Eletr&ocirc;nico por Registro de Pre&ccedil;o</option>
  			<%
  				}
  			%>
		</select>
	 </td>
	 </tr>
	 <tr>
	 <td>N� do Preg�o / Ano do Preg�o</td>
        <td>
			<input type="text" name="numPregao" id="numPregao" value="<%=vnumPregao%>" maxlength="9"/> / <input type="text" name="anoPregao" id="anoPregao" value="<%=vanoPregao%>" maxlength="4"/>
        </td>
      </tr>
	 <tr><td>N� do Processo / Ano do Processo</td>
        <td>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso%>" maxlength="9"/> / <input type="text" name="anoProcesso" id="anoProcesso" value="<%=vanoProcesso%>" maxlength="4"/>
        </td>
      </tr>
      <tr><td>Data de Abertura</td>
        <td >
			<input title="Data de abertura do contrato" alt="Data de abertura do contrato" type="text" name="dataAbertura2" id="dataAbertura2" size="18" maxlength="18" value="<%=vdataAbertura%>"  />
<script type="text/javascript">
$('#dataAbertura2').datetimepicker({
	controlType: 'select',
	//timeFormat: 'HH:mm:ss',
	dateFormat: 'dd/mm/yy',
    changeMonth: true,
    changeYear: true																	
});
</script>
        </td>
      </tr>
      <tr><td>Data de Fechamento</td>
        <td >
			<input title="Data de fechamento do contrato" alt="Data de fechamento do contrato" type="text" name="dataFechamento2" id="dataFechamento2" size="10" maxlength="10" value="<%=vdataFechamento%>"  />
        </td>
      </tr>
      <tr><td>Descri&ccedil;&atilde;o do Objeto</td>
        <td>
   			<textarea title="Descri&ccedil;&atilde;o do objeto" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao, 'contadorDescricao', 1000);"><%=vdescricao %></textarea>
			<span id="contadorDescricao" class="alert"></span>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
           <input type="button" name="save" value="Grava altera��es" onclick="alterar();" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
