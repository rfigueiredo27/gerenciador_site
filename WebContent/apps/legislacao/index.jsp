<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, java.text.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<%@include file="/includes/prepara_barra_progresso.jsp"%>

<link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/apps/legislacao/css/legislacao.css" />
<script src="/gecoi.3.0/apps/legislacao/scripts/criticas.js" charset="UTF-8"> </script>
<link href="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/gecoi.3.0/scripts/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<style type="text/css">
#preview {
	overflow:hidden;
}

</style>
<script>

function excluir(vidConteudo, vdescricao, f)
{
	if (confirm("Deseja realmente excluir a legisla\u00e7\u00e3o " + vdescricao + "?" ) == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao.jsp", {idConteudo : vidConteudo}, function(){top.listar(f);});
}

function listar(f)
{
	document.getElementById("resultado").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
	$.post("/gecoi.3.0/apps/legislacao/lista_legislacao.jsp", {ano: f.ano.value, legislacao : f.tipoAlteraLegislacao.value}, function(resposta) {$("#resultado").html(resposta);zera_contador();});
}


$(document).ready(function(){
		$( "#tabs" ).tabs();		
		$( "#dataLegislacao" ).datepicker();
		$("#tipo_norma").hide();
	});

function FormataData(Campo,teclapres)
{
	var tecla = teclapres.keyCode;
	vr = Campo.value;
	
	vr = vr.replace( ".", "" );
	vr = vr.replace( "/", "" );
	vr = vr.replace( "/", "" );
	tam = vr.length + 1;

    if (!isNaN(vr))
	{
	   if ( tecla != 9 && tecla != 8 )
       {
 	      if ( tam > 2 && tam < 5 )
			 Campo.value = vr.substr( 0, tam - 2  ) + '/' + vr.substr( tam - 2, tam );
		
		  if ( tam >= 5 && tam <= 8 )
			 Campo.value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 2 ) + '/' + vr.substr( 4, 4 ); 
	 
       }
	}
}

function SoNumero(event, campo)
{ 

	// verifica o evento ativado (IE ou FF) 
	var tecla = window.event ? event.keyCode : event.which; 

	// verifica a parte numérica do teclado 
	if(tecla > 44 && tecla < 58 || tecla > 95 && tecla < 106 || tecla == 08 || tecla == 190) 
	{ 
		// quando só numero 
		return false; 
	} 
	else 
	{ 
		// quando letra
		// retorna alerta 
		//window.alert("somente números") 

		// pega o texto do input 
		valor_input = campo.value; 

		// pega o tamanho do texto do input e retira um (letra) 
		tamanho_input = campo.value.length-1; 

		// armazena em escreve sem a letra 
		escreve = valor_input.substring(0,tamanho_input);

		// escreve no input sem a letra 
		campo.value = escreve; 
		return false; 
	} 
} 
</script>

<%
request.setCharacterEncoding("UTF-8");
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 0;
Calendar c = Calendar.getInstance();
//String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yyyy");
String vhoje = ft.format(c.getTime());
ft = new SimpleDateFormat ("yy");
String vano = ft.format(c.getTime());
String vselecao = "";
//carregaPag('/gecoi.3.0/apps/noticias_interno/lista_reportagem.jsp', 'listaReportagem');
%>
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="" title="" id="">Incluir nova</a></li>
            <li><a href='#tabs-2' onclick="" title="" id="">Legisla&ccedil;&otilde;es Cadastradas</a></li>
        </ul>
        <div id="tabs-1">
                	<div id="nova_reportagem">
                    	<%@include file="incluir_legislacao.jsp"%>
                	</div> 
        </div>
        <div id="tabs-2">
                	<div id="listaReportagem">
                    	<%@include file="busca_legislacao.jsp"%>
                	</div> 
        </div>
    </div>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 