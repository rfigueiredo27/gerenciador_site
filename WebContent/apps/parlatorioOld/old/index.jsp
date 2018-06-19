<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>

<!--
<script type="text/javascript" src="/intra_nova/scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/intra_nova/scripts/jquery-migrate-1.2.1.js"></script>   
   -->
<!--
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css"/>
-->
<!--
<link rel="stylesheet" href="/intra_nova/scripts/jquery_ui/jquery-ui.css" />  
<script type="text/javascript" src="/intra_nova/scripts/jquery_ui/jquery-ui.js"></script> 
   -->


<!--<script type="text/javascript" src="/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>-->
<script src="/gecoi.3.0/scripts/tinymce.4.5.4/js/tinymce/tinymce.min.js"></script>


<script src="/gecoi.3.0/apps/parlatorio/scripts/criticas.js" charset="UTF-8"> </script>


<script>

$(document).ready(function(){
		$( "#tabs" ).tabs();		
		$( "#tabs2" ).tabs();		
		$( "#tabs3" ).tabs();		
		$( "#dataAbertura" ).datepicker();
		$( "#dataReportagem" ).datepicker();
		$( "#dataBau" ).datepicker();
		carregaPag("/gecoi.3.0/apps/parlatorio/manutencao_tv.jsp", "divtv");
	});

function novo_parlatorio(f)
{
	$.post("processa_novo_parlatorio.jsp", {edicao: f.edicao.value, data: f.dataAbertura.value}, function (resposta){
																												$("#divaberto").css('visibility', 'visible');
																												$("#divnovo").css('visibility', 'hidden');
																												});
}

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
	if(tecla > 44 && tecla < 58 || tecla > 95 && tecla < 106 || tecla == 08) 
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
String vcor       = "#ECECEC";  // zebra a tabela
int vid_area = 2604;
String visivel_aberto = "";
String visivel_novo = "";
Calendar c = Calendar.getInstance();
String vhoje = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
int vid_conteudo = 0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT co.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND Nvl(co.observacao,' ') <> 'PUBLICADO' ";

	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1,vid_area);   
	  
	resultSet = pstm.executeQuery();		  
	if(resultSet.next())
	{
		visivel_aberto = "visible";
		visivel_novo = "hidden";
		vid_conteudo = resultSet.getInt("id_conteudo");
	}
	else
	{
		visivel_aberto = "hidden";
		visivel_novo = "visible";
	}
	resultSet.close();
	out.print(vid_conteudo);
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
%>
<div id="xx"></div>
<div id="divaberto" style="visibility:<%=visivel_aberto%>">
    Parlat&oacute;rio Edi&ccedil;&atilde;o 99 - DATA
    <br>BOT&Atilde;O PUBLICAR (ap&oacute;s publicar n&atilde;o poder&aacute; mais alterar)
    
    <div id='tabs'>
        <ul>
            <li><a href='#tabs-1' onclick="" title="Parlat&oacute;rio" id="">Parlat&oacute;rio</a></li>
            <li><a href='#tabs-2' onclick="" title="P&aacute;gina Principal" id="">P&aacute;gina Principal</a></li>
            <li><a href='#tabs-3' onclick="" title="Reportagens">Reportagens</a></li>
            <li><a href='#tabs-4' onclick="" title="Relat&oacute;rios">Relat&oacute;rios</a></li>
        </ul>
        <div id="tabs-1">
        	<%@include file="parlatorio.jsp"%>
        </div>
        <div id='tabs-2'>
            <div id='tabs2'>
                <ul>
                    <li><a href='#tabs-21' onclick="" title="Itens TV" id="">Itens TV</a></li>
                    <li><a href='#tabs-22' onclick="" title="Do Fundo do Ba&uacute;">Do Fundo do Ba&uacute;</a></li>
                    <li><a href='#tabs-23' onclick="" title="Preview">Preview</a></li>
                </ul>
                <div id='tabs-21'>
                <div id="divtv">
                S&oacute; aparece as reportagens j&aacute; inclusas e que n&atilde;o est&aacute; nem na se&ccedil;&atilde;o Do Fundo do Ba&uacute;.  Seleciona a reportagem e inclui a imagem (estilo contrato/licita&ccedil;&atilde;o)
                    <%//@include file="manutencao_tv.jsp"%>
                </div>
                </div> 
                <div id='tabs-22'>
                S&oacute; aparece as reportagens j&aacute; inclusas e que n&atilde;o est&atilde;o na TV.  Seleciona a reportagem e inclui a imagem (estilo contrato/licitacao)
                    <%@include file="manutencao_fundo.jsp"%>
                </div> 
                <div id='tabs-23'>
                    <%//@include file="incluir_novo.jsp"%>
                    <img src="/gecoi.3.0/img/PreviewParlatorio.jpg" />
                </div> 
            </div>
        </div>
        <div id="tabs-3">
            <div id='tabs3'>
                <ul>
                    <li><a href='#tabs-31' onclick="" title="Novas" id="">Novas</a></li>
                    <li><a href='#tabs-32' onclick="" title="Alterar">Alterar</a></li>
                </ul>
                <div id='tabs-31'>
                    <%@include file="incluir_reportagem.jsp"%>
                    <%//@include file="tinymce2.jsp"%>
                </div> 
                <div id='tabs-32'>
                    <%//@include file="incluir_novo.jsp"%>
                </div> 
            </div>
        </div>
        <div id="tabs-4">
        	<%//@include file="relatorios.jsp"%>
        </div>
    </div>
</div>

<div id="divnovo" style="visibility:<%=visivel_novo%>">
	N&atilde;o h&aacute; parlat&oacute;rio em processo de edi&ccedil;&atilde;o<br />
    Deseja abrir um novo?<br />
    <form name="fnovo" >
    	Edi&ccedil;&atilde;o: <input type="text" name="edicao" id="edicao" value="" onkeyup="SoNumero(event, this)" /><br />
        Data de abertura: <input title="Data de abertura" alt="Data de abertura" type="text" name="dataAbertura" id="dataAbertura" value="Abertura" onfocus="this.value='<%=vhoje%>'" size="10" maxlength="10" /><br />
    	<input type="button" name="bnovo" id="bnovo" value="Novo Parlat&oacute;rio" onclick="novo_parlatorio(this.form);" />
        Caminho do Flipbook:
        Arquivo PDF:
        Arquivo Word:
        Imagem da Capa:
    </form>
</div>
