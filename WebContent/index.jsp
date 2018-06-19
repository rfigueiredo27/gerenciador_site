<%@include file="/includes/autoriza.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html dir="ltr" xml:lang="pt-br" lang="pt-br" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <meta name="description" content="Sistema de Gerenciamento de Conteúdo da Internet e Intranet - GECOI"/>
   <meta name="author" content="Seção de Administração Internet e Intranet - SEINTE"/>   
   <meta http-equiv="Content-Language" content="pt" />
   <meta http-equiv="Expires" content="0" />
   <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />
   <meta http-equiv="Pragma" content="no-cache" />
   <meta name="robots" content="noindex,nofollow">
   
   <title>Gecoi 3.0</title>

   <!--Scripts do Jquery-->
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" src="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css"/>
    

   
   
   <!--Scripts e estilos da aplicação-->
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/css/global.css"/>
   <link rel="stylesheet" media="all" type="text/css" href="/gecoi.3.0/css/tabela_gecoi.css" />
   <script type="text/javascript" src="/gecoi.3.0/scripts/logout.js" charset="UTF-8"></script>
   <script type="text/javascript" src="/gecoi.3.0/scripts/globais.js" charset="UTF-8"></script>   
   <script type="text/javascript" src="/gecoi.3.0/scripts/verifica_sessao.js" charset="UTF-8"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/css/print.css" media="print"/>
   
   <!--Scripts e estilos da Introdução-->
   <!--<link href="jquery/intro.js-0.9.0/assets/css/bootstrap.min.css" rel="stylesheet">-->
   <link href="jquery/intro.js-0.9.0/assets/css/introjs.css" rel="stylesheet">
   <link href="jquery/intro.js-0.9.0/assets/css/bootstrap-responsive.min.css" rel="stylesheet">
   <script type="text/javascript" src="jquery/intro.js-0.9.0/minified/intro.min.js"></script>
   
   
   <noscript>Seu navegador n&atilde;o suporta a execu&ccedil;&atilde;o de scripts ou est&aacute; que est&aacute; fun&ccedil;&atilde;o desabilitada.</noscript>
<style type="text/css">
#conteudo {
	overflow:hidden;
}
</style>
</head>
<body>
<div id="container">

	<div id="barra_ferramentas">
       <div id="barra_identificacao">
          <span>Gerenciador de Conte&uacute;dos da Intranet e Internet - TRE-RJ</span>
          <span data-step="2" data-intro="Tempo da sessão. O GECOI agora avisa quando a sessão vai expirar para que você não perca o seu trabalho no meio." id="contador"></span>
       </div>
       <div id="barra_saida" data-step="7" data-intro="Por aqui você consegue sair do sistema de forma segura. Sempre utilize essa opção quando não for mais trabalhar no GECOI.">
          <span><a href="#" id="logout">Sair do Sistema</a></span>
       </div>
		<%@include file="/apps/global/ler_banco.jsp"%>
       <div id="div_banco">
       		<span id="span_banco"> - <%=vambiente2 %></span>
       </div>
    
    </div>
    
    <div id="logo_topo">
    
    	<div id="logo"></div>
    
   		<div id="espaco"></div>
        
    </div>
    
    	<div id="trabalho">
    
    		<div id="menu">
    		  <div data-step="3" data-intro="Aqui ficam os aplicativos comuns a todos os usuários!" id="app_globais">
				  <a href="javascript:void(0);" onclick="javascript:introJs().start();"><img src="img/icones/tour.png" title="Tour pelo sistema" /></a>
				  <a href="javascript:void(0);" onclick="desabilitaImgSelect();javascript:visualizaAPPS();"><img src="img/icones/my_apps.png" title="Meus aplicativos" data-step="4" data-intro="Através dessa opção você poderá visualizar todos os aplicativos disponíveis para você."/></a>
				  <a href="javascript:void(0);" onclick="desabilitaImgSelect();carregaAPP('/gecoi.3.0/apps/gerenciamento_usuarios/usuarios_app.jsp','Lista de usu&aacute;rios que possuem acesso ao aplicativo.');" ><img src="img/icones/users.png" title="Usuários com acesso" data-step="5" data-intro="Por essa opção você poderá visualizar todos os usuários que acessam os mesmos aplicativos que você."/></a>
				</div>
          </div>
    		
                 
   			<div id="conteudo" data-step="6" data-intro="Aqui é a área de trabalho onde serão visualizados todos os aplicativos disponíveis. Quando clicar em um aplicativo ele será carregado aqui também." >
   			<% 
   				/*if (vlogin.compareToIgnoreCase("")==0)
   				{
   					session.setAttribute("login","");
   					session.setAttribute("senha","");
   				}*/
   			%>
                  <%@include file="/login/carrega_apps.jsp"%>
   			</div>
   			
   			
   			<div id="informacoes">
   			  <a href="javascript:void(0);" onclick="javascript:introJs().start();"><h1 data-step="1" data-intro="O que há de novo? Você gostaria de fazer um pequeno tour sobre as novas funcionalidades do GECOI?">Bem vindo ao GECOI 3.0.</h1></a>
   			  <p>No painel ao lado voc&ecirc; tem acesso aso aplicativos dispon&iacute;veis ao seu usu&aacute;rio.</p>
   			  <p>Se o aplicativo que deseja utilizar n&atilde;o est&aacute; aparecendo, solicite o devido acesso para a SEINTE.</p>
   			</div>            
        </div>
</div>

<!--Div de Sessão, só visível quando o tempo da sessão estiver expirando-->
<div id="dialog-confirm" title="Atenção"> 

  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Sua sess&atilde;o vai expirar em <span id="contador2"></span> segundos. Deseja renovar a sess&atilde;o?</p>
</div>

<!--Divque irá executar o processamento da app, recuperando a mensagem de erro ou sucesso-->
<div id="processa_app"></div>
<iframe name="processa_background" marginwidth="0" marginheight="0" frameborder="0" title="Processamento em background" style="visibility:hidden;">
    <span>Utilizado para processar em background</span>
</iframe>

</body>
</html>
