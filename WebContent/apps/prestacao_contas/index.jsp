<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>



<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/prestacao_contas/css/prestacao.css" />
<script src="/gecoi.3.0/apps/prestacao_contas/scripts/criticas.js" charset="UTF-8"> </script>
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-timepicker-addon.js"></script> 
<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/jquery-ui-timepicker-addon.css" />

<!-- CKEditor -->
<script src="/gecoi.3.0/scripts/ckeditor/ckeditor.js"></script>

<style type="text/css">
#preview {
	overflow:hidden;
}

</style>
<script>

function atualizaTela()
{
	document.fincInclusao.reset();
}

function excluir(vidConteudo, vdescricao, f)
{
	if (confirm("Deseja realmente excluir o edital " + vdescricao + "?" ) == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar(f);});
}

function listar(f)
{
	document.getElementById("resultado").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/prestacao_contas/lista.jsp", {ano: f.ano.value}, function(resposta) {$("#resultado").html(resposta);zera_contador();});
}

function listar2(ano)
{
	document.getElementById("resultado").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/prestacao_contas/lista.jsp?ano="+ano, function(resposta) {$("#resultado").html(resposta);zera_contador();});
}


$(document).ready(function(){
		$( "#tabs" ).tabs();		
	});



</script>

<%
Calendar c = Calendar.getInstance();
//String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
String vhoje = ft.format(c.getTime());
String vselecao = "";
//carregaPag('/gecoi.3.0/apps/prestacao_contas/lista_reportagem.jsp', 'listaReportagem');
%>
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="" title="" id="">Incluir nova</a></li>
            <li><a href='#tabs-2' onclick="" title="" id="">Presta&ccedil;&atilde;o de Contas Cadastradas</a></li>
        </ul>
        <div id="tabs-1">
                	<div id="nova">
                    	<%@include file="incluir.jsp"%>
                	</div> 
        </div>
        <div id="tabs-2">
                	<div id="lista">
                    	<%@include file="busca.jsp"%>
                	</div> 
        </div>
    </div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 