   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
   
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />
   
<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vidArea = request.getParameter("idArea");
String vnumProcesso = request.getParameter("nProcesso");
String vdataAbertura = request.getParameter("dataAbertura");
String vdataFechamento = request.getParameter("dataFechamento");
String[] anumProcesso = vnumProcesso.split("/");
%>
<script>
$(document).ready(function(){
	$( "#dataAbertura" ).datepicker();
	$( "#dataFechamento" ).datepicker();
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
	
	//if (document.fregistro.descContrato.value == "")
		//alert("É necessário preencher o nome.");
	//else
		$.post("processa_alteracao.jsp", {idConteudo: document.fregistro.idconteudo.value, 
										  idArquivo : document.fregistro.idarquivo.value, 
										  idArea : document.fregistro.idarea.value,
										  descricao: document.fregistro.descricao.value,
										  numProcesso: document.fregistro.numProcesso.value,
										  anoProcesso: document.fregistro.anoProcesso.value,
										  dataAbertura: document.fregistro.dataAbertura.value,
										  dataFechamento: document.fregistro.dataFechamento.value
										  }, function(){top.listar();parent.tb_remove();});
}
</script>
<form name="fregistro" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=vidArea%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td>Nº do Processo</td>
		<td>
  			<p>N&uacute;mero Ano </p>
  			<p>
    			<input title="N&uacute;mero do processo" alt="N&uacute;mero do processo"  type="text" name="numProcesso" id="numProcesso" size="6" maxlength="6" onKeyDown="FormataNumero(this,event);" value="<%=anumProcesso[0]%>"/>/<input title="Ano do processo com 2 d&iacute;gitos" alt="Ano do processo com 2 d&iacute;gitos" type="text" name="anoProcesso" id="anoProcesso" size="2" maxlength="2" value="<%=anumProcesso[1]%>" />
  			</p>
		</td>
		<tr><td>Data do Edital</td>
		<td>
   			<input title="Data do edital" alt="Data do edital" type="text" name="dataAbertura" id="dataAbertura" size="10" maxlength="10" value="<%=vdataAbertura %>" />
		</td>
		</tr>
		<tr><td>Data de Validade</td>
		<td>
   			<input title="Data de validade" alt="Data de validade" type="text" name="dataFechamento" id="dataFechamento" size="10" maxlength="10" value="<%=vdataFechamento %>" />
		</td>
		</tr>
      <tr><td>Descri&ccedil;&atilde;o do Registro</td>
        <td>
   			<input title="Descri&ccedil;&atilde;o do registro" alt="Descri&ccedil;&atilde;o do registro"  type="text" name="descricao" id="descricao" value="<%=vdescricao %>" />
   			<!-- <textarea title="Descri&ccedil;&atilde;o do edital" name="descricao" id="descricao" cols="45" rows="5" onKeyPress="javascript:resta(this.form);" onKeyUp="javascript:resta(this.form);" onKeyDown="javascript:resta(this.form);"><%//=vdescricao %></textarea>
   			<span id="contador" class="alert"></span>-->
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
