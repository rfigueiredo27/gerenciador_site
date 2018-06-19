function carregaPag(pag, pdiv){
	   document.getElementById(pdiv).innerHTML = "<div align='center' style='padding:20px;'><img src='img/loading.gif' alt='Carregando, aguarde por favor...'></div>";
	   $.post(pag, function(resposta){
		   $("#" + pdiv).html(resposta);
		   zera_contador();
		   }
	   );
	}


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
	   zera_contador();
	   }
   );
}

//Visualiza todas as apps que o usuário tem acesso
function visualizaAPPS() {
   document.getElementById("conteudo").innerHTML = "<div align='center' style='padding:20px;'><img src='img/loading.gif' alt='Carregando, aguarde por favor...'></div>";
   document.getElementById("informacoes").innerHTML = informacoes_default;
   $.post("login/carrega_apps.jsp", function(resposta){
	   $("#conteudo").html(resposta);
	   zera_contador();
	   }
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


//---------------------------------------------------------------------------------------
//Controla a quantidade de caracteres que est� sendo digitada na textarea
//---------------------------------------------------------------------------------------
function resta(pcampo, pcontador, ptamanho)
{
	if (pcampo.value.length > ptamanho)
		pcampo.value = pcampo.value.substring(0,ptamanho);
	else		   
    	document.getElementById(pcontador).innerHTML = "Ainda restam " + (ptamanho - pcampo.value.length) + " caracteres.";
/*	var contador = document.getElementById('contadorDescricao');
	with (f)
	{
		if (descricao.value.length > 600)
			descricao.value = descricao.value.substring(0,600);
      else		   
	       contadorDescricao.innerHTML = "Ainda restam " + (600 - descricao.value.length) + " caracteres.";
	}*/
}

//---------------------------------------------------------------------------------------
//Verifica se a data � v�lida
//---------------------------------------------------------------------------------------
function EhData(d)
{
 ano = d.substring(6,10);
 mes = parseFloat(d.substring(3,5))-1;
 dia = parseFloat(d.substring(0,2));
 
 dat2 = new Date(ano,mes,dia);
	   
 if (ano==dat2.getFullYear() && mes==dat2.getMonth() && dia==dat2.getDate())
	   return true;
 else
	   return false;
}

//-------------------------------
function SomenteNumeros(event)
{
	var tecla = window.event ? event.keyCode : event.which;
	if ((tecla < 48)||(tecla > 57))
		event.returnValue = false;
}
	
	
//-------------------------------
function FormataNumero(Campo,teclapres)
{
	var tecla = teclapres.keyCode;
	vr = Campo.value;
	
	vr = vr.replace( ".", "" );
	vr = vr.replace( ".", "" );
	vr = vr.replace( ".", "" );
	tam = vr.length + 1;

  if (!isNaN(vr))
	{
	      if ( tam > 3 && tam < 6 )
			 Campo.value = vr.substr( 0, tam - 3  ) + '.' + vr.substr( tam - 3, tam );
		
		  if ( tam >= 6 && tam <= 9 )
			 Campo.value = vr.substr( 0, 3 ) + '.' + vr.substr( 3, 3 );    
	}
}

