   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescContrato = request.getParameter("descContrato");
String vnumProcesso = request.getParameter("nProcesso").substring(0,request.getParameter("nProcesso").indexOf("/"));
String vanoProcesso = request.getParameter("nProcesso").substring(request.getParameter("nProcesso").indexOf("/")+1);
String vnumContrato = request.getParameter("nContrato").substring(0,request.getParameter("nContrato").indexOf("/"));
String vanoContrato = request.getParameter("nContrato").substring(request.getParameter("nContrato").indexOf("/")+1);
String vdataIni = request.getParameter("dataIni");
String vdataFim = request.getParameter("dataFim");
String vdataPublicacao = request.getParameter("dataPublicacao");
%>
<script>
$(document).ready(function(){
	$( "#dataPublicacao" ).datepicker();
	$( "#vigenciaIni" ).datepicker();
	$( "#vigenciaFim" ).datepicker();
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
	
	//if (document.fcontrato.descContrato.value == "")
		//alert("É necessário preencher o nome.");
	//else
		$.post("processa_alteracao.jsp", {idConteudo: document.fcontrato.idconteudo.value, 
										  idArquivo : document.fcontrato.idarquivo.value, 
										  descContrato: document.fcontrato.descContrato.value, 
										  dataIni: document.fcontrato.vigenciaIni.value, 
										  dataFim: document.fcontrato.vigenciaFim.value, 
										  dataPublicacao: document.fcontrato.dataPublicacao.value, 
										  numProcesso: document.fcontrato.numProcesso.value, 
										  anoProcesso: document.fcontrato.anoProcesso.value, 
										  numContrato: document.fcontrato.numContrato.value, 
										  anoContrato: document.fcontrato.anoContrato.value, }, function(){top.listar();parent.tb_remove();});
}
</script>
<form name="fcontrato" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr><td>Nº do Processo / Ano do Processo</td>
        <td>
			<input type="text" name="numProcesso" id="numProcesso" value="<%=vnumProcesso%>" maxlength="9"/> / <input type="text" name="anoProcesso" id="anoProcesso" value="<%=vanoProcesso%>" maxlength="2"/>
        </td>
      </tr>
	 <tr><td>Nº do Contrato / Ano do Contrato</td>
        <td>
			<input type="text" name="numContrato" id="numContrato" value="<%=vnumContrato%>" maxlength="9"/> / <input type="text" name="anoContrato" id="anoContrato" value="<%=vanoContrato%>" maxlength="2"/>
        </td>
      </tr>
      <tr><td>Vigência</td>
        <td >
			<input title="Vig&ecirc;ncia inicial do contrato" alt="Vig&ecirc;ncia inicial do contrato" type="text" name="vigenciaIni" id="vigenciaIni" size="10" maxlength="10" value="<%=vdataIni%>"  /> a <input title="Vig&ecirc;ncia final do contrato" alt="Vig&ecirc;ncia final do contrato" type="text" name="vigenciaFim" id="vigenciaFim" size="10" maxlength="10" value="<%=vdataFim%>" />
        </td>
      </tr>
      <tr><td>Descri&ccedil;&atilde;o</td>
        <td>
   			<textarea title="Descri&ccedil;&atilde;o do contrato" name="descContrato" id="descContrato" cols="45" rows="5" onKeyPress="javascript:resta(this.form);" onKeyUp="javascript:resta(this.form);" onKeyDown="javascript:resta(this.form);"><%=vdescContrato %></textarea>
   			<span id="contador" class="alert"></span>
        </td>
      </tr>
      <tr><td>Data de Publica&ccedil;&atilde;o</td>
        <td >
			<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataPublicacao" id="dataPublicacao" size="10" maxlength="10" value="<%=vdataPublicacao%>" />
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
