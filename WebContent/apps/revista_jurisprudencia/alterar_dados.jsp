
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
	
		$.post("/gecoi.3.0/apps/revista_jurisprudencia/processa_alteracao.jsp", 
										  {
											idConteudo: document.farquivos_alt.idconteudo.value, 
										  	idArquivo : document.farquivos_alt.idarquivo.value,
										  	idArea: document.farquivos_alt.idarea.value,
										  	volume: document.farquivos_alt.volume.value,
										  	numero: document.farquivos_alt.numero.value,
										  	complemento: document.farquivos_alt.complemento.value
										  	
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
                <legend>Complemento</legend>
                <c:choose>
                	<c:when test = "${not empty param.complemento}">
                		<select name="complemento" id="complemento">
                			<option value="${param.complemento}">${param.complemento}</option>
							<option value="">Nenhum</option>
							<option value="Parte 1">Parte 1</option>
							<option value="Parte 2">Parte 2</option>
							<option value="Parte 3">Parte 3</option>
							<option value="Parte 4">Parte 4</option>
							<option value="Parte 5">Parte 5</option>
						</select>
                	</c:when>
                	<c:otherwise>
            			<select name="complemento" id="complemento">
							<option value="">Nenhum</option>
							<option value="Parte 1">Parte 1</option>
							<option value="Parte 2">Parte 2</option>
							<option value="Parte 3">Parte 3</option>
							<option value="Parte 4">Parte 4</option>
							<option value="Parte 5">Parte 5</option>
						</select>
         			</c:otherwise>
				</c:choose>
                
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
