$(function() {
    var name = $( "#name" ),
    password = $( "#password" ),
    allFields = $( [] ).add( name ).add( password ),
    tips = $( ".validateTips" );

    function updateTips( t ) {
      tips
      .text( t )
      .addClass( "ui-state-highlight" );
      setTimeout(function() {
         tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
	
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
         o.addClass( "ui-state-error" );
         updateTips( "Tamanho do(a) " + n + " deve estar entre " +
         min + " e " + max + "." );
         return false;
      } else {
         return true;
      }
    }
	
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
         o.addClass( "ui-state-error" );
         updateTips( n );
         return false;
      } else {
         return true;
      }
    }
	
    $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 420,
      width: 350,
      modal: true,
      buttons: {
         "Entrar": function() {
            var bValid = true;
            allFields.removeClass( "ui-state-error" );
            bValid = bValid && checkLength( name, "usuário", 3, 20 );
            bValid = bValid && checkLength( password, "senha", 5, 20 );
            //bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "O nome do Usuário consiste de caracters de a-z, 0-9, começando com uma letra." );
            // From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
            //bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );
            //bValid = bValid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Apenas os seguintes caracteres são permitidos : a-z 0-9" );
        
		    if ( bValid ) {
               	$.post("processa_login.jsp", { name: document.getElementById("name").value, password: document.getElementById("password").value }, function(resposta) {
 		             if(resposta.indexOf("sucesso") > -1)
 				        $(location).attr("href","/gecoi.3.0/index.jsp");
					 else
     					 updateTips(resposta);

				});
            }
         },
         Cancelar: function() {
            $( this ).dialog( "close" );
         }
      },
      close: function() {
         allFields.val( "" ).removeClass( "ui-state-error" );
      },
	  open: function() {
		   //verifica se foi enviada alguma mensagem diretamente para a página de login
		   if(document.getElementById("msg").value!="-"){
             updateTips(document.getElementById("msg").value); 
			 document.getElementById("msg").value = "Essa área é de uso restrito a usuários cadastrados.";
		   }
		
		   //usada para reconhecer se o usuário pressionou a tecla enter
		   $("#dialog-form").keypress(function(e) {
              if (e.keyCode == $.ui.keyCode.ENTER) {
                 $(this).parent().find("button:eq(1)").trigger("click");
              }
           });
	  }
    });

    $( "#botao_entrar" )
       .button()
       .click(function() {
          $("#dialog-form").dialog("open");
       });
	   
   $( "#dialog-form" ).dialog( "open" );	   
});

