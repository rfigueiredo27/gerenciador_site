
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
String vdataPublicacao = request.getParameter("dataPublicacao");
String vtipo = request.getParameter("tipo");

%>
<script>
function seleciona()
{
	document.getElementById('numProcesso').select();
}

$(document).ready(function(){
	$( "#dataFechamento2" ).datepicker();
	$( "#dataPublicacao2" ).datepicker();
	$("input").click(function (e){this.select();});
	$("textarea").click(function (e){this.select();});
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
	document.getElementById("tipo2").focus();
});

function alterar()
{
	
	if (critica_altera_licitacao(document.flicitacao))
	{
	
		$.post("/gecoi.3.0/apps/licitacao/processa_alteracao.jsp", {idConteudo: document.flicitacao.idconteudo.value, 
										  idArquivo : document.flicitacao.idarquivo.value, 
										  descricao: document.flicitacao.descricao_dados.value, 
										  dataAbertura: document.flicitacao.dataAbertura2.value, 
										  dataFechamento: "",
										  dataPublicacao: document.flicitacao.dataPublicacao2.value,
										  tipo: document.flicitacao.tipo2.value, 
										  numProcesso: document.flicitacao.numProcesso.value, 
										  anoProcesso: document.flicitacao.anoProcesso.value, 
										  numPregao: document.flicitacao.numPregao.value, 
										  anoPregao: document.flicitacao.anoPregao.value }, function(){listar();});
	}
}
</script>
<script type="text/javascript">
$('#dataAbertura2').datetimepicker({
	controlType: 'select',
	//timeFormat: 'HH:mm:ss',
	dateFormat: 'dd/mm/yy',
    changeMonth: true,
    changeYear: true																	
});
</script>

<div id="altera_dados">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados da licita&ccedil;&atilde;o</legend>
<form name="flicitacao" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>

     <div id="altera_tipo">
     	<fieldset>
       		<legend>Tipo</legend>
	    	<select title="Tipo" alt="tipo" name="tipo2" id="tipo2">
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
     	</fieldset>
     </div>
     <div id="altera_pregao">
          <fieldset>
       		<legend>Nº do Pregão / Ano do Pregão</legend>
			<input type="text" name="numPregao" id="numPregao" value="<%=vnumPregao%>" maxlength="9"/> / <input type="text" name="anoPregao" id="anoPregao" value="<%=vanoPregao%>" maxlength="4"/>
        </fieldset>
      </div>
      <div id="altera_processo">
          <fieldset>
       		<legend>Nº do Processo / Ano do Processo</legend>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso%>" maxlength="9" /> / <input type="text" name="anoProcesso" id="anoProcesso" value="<%=vanoProcesso%>" maxlength="4"/>
        </fieldset>
      </div>
      <div id="altera_data">
         <fieldset>
       		<legend>Data de Abertura</legend>
			<input title="Data de abertura do contrato" alt="Data de abertura do contrato" type="text" name="dataAbertura2" id="dataAbertura2" size="18" maxlength="18" value="<%=vdataAbertura%>"  />
         </fieldset>
         
         <fieldset>
       		<legend>Data de Publica&ccedil;&atilde;o</legend>
			<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao2" id="dataPublicacao2" size="10" maxlength="10" value="<%=vdataPublicacao %>"/>
        </fieldset>        
     </div>
     <div id="altera_objeto">
         <fieldset>
       		<legend>Descri&ccedil;&atilde;o do Objeto</legend>
   			<textarea title="Descri&ccedil;&atilde;o do objeto" name="descricao_dados" id="descricao_dados" cols="45" rows="5" onKeyPress="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);" onKeyUp="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);" onKeyDown="javascript:resta(this.form.descricao_dados, 'contadorDescricao', 1000);"><%=vdescricao %></textarea>
			<span id="contadorDescricao" class="alert"></span>
        </fieldset>
     </div>
     <div id="botao">
     	<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
        <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
     </div>
</form>
</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
