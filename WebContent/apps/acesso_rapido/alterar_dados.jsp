
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
	
		$.post("/gecoi.3.0/apps/acesso_rapido/processa_alteracao.jsp", 
										  {
											idConteudo: document.farquivos_alt.idconteudo.value, 
										  	idArquivo : document.farquivos_alt.idarquivo.value,
										  	idArea: document.farquivos_alt.idarea.value,
										  	link: document.farquivos_alt.link.value,
										  	target: document.farquivos_alt.target.value,
										  	hint: document.farquivos_alt.hint.value,
										  	descricao: document.farquivos_alt.descricao1.value
										  	
										  }, function(){listar();});
	}
}
</script>

<div id="altera_dados">

<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Acesso Rápido</legend>
		<form name="farquivos_alt" method="post" >
			<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
			<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
			<input type="hidden" name="idarea" id="idarea" value="<%=varea %>"/>
			<div id="edital" >
				<fieldset>
					<legend>Descrição</legend>
					<input type="text" title="Descrição" name="descricao1" id="descricao1" placeholder="" value="${param.descricao }" />
				</fieldset>
			</div>
			<div id="edital">
				<fieldset>
					<legend>Link</legend>
						<input type="text" title="Link" name="link" id="link" placeholder="" value="${param.link }"/>
				</fieldset>
			</div>
			<div id="edital">
				<fieldset>
					<legend>Hint</legend>
						<input type="text" title="Hint" name="hint" id="hint" placeholder="" value="${param.hint }"/>
				</fieldset>
			</div>
			<div id="edital">
		    		<fieldset>
		                <legend>Target</legend>
		                <select name="target" id="target">
		                	<option value="${param.target }">${param.target }</option>
							<option value="_blank">_blank</option>
							<option value="_self">_self</option>
							<option value="_parent">_parent</option>
							<option value="_top">_top</option>
					</select>
			  		</fieldset>
			</div>
	
	 <br /><br /><br /><br />
     <div id="botao" align="center">
     	<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
        <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
     </div>
</form>
</fieldset>

</div>
