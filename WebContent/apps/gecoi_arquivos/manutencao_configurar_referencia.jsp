<%@page import="java.text.*,java.util.*,java.sql.*"%>


<%
	int vprincipal = (request.getParameter("idprincipal") == null)
			? 0
			: Integer.parseInt(request.getParameter("idprincipal")
					.toString());
	int vcruzada = (request.getParameter("cruzada") == null
			? 0
			: Integer.parseInt(request.getParameter("cruzada")));
	int vgrupo = (request.getParameter("grupo") == null ? 0 : Integer
			.parseInt(request.getParameter("grupo")));
	int vtipocruzada = (request.getParameter("tipocruzada") == null
			? 0
			: Integer.parseInt(request.getParameter("tipocruzada")));
	String vdescricao = request.getParameter("descricao");
	String vdesabilita = "";
%>

<script language="JavaScript">
	function excluiReferencia() {
		if (document.configuracao.acao.value == 1) {
			msgConfirma = "Confirma a criação da referência cruzada - um para um ?";
		}

		if (document.configuracao.acao.value == 2) {
			msgConfirma = "Confirma a criação da referência cruzada - um para muitos ?";
		}

		if (document.configuracao.acao.value == 3) {
			msgConfirma = "Confirma a exclusão de todas as referências cruzadas desse arquivo ?";
		}

		if (confirm(msgConfirma)) {
			document.configuracao.submit();
		}
	}
</script>

<div id="altera_dados" align="left">
	<fieldset>
		<legend>Configura&ccedil;&atilde;o de Referência</legend>

		<form method="post" name="configuracao" class="form-horizontal"
			target="rodape"
			action="/gecoi.3.0/apps/gecoi_arquivos/processa_configuracao_referencia.jsp">
			<input type="hidden" name="acao" /> 
			<input type="hidden" name="principal" value="<%=vprincipal%>" /> 
			<input type="hidden" name="cruzada" value="<%=vcruzada%>" /> 
			<input type="hidden" name="grupo" value="<%=vgrupo%>" />
			<div class="container" align="left">
			<div class="radio">
				<%
					vdesabilita = "";
					if ((vtipocruzada == 1) || (vtipocruzada == 2))
						vdesabilita = "disabled='disabled'";
				%>
				<label><input <%=vdesabilita%> type="radio" name="radio"
					id="radio1" value="radio"
					onclick="document.configuracao.acao.value=1;document.configuracao.bOK.disabled=false;" />Criar
					refer&ecirc;ncia cruzada - um para um </label>
			</div>
			<div class="radio">
				<%
					vdesabilita = "";
					if (vtipocruzada == 2)
						vdesabilita = "disabled='disabled'";
				%>
				<label><input <%=vdesabilita%> type="radio" name="radio"
					id="radio2" value="radio"
					onclick="document.configuracao.acao.value=2;document.configuracao.bOK.disabled=false;" />Criar
					refer&ecirc;ncia cruzada - um para muitos </label>
			</div>
			<%
				vdesabilita = "";
				if (vtipocruzada == 0)
					vdesabilita = "disabled='disabled'";
			%>
			<div class="radio">
				<label><input <%=vdesabilita%> type="radio" name="radio"
					id="radio3" value="radio"
					onclick="document.configuracao.acao.value=3;document.configuracao.bOK.disabled=false;" />Desfazer
					a refer&ecirc;ncia cruzada </label>
			</div>
			<br><br>
			<div id="botao">
				<input type="button" onclick="excluiReferencia();" name="bOK"
					id="bOK" value="OK" disabled="disabled" />
				<%--        <input type="button" onclick="document.location.href='manutencao_referencia.jsp?idprincipal=<%=vprincipal%>&descricao=<%=vdescricao%>';" name="voltar" value="Voltar"  /> --%>
				<input type="button"
					onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/manutencao_referencia.jsp?idprincipal=<%=vprincipal%>&descricao=<%=vdescricao%>','divbusca');"
					name="voltar" value="Voltar" />
			</div>
			</div>

			<div id="mensagem" class="destaque"></div>
			<hr width="745px" />


			<div id='divconteudo2' class='productInformation'></div>
		</form>
		
		<div class="alert alert-info" role="alert">
		<p>
			<mark>Refer&ecirc;ncia cruzada - um para um</mark> <br>Al&eacute;m
			do arquivo principal fazer refer&ecirc;ncia aos arquivos
			secund&aacute;rios, todos os secund&aacute;rios ir&atilde;o
			tamb&eacute;m fazer refer&ecirc;ncia ao arquivo principal.
		</p>
		</div>
		<div class="alert alert-success" role="alert">
		<p>
			<mark>Refer&ecirc;ncia cruzada - um para muitos</mark> <br>Al&eacute;m
			do arquivo principal fazer refer&ecirc;ncia aos arquivos
			secund&aacute;rios, todos os secund&aacute;rios ir&atilde;o fazer
			refer&ecirc;ncia ao arquivo principal e aos outros arquivos
			secund&aacute;rios.
		</p>
		</div>
		<div class="alert alert-danger" role="alert">
		<p>
			<mark>Desfazer a refer&ecirc;ncia cruzada</mark> <br>Todas
			as refer&ecirc;ncias cruzadas ser&atilde;o desfeitas, permanecendo
			por&eacute;m as refer&ecirc;ncias simples do arquivo principal com os
			arquivos secund&aacute;rios.
		</p>
		</div>
	</fieldset>
</div>
<iframe name="rodape" frameborder="0" allowtransparency="yes"
	height="100" width="600"></iframe>
