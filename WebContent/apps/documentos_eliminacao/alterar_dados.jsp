
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");
String vdataPublicacao = request.getParameter("data");
String varea = request.getParameter("area");
String vedital = request.getParameter("edital");
String vunidade = request.getParameter("unidade");
//String vObservacao = request.getParameter("observacao");

%>
<script>

function alterar()
{
	
	if (critica_altera_arquivos(document.farquivos_alt))
	{
	
		$.post("/gecoi.3.0/apps/documentos_eliminacao/processa_alteracao.jsp", 
										  {
											idConteudo: document.farquivos_alt.idconteudo.value, 
										  	idArquivo : document.farquivos_alt.idarquivo.value,
										  	idArea: document.farquivos_alt.idarea.value,
										  	unidade: document.farquivos_alt.unidade.value,
										  	edital: document.farquivos_alt.edital.value,
										  	dataPublicacao: document.farquivos_alt.dataPublicacao2.value,
										  	descricao: document.farquivos_alt.descricao1.value
										  	
										  }, function(){listar();});
	}
}
</script>

<div id="altera_dados">

<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Edital de Ciência de Eliminação de Documentos</legend>
<form name="farquivos_alt" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idarea" id="idarea" value="<%=varea %>"/>
	 <div id="flex">
	 <div id="unidade" >
		<fieldset>
			<legend>Unidade</legend>
			<jsp:useBean id="lista_grupos" class="br.jus.trerj.controle.gecoiCatalogo.ListaGecoiCatalogo" />
			<c:set var="items" value="${lista_grupos.getGrupo(sessionScope['login'], sessionScope['senha'])}" />
			<select name="unidade" id="unidade">
				<option value="<%=vunidade%>"><%=vunidade%></option>
				<c:forEach var="lista_grupo" items="${items}">
					<option value="${lista_grupo.descricao_grupo}">${lista_grupo.descricao_grupo}</option>
				</c:forEach>
			</select>
			</fieldset>
	</div>
	 
	 <div id="edital">
		<fieldset>
			<legend>Edital/Ano</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="edital" id="edital" value="<%=vedital %>"/>
		</fieldset>
	</div>
	
     <div id="data">
    		<fieldset>
                <legend>Data de Publicação</legend>
                <input title="Data de publicação" alt="Data de publicação" type="text" name="dataPublicacao2" id="dataPublicacao2" size="10" maxlength="10"  value="<%=vdataPublicacao %>" required/>
	  		</fieldset>
	</div>
	</div>
	
	<div id="arquivo_principal">
		<fieldset>
			<legend>Descrição do Edital de Ciência de Eliminação de Documentos</legend>
				<input type="text" title="Descri&ccedil;&atilde;o do objeto" name="descricao1" id="descricao1" placeholder="Descrição do Arquivo Principal" value="<%=vdescricao %>"/>
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
