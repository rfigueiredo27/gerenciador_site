
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("data");
String varea = request.getParameter("area");
String vedital = request.getParameter("volume");
String vnumero = request.getParameter("numero");
String vano_revista = request.getParameter("ano_inicial");
String vmes_inicial = request.getParameter("mes_inicial");
String vmes_final = request.getParameter("mes_final");

%>
<script>

function alterar()
{
	
	if (critica_altera_arquivos(document.farquivos_alt))
	{
	
		$.post("/gecoi.3.0/apps/revista_je/processa_alteracao.jsp", 
										  {
											idConteudo: document.farquivos_alt.idconteudo.value, 
										  	idArquivo : document.farquivos_alt.idarquivo.value,
										  	idArea: document.farquivos_alt.idarea.value,
										  	volume: document.farquivos_alt.volume.value,
										  	numero: document.farquivos_alt.numero.value,
										  	mes_inicial: document.farquivos_alt.mes_inicial.value,
										  	mes_final: document.farquivos_alt.mes_final.value,
										  	ano_inicial: document.farquivos_alt.ano_inicial.value,
										  	ano_final: document.farquivos_alt.ano_final.value
										  	
										  }, function(){listar();});
	}
}
</script>

<div id="altera_dados">

<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados da Revista</legend>
<form name="farquivos_alt" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=varea %>"/>
	 <div id="flex">
	 
	 <div id="edital" >
		<fieldset>
			<legend>Volume</legend>
				<input type="text" title="Volume" name="volume" id="volume" placeholder="" value="${param.volume}" />
		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Número</legend>
				<input type="text" title="Número" name="numero" id="numero" placeholder="" value="${param.numero}"/>
		</fieldset>
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Mês Inicial</legend>
                <select name="mes_inicio" id="mes_inicial">
                	<option value="Janeiro">${param.mes_inicial}</option>
					<option value="Janeiro">Janeiro</option>
					<option value="Fevereiro">Fevereiro</option>
					<option value="Março">Março</option>
					<option value="Abril">Abril</option>
					<option value="Maio">Maio</option>
					<option value="Junho">Junho</option>
					<option value="Julho">Julho</option>
					<option value="Agosto">Agosto</option>
					<option value="Setembro">Setembro</option>
					<option value="Outubro">Outubro</option>
					<option value="Novembro">Novembro</option>
					<option value="Dezembro">Dezembro</option>
			</select>
	  		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Ano Inicial</legend>
				<input type="text" title="Ano" name="ano_inicial" id="ano_inicial" placeholder="" value="${param.ano_inicial}"/>
		</fieldset>
		
	</div>
	
	<div id="edital">
    		<fieldset>
                <legend>Mês Final</legend>
                <select name="mes_fim" id="mes_final">
                	<option value="Janeiro">${param.mes_final}</option>
					<option value="Janeiro">Janeiro</option>
					<option value="Fevereiro">Fevereiro</option>
					<option value="Março">Março</option>
					<option value="Abril">Abril</option>
					<option value="Maio">Maio</option>
					<option value="Junho">Junho</option>
					<option value="Julho">Julho</option>
					<option value="Agosto">Agosto</option>
					<option value="Setembro">Setembro</option>
					<option value="Outubro">Outubro</option>
					<option value="Novembro">Novembro</option>
					<option value="Dezembro">Dezembro</option>
			</select>
	  		</fieldset>
	</div>
	
	<div id="edital">
		<fieldset>
			<legend>Ano Final</legend>
				<input type="text" title="Ano" name="ano_final" id="ano_final" placeholder="" value="${param.ano_final}"/>
		</fieldset>
		
	</div>
	
	</div>
	
	 <br /><br /><br /><br />
     <div id="botao" align="center">
     	<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
        <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
     </div>
</form>
</fieldset>

</div>
