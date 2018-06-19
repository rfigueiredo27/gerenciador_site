
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<%
String vidCatalogo = request.getParameter("idCatalogo");
String vidConteudo = request.getParameter("idConteudo");
String vdescricao = request.getParameter("descricao");

%>
<script>

function alterar()
{	
	$.post("/gecoi.3.0/apps/gecoi_catalogo/processa_alteracao.jsp", {
										  idConteudo: document.farquivos_alt.idconteudo.value, 
										  idCatalogo : document.farquivos_alt.idcatalogo.value, 
										  descricao: document.farquivos_alt.descricao_dados.value
										  }, function(){listar();});	
}
</script>

<div id="altera_dados">
<fieldset>
	<legend>Altera&ccedil;&atilde;o dos dados do Catálogo</legend>
<form name="farquivos_alt" method="post" >
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<input type="hidden" name="idcatalogo" id="idcatalogo" value="<%=vidCatalogo%>"/>
	 <div id="titulo" style="min-height:30px;">
         <fieldset style="min-height:30px;">
       		<legend>Descrição do Conteúdo</legend>
   			<input type="text" title="Titulo do arquivo" name="descricao_dados" id="descricao_dados" value="<%=vdescricao %>" />
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
