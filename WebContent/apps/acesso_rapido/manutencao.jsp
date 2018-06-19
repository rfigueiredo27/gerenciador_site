<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<link rel="stylesheet" type="text/css"
	href="/gecoi.3.0/apps/revista_jurisprudencia/DataTable/css/jquery.dataTables.css">
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/revista_jurisprudencia/DataTable/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript"
	src="/gecoi.3.0/apps/revista_jurisprudencia/DataTable/js/tabela.js"></script>
<script>
function excluir(id_conteudo, vdescricao) {
	if (confirm("Deseja realmente excluir o Arquivo selecionado?") == true)
		$.post("/gecoi.3.0/apps/gecoi_arquivos/processa_exclusao.jsp", {
			idConteudo : id_conteudo
		}, function() {
			top.listar();
		});
}
</script>
<div id="divbusca" style="width: 100%">

<%@include file="listar.jsp"%>

</div>

