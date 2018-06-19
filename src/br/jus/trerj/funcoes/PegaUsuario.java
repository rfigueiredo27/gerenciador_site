package br.jus.trerj.funcoes;

import com.sun.security.auth.module.NTSystem;


public class PegaUsuario {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		   System.out.println(System.getProperty("user.name"));  
		   System.out.println(System.getProperty("os.name"));  
		   System.out.println(System.getProperty("programfiles"));  

		   NTSystem infoSystem = new NTSystem();
		   System.out.println(infoSystem.getName()); // username logado no windows/domínio
			System.out.println(infoSystem.getDomain()); // nome do dominio do sistema windows
	}

}
