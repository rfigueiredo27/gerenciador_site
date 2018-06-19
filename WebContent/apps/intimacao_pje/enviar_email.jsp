<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Date"%>
<%
//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
		Date data = new Date(System.currentTimeMillis());  
		SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy HH:mm"); 
		String dataPublicacao = formatarDate.format(data);
		//out.print(data);
%>

<script>
function atualizaTelaReportagem()
{
	document.finclusao.reset();
	$( "#dialog" ).dialog();
}
</script>

<!-- Mensagem de confirmação de envio de e-mail -->
<div id="dialog" title="Envio de E-mail" class="invisivel">
  <p>Seu e-mail foi enviado com sucesso!</p>
</div>


<form name="finclusao" id="finclusao" action="/gecoi.3.0/apps/intimacao_pje/processa_envio.jsp" onsubmit="" method="post"  data-toggle="
idator" target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off">
	
	<div id="flex">
	
    <div id="data">
    		<fieldset>
                <legend>Data/Hora de Envio</legend>
                <input title="Data de Envio" alt="Data de Envio" type="text" name="data_envio" id="data_envio" size="10" maxlength="10" value="<%=dataPublicacao%>" required/>
	  		</fieldset>
	</div>
    
    <div id="processo">
		<fieldset>
			<legend>N° do Processo</legend>
				<input type="text" title="Número do Processo" name="processo" id="processo" required/>
		</fieldset>
	</div>
    
    <div id="email">
		<fieldset>
			<legend>E-mail do Intimado</legend>
				<input type="email" title="E-mail" name="email" id="email" required/>
		</fieldset>
	</div>
    
	</div>
	<div id="nome">
		<fieldset>
			<legend>Nome do Intimado</legend>
				<input type="text" title="Nome do Intimado" name="nome" id="nome" required/>
		</fieldset>
	</div>
	
	<div id="mensagem">
		<fieldset>
			<legend>Mensagem</legend>
				<textarea title="Mensagem de e-mail" name="mensagem_texto" id="mensagem_texto" required></textarea>
		</fieldset>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
					<div id="progressBarText"></div>
					<div id="progressBarBox">
						<div id="progressBarBoxContent"></div>
					</div>
				</div>
			</div>
	</div>
	<br><br>
	<div id="botao" align="center">
		<input type="submit" name="button" id="button" value="Publicar"	/>
	</div>
	
</form>


<iframe name="rodape" frameborder="0" allowtransparency="yes" height="500" width="500"></iframe>
