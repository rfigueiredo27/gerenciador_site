<% 
//verifica se foi enviada alguma mensagem para a página de login
String vmsg = request.getParameter("msg")==null ? "-" : request.getParameter("msg");
%>

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
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/jquery/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css"/>
   
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/css/global.css"/>
   <script type="text/javascript" src="/gecoi.3.0/scripts/login.js" charset="UTF-8"></script>
   <link rel="stylesheet" type="text/css" href="/gecoi.3.0/css/login.css"/>
   
   <noscript>Seu navegador n&atilde;o suporta a execu&ccedil;&atilde;o de scripts ou est&aacute; que est&aacute; fun&ccedil;&atilde;o desabilitada.</noscript>
</head>

<body>
<div id="container">

	<div id="topo_login"></div>
    
    <div id="login">
    
    	<div id="botao_entrar"></div>
        <div id="processamento"></div>
  </div>
</div>

<!--Div de Login, só visível quando ainda não logado-->
<div id="dialog-form" title="Identifica&ccedil;&atilde;o do Usu&aacute;rio">
     <p class="validateTips">Essa &aacute;rea &eacute; de uso restrito a usu&aacute;rios cadastrados. </p>
        <form>
            <fieldset>
              <label for="name">Usu&aacute;rio</label>
              <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" maxlength="20">
              <label for="password">Senha</label>
              <input type="password" name="password" id="password" value="" class="text ui-widget-content ui-corner-all" maxlength="20">
              <input type="hidden" id="msg" value="<%=vmsg%>" />
            </fieldset>
        </form>
</div> 

</body>
</html>
