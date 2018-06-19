//Cria variável global para recuperar o valor default da div informacoes
$(function() {
    informacoes_default = document.getElementById("informacoes").innerHTML;
	
    //verifica a resolução da tela do usuário 
    resolucao_tela = $(window).width();
	
    if (resolucao_tela >=1024 ){
     $("#informacoes").show();
    }else{
     $("#informacoes").hide();
	 $("#conteudo").css("width","90%");
	}
});

//Carrega a app escolhida na tela
function carregaAPP(app,desc){
   document.getElementById("conteudo").innerHTML = "<div align='center' style='padding:20px;'><img src='img/loading.gif' alt='Carregando, aguarde por favor...'></div>";
   $.post(app, function(resposta){
	   $("#conteudo").html(resposta);
	   document.getElementById("informacoes").innerHTML = "<h1>Descri&ccedil;&atilde;o do aplicativo</h1>" + desc;
	   }
   );
}

//Visualiza todas as apps que o usuário tem acesso
function visualizaAPPS() {
   document.getElementById("conteudo").innerHTML = "<div align='center' style='padding:20px;'><img src='img/loading.gif' alt='Carregando, aguarde por favor...'></div>";
   document.getElementById("informacoes").innerHTML = informacoes_default;
   $.post("login/carrega_apps.jsp", function(resposta){
	   $("#conteudo").html(resposta);}
   );	
}

//Utlizada pela APP para procesar o formulário e retornar a mensagem do processamento: erro ou sucesso
function atualizaMSG(txt){
	alert(txt);
}

function listaUsuariosApp()
{
	$.post("/gecoi.3.0/listaUsuarios", {idApp : document.fUsuariosApp.apps.value}, function(data) {$("#resultado").html(data);});
}

function desabilitaImgSelect()
{
	if ( $( "#foto" ).length ) 
	{
    	$('#foto').imgAreaSelect({ hide: true });
	}
}
