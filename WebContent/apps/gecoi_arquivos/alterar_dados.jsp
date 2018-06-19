
<%@page import="java.net.URLDecoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<%
String vidArquivo = request.getParameter("idArquivo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = URLDecoder.decode(request.getParameter("descricao"), "UTF-8");
String vdataPublicacao = request.getParameter("dataPublicacao");
int varea = Integer.parseInt(request.getParameter("area"));
String vObservacao = request.getParameter("observacao");
String vdescricao_conteudo = request.getParameter("descricao_conteudo");
String vdescricao_area = request.getParameter("descricao_area");

%>
<script>

function alterar()
{
	
	if (critica_altera_arquivos(document.farquivos_alt))
	{
	
		$.post("/gecoi.3.0/apps/gecoi_arquivos/processa_alteracao.jsp", {idConteudo: document.farquivos_alt.idconteudo.value, 
										  idArquivo : document.farquivos_alt.idarquivo.value, 
										  descricao_conteudo: document.farquivos_alt.descricao_conteudo.value,
										  descricao_arquivo: document.farquivos_alt.descricao_arquivo.value,
										  dataPublicacao: document.farquivos_alt.dataPublicacao.value,
										  idArea: document.farquivos_alt.idarea.options[document.farquivos_alt.idarea.selectedIndex].value,
										  observacao: document.farquivos_alt.obs.value
										  }, function(){listar();});
	}
}
</script>

<div id="altera_dados">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do arquivo</legend>
<form name="farquivos_alt" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<%-- <input type="hidden" name="idarea" id="idarea" value="<%=varea %>"/> --%>

	<div id="selecionar_area" align="left" style="min-height: 80px;">
		<fieldset style="min-height: 80px;">
			<legend>Área de Publicação*</legend>
			<select name='idarea' id='idarea' required>
				
<!-- 				Pegar a área do arquivo -->
				<jsp:useBean id="get_area"	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
				<c:set var="item" value="${get_area.getAreaById(sessionScope['login'], sessionScope['senha'], param.area)}" />
 				<c:forEach var="item_gecoi" items="${item}">
					<option value="${item_gecoi.idArea}">${item_gecoi.descricao_area }</option>
 				</c:forEach>
				
<!-- 				Carregar as áreas que a pessoa tem acesso -->
				<jsp:useBean id="lista_alt"	class="br.jus.trerj.controle.gecoiArquivos.ListaGecoiArquivos" />
				<c:set var="items" value="${lista_alt.getArea(sessionScope['login'], sessionScope['senha'])}" />	
				<c:forEach var="lista_gecoi" items="${items}">
					<option value="${lista_gecoi.idArea}">${lista_gecoi.descricao_area }</option>
				</c:forEach>
			</select>
		</fieldset>
	</div>
	 <div id="titulo" style="min-height:30px;">
         <fieldset style="min-height:30px;">
       		<legend>Descrição do Conteúdo</legend>
   			<input type="text" title="Titulo do arquivo" name="descricao_conteudo" id="descricao_conteudo" value="<%=vdescricao_conteudo %>" />
		 </fieldset>
     </div>
     <div id="titulo" style="min-height:30px;">
         <fieldset style="min-height:30px;">
       		<legend>Descrição do Arquivo</legend>
   			<input type="text" title="Titulo do arquivo" name="descricao_arquivo" id="descricao_arquivo" value="<%=vdescricao %>" />
		 </fieldset>
     </div>
     <div id="titulo" style="min-height:30px;">
         <fieldset style="min-height:30px;">
       		<legend>Observação</legend>
   			<input type="text" title="Titulo do arquivo" name="obs" id="obs" value="<%=vObservacao %>" />
		 </fieldset>
     </div>
     <div id="data_publicacao" align="center" style="min-height:30px;">
    		<fieldset style="min-height:30px;">
                <legend>Data de Publicação</legend>
                <input title="Data de publicação" alt="Data de publicação" type="text" class="altera_data" name="dataPublicacao" id="dataPublicacao4" value="<%=vdataPublicacao %>" />
	  		</fieldset>
	 </div>
	 <br /><br /><br /><br /><br /><br /><br />
     <div id="botao" align="center">
     	<input type="button" name="cancelar" value="Cancelar" onclick="listar();" />
        <input type="button" name="save" value="Grava alterações" onclick="alterar();" />
     </div>
</form>
</fieldset>
</div>
<script>
$( function() {
	    $( ".altera_data" ).datepicker();
	  } );
</script>