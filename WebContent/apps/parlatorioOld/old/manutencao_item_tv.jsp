<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, br.jus.trerj.funcoes.GravarArquivo" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<%
String vimagem = "/gecoi.3.0/img/adicionar.png";
%>

   <!-- usado no curriculo -->
   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/jquery.imgareaselect.pack.js"></script>
<!--   <script type="text/javascript" src="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.js"></script>-->
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/imgareaselect-default.css" />
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/imgareaselect/js-modules/prettify.css" />
   <script type="text/javascript" src="/gecoi.3.0/scripts/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<!--   <script type="text/javascript" src="/gecoi.3.0/curriculo/scripts/critica_novo_curriculo.js"></script>-->
<style type="text/css">
	.invisivel { display:none; };  
</style>

<script>
 

function preview(img, selection)
{
	/*
		check if selection are made
	*/
	if (!selection.width || !selection.height)
		return;
	
	/*
		setting scaling variable
	*/
	var scaleX = 100 / selection.width;
	var scaleY = 100 / selection.height;
	
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	/*$('#x2').val(selection.x2);
	$('#y2').val(selection.y2);*/
	$('#w').val(selection.width);
	$('#h').val(selection.height);    
}


function habilitaSelecaoFotoInicial()
{
	//$('#foto').imgAreaSelect({parent:  'tabs-1', resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	$('#foto').imgAreaSelect({ resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//var ias = $('#foto').imgAreaSelect({instance: true, resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect().update();
	//ias.update();
}

function habilitaSelecaoFoto()
{
	
	if (document.getElementById("nomeArquivo").value != "")
	{
		//$('#foto').imgAreaSelect({ show: true, x1: document.fcurriculo.x1.value, y1 : document.fcurriculo.y1.value, x2: document.fcurriculo.x1.value + document.fcurriculo.w.value, y2 : document.fcurriculo.y1.value + document.fcurriculo.h.value,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
		var ias = $('#foto').imgAreaSelect({ instance: true });
		ias.setSelection(parseInt(document.fcurriculo.x1.value), parseInt(document.fcurriculo.y1.value), parseInt(document.fcurriculo.x1.value) + parseInt(document.fcurriculo.w.value), parseInt(document.fcurriculo.y1.value) + parseInt(document.fcurriculo.h.value), true);
		ias.setOptions({show: true,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview});
		ias.update();
	}
	//var ias = $('#foto').imgAreaSelect({ instance: true, show: true, x1: document.fcurriculo.x1.value, y1 : document.fcurriculo.y1.value, x2: document.fcurriculo.x1.value + document.fcurriculo.w.value, y2 : document.fcurriculo.y1.value + document.fcurriculo.h.value,  resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
	//$('#foto').imgAreaSelect().update();
	//ias.update();
}

function desabilitaSelecaoFoto()
{
	if (document.getElementById("nomeArquivo").value != "")
		$('#foto').imgAreaSelect({ hide: true });
}

function carregaFoto()
{	
	var nome = document.getElementById("arquivo").files[0];
	var oFReader = new FileReader();
    
    oFReader.readAsDataURL(document.getElementById("arquivo").files[0]);
    
    oFReader.onload = function (oFREvent) {
        document.getElementById("foto").src = oFREvent.target.result;
    };

    document.getElementById("nomeArquivo").value = document.getElementById("arquivo").value;
    //document.getElementById("divbotaofoto").innerHTML = "<img id='excluir_foto' name='excluir_foto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirFoto();' /><img id='incluir_foto' name='incluir_foto' src='/gecoi.3.0/img/botao_incluir.png' onclick='habilitaSelecaoFotoInicial();$(\"#arquivo\").click();' />";
    document.getElementById("divbotaofoto").innerHTML = "<img id='excluir_foto' name='excluir_foto' src='/gecoi.3.0/img/botao_excluir.png' onclick='excluirFoto();' /><img id='incluir_foto' name='incluir_foto' src='/gecoi.3.0/img/botao_incluir.png' onclick='desabilitaSelecaoFoto();habilitaSelecaoFotoInicial();$(\"#arquivo\").click();' />";    
    habilitaSelecaoFotoInicial();
}


function abreFoto()
{
	//habilitaSelecaoFotoInicial();
	if (document.getElementById("nomeArquivo").value == "")
		$("#arquivo").click();	
}


function excluirFoto()
{
	$('#foto').imgAreaSelect({ hide: true, disable: true });
	document.getElementById("divfoto").innerHTML = "<img name='foto' id='foto'  src='<%=vimagem %>' onclick='habilitaSelecaoFotoInicial();abreFoto();' />";
	document.getElementById("nomeArquivo").value = "";
	document.getElementById("divbotaofoto").innerHTML = "";
	document.getElementById("x1").value = "-";
	document.getElementById("y1").value = "-";
	document.getElementById("w").value = "-";
	document.getElementById("h").value = "-";
	document.getElementById("nomeArquivo").value = "";
}

function atualizaTela(pdescricao, pid_arquivo, pid_conteudo)
{
	carregaPag("/gecoi.3.0/apps/parlatorio/manutencao_tv.jsp", "divtv");
}

function criticaItem()
{
	//critica_inclusao_item(document.fitemtv);
	document.fitemtv.submit();
}
</script>
<%
String vdescricaoCompleta = request.getParameter("reportagem");
String[] vdescricaoReportagem = request.getParameter("reportagem").split("@@");
int vid_arquivo = Integer.parseInt(request.getParameter("idarquivo"));
int vid_conteudo = Integer.parseInt(request.getParameter("idconteudo"));
String vdescricaoItemTv = "";
int vordem = 2;
Calendar c = Calendar.getInstance();
String vdataItemTv = c.get(Calendar.DATE) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.YEAR);
String vacao = "/gecoi.3.0/apps/parlatorio/processa_incluir_item_tv.jsp";
int vid_selecionado = 0;
out.print(vid_arquivo);
try
{
	//Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

/*	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as dataItemTv, Decode(ordem, 1 , 999, ordem) AS ordem, " +
					"(Select Nvl(max(ordem) + 1,2) from gecoi.arquivo where id_conteudo = ? and ordem > 1) as proximaOrdem " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_arquivo = ? ";*/
	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as dataItemTv, aq.ordem, " +
					"(Select Nvl(max(ordem) + 1,2) from gecoi.arquivo where id_conteudo = ? and ordem > 1) as proximaOrdem, " +
					"(SELECT id_arquivo_referencia FROM gecoi.referencia r WHERE r.id_arquivo_principal = aq.id_arquivo) AS selecionado " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND aq.id_arquivo = ? ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_conteudo);
	pstm.setInt(2, vid_arquivo);
	resultSet = pstm.executeQuery();
	if ( resultSet.next() )
	{
		if (resultSet.getInt("selecionado") > 0)
		{
			String[] vdescricao = resultSet.getString("descricao").split("@@");
			vdescricaoItemTv = vdescricao[1];
			vordem = resultSet.getInt("proximaOrdem");
			vdataItemTv = resultSet.getString("dataItemTv");
			vid_selecionado = resultSet.getInt("selecionado");
			//vid_arquivo = vid_selecionado;
			vacao = "/gecoi.3.0/apps/parlatorio/processa_alterar_item_tv.jsp";
		}
	}
	resultSet.close();
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
Editando o item na TV<br />
Se&ccedil;&atilde;o: <%=vdescricaoReportagem[0]%><br />
<!--Reportagem: <%//=vdescricaoReportagem[1]%> <br /> -->
<!--<form name="fitemtv" action="<%//=vacao%>" method="post"  target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off" >-->
<!--<form name="fitemtv" action="/gecoi.3.0/apps/parlatorio/processa_alterar_item_tv.jsp" method="post"  target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off" >-->
<form name="fitemtv" action="<%=vacao%>" method="post" target="processa_background" enctype="multipart/form-data" >

<input type="text" name="secao" id="secao" value="<%=vdescricaoReportagem[0]%>" />
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vid_conteudo%>" />
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vid_arquivo%>" />
<div id="data_item_tv">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataItemTv" id="dataItemTv" size="10" maxlength="10"value="<%=vdataItemTv%>"/>
            </fieldset>
	    </div>
<div id="ordem_item_tv">
    		<fieldset>
                <legend>Ordem</legend>
				<input type="text" maxlength="1" onClick="SomenteNumeros(event);" name="ordem" id="ordem" value="<%=vordem-1%>" />
            </fieldset>
	    </div>
<div id="descricao_item_tv">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o</legend>
				<textarea title="Descri&ccedil;&atilde;o do Item da TV" alt="Descri&ccedil;&atilde;o do Item da TV" name="descricaoItemTv" id="descricaoItemTv"><%=vdescricaoItemTv%></textarea>
            </fieldset>
	    </div>
        <div id="incluir_imagem_item_tv">
      		<fieldset>
        	<legend>Incluir Imagem do Item da TV</legend>
        	<div id="campoArquivo" align="left">
            	<!--<input title="Imagem a ser inserida" alt="Imagem a ser inserida" type="file" name="arquivo" id="arquivo" />-->
            </div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
            <%
			if (vid_selecionado > 0)
			{
				String vdiretorio = application.getRealPath("/") + "webtemp";
				GravarArquivo gravarArquivo = new GravarArquivo();
				vimagem = gravarArquivo.gravar(""+vid_selecionado, vdiretorio, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
				out.print("<img src='/gecoi.3.0/webtemp/" + vimagem + "' width='100' heigth='100' />");
			}
			%>
            
            <div id="divfoto"  > <img name="foto" id="foto"  src="/gecoi.3.0/webtemp/<%=vimagem %>" onclick="abreFoto();"  /><%=vimagem %></div>
            <div id="divbotaofoto"></div>
            <input type="file" name="arquivo" id="arquivo" onChange="carregaFoto();" class="invisivel"/>
            <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaCurriculo(this.form);desabilitaSelecaoFoto();"  />
     		<input type="hidden" id="x1" value="-" name="x1" />
     		<input type="hidden" id="y1" value="-" name="y1" />
     		<input type="hidden" value="-" id="w" name="w" />
     		<input type="hidden" id="h" value="-" name="h" />
     		<input type="hidden" id="nomeArquivo" name="nomeArquivo" />
            
   		  </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela('<%=vdescricaoCompleta%>', <%=vid_arquivo%>, <%=vid_conteudo%>);" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaItem();"  />
      </div>
</form>
<iframe name="processa_background" frameborder="0" allowtransparency="yes" height="100" width="100"></iframe> 