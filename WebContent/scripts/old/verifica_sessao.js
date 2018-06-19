var segundo = 0+"0";
var minuto = 0+"0";
var hora = 0+"0";
var segundo2 = 1771;
function zera_contador(){
	segundo = 0+"0";
    minuto = 0+"0";
	hora = 0+"0";
	segundo2 = 1771;
}
 
function tempo(){	
   if (segundo < 59){
       segundo++;
	   --segundo2;
       if(segundo < 10 ){segundo = "0"+segundo;}
	   if(segundo2 == 60 ){segundo2 = "0"+segundo2;}
	 
   }else if(segundo == 59 && minuto < 59){
          segundo = 0+"0";
	      minuto++;
	      if(minuto < 10){minuto = "0"+minuto;}
   }
   
   if(minuto == 59 && segundo == 59 && hora < 23){
       segundo = 0+"0";
       minuto = 0+"0";
       hora++;
       if(hora < 10){hora = "0"+hora;}
   }else if(minuto == 59 && segundo == 59 && hora == 23){
       segundo = 0+"0";
	   minuto = 0+"0";
	   hora = 0+"0";
   }
   document.getElementById("contador").innerHTML = " - Tempo de conexão: " + hora +":"+ minuto +":"+ segundo;
   
   if(segundo2 <= 60){   
   document.getElementById("contador2").innerHTML = + segundo2;
     }
	 
   if(minuto == 29 && segundo == 00 && hora < 23){
 	   $( "#dialog-confirm" ).dialog( "open" );
	  
   }
   
   if(minuto == 30 && segundo == 00 && hora < 23){
 	  window.location="/gecoi.3.0/login/login.jsp";
   }
   
   
}

$(function() {
    setInterval('tempo()',983);

    $( "#dialog-confirm" ).dialog({
        autoOpen: false,
        resizable: false,
        height:250,
        modal: true,
        buttons: {
           "Sim": function() {
              $.post("/gecoi.3.0/includes/atualiza_sessao.jsp", function(resposta) {
                 if(resposta.indexOf("sucesso") > -1)
                  $("#dialog-confirm").dialog( "close" );
			       zera_contador();
                });
			  
			  
           }, 
           "Não": function() {
               $.post("/gecoi.3.0/includes/logout.jsp", function(resposta) {
                 if(resposta.indexOf("sucesso") > -1)
                   $(location).attr("href","/gecoi.3.0/login/login.jsp");
                });
           }
        }
    });
});