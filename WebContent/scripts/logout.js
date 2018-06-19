// JavaScript Document
$(function() {
	   
	$("#logout").click(function() {
       $.post("/gecoi.3.0/includes/logout.jsp", function(resposta) {
         if(resposta.indexOf("sucesso") > -1)
            $(location).attr("href","/gecoi.3.0/login/login.jsp");
       });
    });
});