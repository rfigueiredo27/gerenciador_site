<%@page import="java.io.BufferedReader, java.io.FileReader, java.io.File, br.jus.trerj.funcoes.GravarArquivo"%>
<script type="text/javascript" src="/gecoi.3.0/apps/destaques_intranet/scripts/critica_destaque.js"></script>

<script>

function executar()
{
	/*$.ajaxSetup({
		  url: "ping.php"
		});
	*/
	//$.post("processa_alteracao_curriculo.jsp", {idConteudo : document.fdescricao.idconteudo.value, descricao: document.fdescricao.descricao.value}, function(){});
	//$.post("/gecoi.3.0/AlteraCurriculoImg", {idConteudo : document.fdescricao.idconteudo.value, descricao: document.fdescricao.descricao.value}, function(){});
}

function atualizaTela()
{
	top.listar();
}
</script>

<script>
//$(document).ready(function(){
//	$('#foto2').imgAreaSelect({ resizable: false, handles: false,  maxWidth: 200, maxHeight: 150,  minWidth: 200, minHeight: 150, onSelectChange: preview });
//});
</script>
<%
String vidArquivo = request.getParameter("id");
String vidConteudo = request.getParameter("idConteudo");
String vdiretorio = application.getRealPath("/") + "webtemp";
String vdescricao = request.getParameter("descricao");
String vnomeArquivo = request.getParameter("nome");
String vimagem = "";

GravarArquivo gravarArquivo = new GravarArquivo();
//String vnome = gravarArquivo.gravar(vidConteudo, "jpg", vdiretorio, session.getAttribute("login").toString());
String vnome = gravarArquivo.gravar(vidArquivo, vdiretorio, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
if (vnome.equals("erro"))
{
	vimagem = "/gecoi.3.0/img/semfoto.jpg";
}
else
{
	vimagem = "/gecoi.3.0/webtemp/" + vnome;
	//File apagar = new File(getServletContext().getRealPath("/") + "webtemp\\" + vnome);
	//apagar.delete();
}
%>
<!--<form name="fimagem" action="" method="post" target="rodape" enctype="multipart/form-data">-->
 <form name="fimagem" action="/gecoi.3.0/AlteraDestaqueBanner" method="post" target="rodape" enctype="multipart/form-data"> 
<input type="hidden" name="descricao" id="descricao" value="<%=vdescricao%>"/>
<input type="hidden" name="idarquivo" id="idarquivo" value="<%=vidArquivo%>"/>
<input type="hidden" name="idconteudo" id="idconteudo" value="<%=vidConteudo%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
      	<div id="campoArquivo"><input title="Arquivo a ser substituído" alt="Arquivo a ser substituído" type="file" name="arquivo" id="arquivo" /></div>
		<div id="progressBar" style="display: none;">
			<div id="theMeter">
            	<div id="progressBarText"></div>
                <div id="progressBarBox">
                	<div id="progressBarBoxContent"></div>
               	</div>
            </div>
         </div>
        <div id="divfoto"> <img name="foto" id="foto"  src="<%=vimagem %>" /></div>
        </td>
      </tr>
      <tr>
        <td height="40" align="right" valign="middle">
           <input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAlteraDestaque(this.form);"  /> 
        </td>
      </tr>
  </table>
</form>
<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe> 
