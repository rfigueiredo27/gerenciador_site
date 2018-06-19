package br.jus.trerj.funcoes;

public class ConexaoPool {
   public String RetornaUsuario(int identificador){
	   String usuario="";
	   switch(identificador){
	   	case 1:usuario="gecoi_consulta";
	   		  
	   		   break;
	   }
	   return usuario;
   }
   public String RetornaSenha(int identificador){
	   String senha = ""; 
	   switch(identificador){
	   	case 1:senha="snch";
	   		   break;
	   }
	   return senha;
   }
}
