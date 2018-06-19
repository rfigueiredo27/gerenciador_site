function goAjax(url, metodo, modo, id)
{
	ajax1 = createXMLHTTP();
    ajax1.open(metodo, url, modo);
	ajax1.setRequestHeader("Cache-Control","no-cache");
	ajax1.setRequestHeader("Pragma","no-cache");
	ajax1.setRequestHeader("Expires","-1");

    ajax1.onreadystatechange = function() {
           if(ajax1.readyState == 4)
		   {
              document.getElementById(id).innerHTML = ajax1.responseText;
			  
 		     //usado para acionar a função thickbox nas divs C1 a C12, atualizada pelo ajax
			 for (var i = 0; i <=12 ; i++)
			 {
			    tb_init("#C" + i + " a.thickbox");
			 }
		   }
    }   
    ajax1.send(null);
}

//-----------------------------------------------------------------------------------------------------------
function XMLHTTPRequest()
{   
    if (window.XMLHttpRequest)
	{   
       a=new XMLHttpRequest(); //Objeto nativo (FF/Safari/Opera7.6+)   
	} 
    else
	{   
       try
	   {   
            a=new ActiveXObject("Msxml2.XMLHTTP");  //activeX (IE5.5+/MSXML2+)   
       }     
       catch(e)
	   {   
           try
		   {   
                 a=new ActiveXObject("Microsoft.XMLHTTP"); //activeX (IE5+/MSXML1)   
           }     
           catch(e)
		   { /* O navegador nÃ£o tem suporte */   
                a=false;   
           }   
       }   
    }   
    return a;   
}   

//-----------------------------------------------------------------------------------------------------------
function recebeResultado_area()
{   
   if (!tXHR)
   {   
      return false;   
   }   
   else {   
      if (tXHR.readyState == 4) {               
         if (tXHR.status == 200) {   
            document.getElementById("idarea").innerHTML = tXHR.responseText;   
			limpaConteudos();
         }   
         else {   
            alert('Erro! "'+ tXHR.statusText +'" (erro '+ tXHR.status +')');   
         }   
      }       
  }   
}   

//-----------------------------------------------------------------------------------------------------------
function atualiza_area()
{   
    var ptipo = document.inclusao.tipo.options[document.inclusao.tipo.selectedIndex].value;   
    var pgrupo = document.inclusao.grupo.options[document.inclusao.grupo.selectedIndex].value;   
	var randomico = Math.floor(Math.random() * 1000000);
	if (pgrupo != -1)
	{
		tXHR=XMLHTTPRequest();   
       	if (tXHR) {   
           document.inclusao.area.length = 0;   
           document.inclusao.area.options[0] = new Option("Aguarde....","");   
           document.inclusao.ano.length = 0;   
           document.inclusao.ano.options[0] = new Option("--","");   
           tXHR.open("GET", "/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_combo_areas.jsp?randomico="+randomico+"&grupo="+pgrupo+"&tipo="+ptipo, true);
		   tXHR.setRequestHeader("Content-Type","application/x-www-form-urlencode;charset=iso-8859-1");
           tXHR.onreadystatechange=recebeResultado_area;
           tXHR.send(null);   
       	}
	}
}   

//-----------------------------------------------------------------------------------------------------------
function recebeResultado_ano()
{   
    if (!tXHR) {   
       return false;   
    }   
    else {   
       if (tXHR.readyState == 4) {               
          if (tXHR.status == 200) {   
             document.getElementById("idano").innerHTML = tXHR.responseText;   
 			 limpaConteudos();
          }   
          else {   
             alert('Erro! "'+ tXHR.statusText +'" (erro '+ tXHR.status +')');   
          }   
       }       
    }   
}   

//-----------------------------------------------------------------------------------------------------------
function atualiza_ano()
{   
    var ptipo = document.inclusao.tipo.options[document.inclusao.tipo.selectedIndex].value;   
    var pgrupo = document.inclusao.grupo.options[document.inclusao.grupo.selectedIndex].value;   
    var parea = document.inclusao.area.options[document.inclusao.area.selectedIndex].value;
	var randomico = Math.floor(Math.random() * 1000000);
	if (pgrupo != -1)
	{
		tXHR=XMLHTTPRequest();   
       	if (tXHR) {   
           	document.inclusao.ano.length = 0;   
           	document.inclusao.ano.options[0] = new Option("Aguarde....","");   
           	tXHR.open("GET", "/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_combo_ano_referencia.jsp?randomico="+randomico+"&grupo="+pgrupo+"&tipo="+ptipo+"&area="+parea, true);       
			tXHR.setRequestHeader("Content-Type","application/x-www-form-urlencode;charset=iso-8859-1");
           	tXHR.onreadystatechange=recebeResultado_ano;
           	tXHR.send(null);   
       	}
	}
}   		

//-----------------------------------------------------------------------------------------------------------
function recebeResultado_unidade()
{   
    if (!tXHR) {   
       return false;   
    }   
    else {   
       if (tXHR.readyState == 4) {               
          if (tXHR.status == 200) {   
             document.getElementById("idUnidade").innerHTML = tXHR.responseText;   
 			 limpaConteudos();
          }   
          else {   
             alert('Erro! "'+ tXHR.statusText +'" (erro '+ tXHR.status +')');   
          }   
       }       
    }   
}   

//-----------------------------------------------------------------------------------------------------------
function atualiza_unidade()
{   
    var ptipo = document.inclusao.tipo.options[document.inclusao.tipo.selectedIndex].value;   
	var randomico = Math.floor(Math.random() * 1000000);
	if (ptipo != 0)
	{
		tXHR=XMLHTTPRequest();   
        if (tXHR) {   
           document.inclusao.grupo.length = 0;   
           document.inclusao.grupo.options[0] = new Option("Aguarde....","");   
           document.inclusao.area.length = 0;   
           document.inclusao.area.options[0] = new Option("--","");   
           document.inclusao.ano.length = 0;   
           document.inclusao.ano.options[0] = new Option("--","");   
           tXHR.open("GET", "/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_combo_unidades.jsp?randomico="+randomico+"&tipo="+ptipo, true);       
		   tXHR.setRequestHeader("Content-Type","application/x-www-form-urlencode;charset=iso-8859-1");
           tXHR.onreadystatechange=recebeResultado_unidade;
           tXHR.send(null);   
         }
	}
}   

//-----------------------------------------------------------------------------------------------------------
function limpaConteudos()
{
    document.getElementById("divconteudo2").innerHTML="";
}

//-----------------------------------------------------------------------------------------------------------
function carregaConteudos()
{
		if ((document.inclusao.area.disabled) || (document.inclusao.grupo.disabled))// || (document.inclusao.area.disabled))
		{
			alert("É preciso escolher uma unidade e área.");
		}
		else
		{
			document.getElementById("divconteudo2").innerHTML="<center><br><img src='/gecoi.3.0/img/loading.gif'/>";
            var pprincipal = document.inclusao.principal.value;   
            var ptipo = document.inclusao.tipo.options[document.inclusao.tipo.selectedIndex].value;   
            var pgrupo = document.inclusao.grupo.options[document.inclusao.grupo.selectedIndex].value;
            var parea = document.inclusao.area.options[document.inclusao.area.selectedIndex].value;   
	        var pano = document.inclusao.ano.options[document.inclusao.ano.selectedIndex].value;
			if (pano == "")
			   pano = "0";

            var continua = true;
            var pchave = document.inclusao.chave.value;
			if (ptipo != "-2")
			{
			   if ((pgrupo == "-1") || (parea == "0"))
			   {
				   if (pchave == "")
				   {
					   continua = false;
					   alert("Ao selecionar a opção Todas no campo Unidades ou no campo Área, faz-se necessário escolher uma opção em Filtrar pelo Campo e escrever uma palavra chave para minimizar as buscas.");
				   }
			   }
			   if (pano == "-10") // valor de Não há arquivos
			   {
				   continua = false;
				   alert("Não há arquivos com esses parâmetros!");
			   }
			   if (continua)
			   {
			      	var randomico = Math.floor(Math.random() * 1000000);
			      	var parametros = "?randomico="+randomico+"&tipo="+ptipo+"&grupo="+pgrupo+"&area="+parea+"&principal="+pprincipal+"&chave="+pchave+"&ano="+pano;
                  	pag        = "/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_arquivos_referencia.jsp";
                  	goAjax(pag + parametros, "POST", "false","divconteudo2");
			   }
			}
			else
			{
				alert("É necessário escolher o tipo de conteúdo.");
			}
		}
}

function listar_referencia(f) {
	
	var msg = "";
	if (document.inclusao.tipo.value == "0") {
		msg = msg + "Escolha Tipo de conteudo para prosseguir.\n";
	}
	if (document.inclusao.grupo.value == "-5") {
		msg = msg + "Escolha uma unidade para prosseguir.\n";
	}
	if (document.inclusao.area.value == "0") {
		msg = msg + "Escolha uma area para prosseguir.\n";
	}
	
	if (msg.replace(/^\s*|\s*$/g, "") == "") 
		   {
			document.getElementById("divconteudo2").innerHTML = "<img src='/gecoi.3.0/img/loading.gif'/>";
			$.post("/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_arquivos_referencia.jsp", {
				pprincipal : document.inclusao.principal.value,
				ptipo : document.inclusao.tipo.value,
				pgrupo : document.inclusao.grupo.value,
				parea : document.inclusao.area.value,
				pano : document.inclusao.ano.value,
				pchave : document.inclusao.chave.value
			}, function(resposta) {
				$("#divconteudo2").html(resposta);
				zera_contador();
			});
	} else
		alert("Ocorreram os seguintes erros:\n\n" + msg);
}
		

//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
/*
//uso para atualizar a pagina manutencao
function goAjax2(url, metodo, modo, id)
{
	ajax2 = createXMLHTTP();
	ajax2.open(metodo, url, modo);
	ajax2.setRequestHeader("Cache-Control","no-cache");
	ajax2.setRequestHeader("Pragma","no-cache");
	ajax2.setRequestHeader("Expires","-1");

  ajax2.onreadystatechange = function() {
         if(ajax2.readyState == 4)
		   {
            top.document.getElementById(id).innerHTML = ajax2.responseText;
		   }
  }   
  ajax2.send(null);
}
*/
/*
//-----------------------------------------------------------------------------------------------------------
//uso para atualizar a pagina manutencao
function atualizaCombos2()
{
   rand = Math.random();
   pag = "/gecoi.3.0/apps/gecoi_arquivos/manutencao_carrega_combo_ano.jsp";
   valor = document.inclusao.principal.value;

   if (document.inclusao.ano.disabled) 
      //goAjax2(pag + "?id=" + valor + "&randomico=" + rand + "&grupo=0&tipo=0&area=0&ano=0", 'GET', 'false',"anoconsulta");
   else
      goAjax2(pag + "?id=" + valor + "&randomico=" + rand + "&grupo=0&tipo=0&area=0&ano="+document.inclusao.ano.value, 'GET', 'false',"anoconsulta");
}
*/
/*
//-----------------------------------------------------------------------------------------------------------
function recebeResultado_conteudo()
{   
   if (!tXHR) {   
      return false;   
   }   
   else {   
      if (tXHR.readyState == 4) {               	  
         if (tXHR.status == 200) {   
            document.getElementById("divbotao"+document.inclusao.acao.value).innerHTML = tXHR.responseText;   
			atualizaCombos2();
 	   	    if (document.inclusao.ano.selectedIndex < 1)
		       top.carregaRegistros("0");
		    else
               top.carregaRegistros(document.inclusao.ano.options[document.inclusao.ano.selectedIndex].value);
         }   
         else {   
             alert('Erro! "'+ tXHR.statusText +'" (erro '+ tXHR.status +')');   						
         }   
      }       
   }   
}   

//-----------------------------------------------------------------------------------------------------------
function insere_referencia(parquivoprincipal, parquivoreferencia, pgrupo) 
{   
     var randomico = Math.floor(Math.random() * 1000000);
	 tXHR=XMLHTTPRequest();   
     if (tXHR) {   
	    document.inclusao.acao.value = parquivoreferencia;
//		document.getElementById("btn"+parquivoreferencia).value = "Inserindo";
       	tXHR.open("POST", "/gecoi.3.0/apps/gecoi_arquivos/processa_inclusao_referencia.jsp?randomico="+randomico+"&idarquivoprincipal="+parquivoprincipal+"&idarquivoreferencia="+parquivoreferencia+"&grupo="+pgrupo, true);       
		tXHR.setRequestHeader("Content-Type","application/x-www-form-urlencode;charset=iso-8859-1");
       	tXHR.onreadystatechange=recebeResultado_conteudo;
       	tXHR.send(null);   
     }
}
*/
function insere_referencia2(parquivoprincipal, parquivoreferencia, pgrupo) 
{   
	
	document.inclusao.acao.value = parquivoreferencia;
	$.post("/gecoi.3.0/apps/gecoi_arquivos/processa_inclusao_referencia.jsp?idarquivoprincipal="+parquivoprincipal+"&idarquivoreferencia="+parquivoreferencia+"&grupo="+pgrupo, {}, 
			function(resposta){
        		document.getElementById("divbotao"+document.inclusao.acao.value).innerHTML = resposta;   
	});
}


