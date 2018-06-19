package br.jus.trerj.funcoes;

public class LimpaParametro {
	
	public String limpa (String parametro)
	{
		String vlimpa = "";
		if (parametro != null)
		{
			vlimpa = parametro.replace("<", "");
			vlimpa = vlimpa.replace(">", "");
			vlimpa = vlimpa.replace("'","");
			vlimpa = vlimpa.replace("\"","");
			vlimpa = vlimpa.replace("\\","");
			vlimpa = vlimpa.replace("*","");
			vlimpa = vlimpa.replace("&","");
			vlimpa = vlimpa.replace("%","");
			vlimpa = vlimpa.replace("$","");
			vlimpa = vlimpa.replace("#","");
			//vlimpa = vlimpa.replace(/\@/,"");
			vlimpa = vlimpa.replace("(","");
			vlimpa = vlimpa.replace(")","");
			vlimpa = vlimpa.replace("^","");
			vlimpa = vlimpa.replace("~","");
			vlimpa = vlimpa.replace("?","");
			vlimpa = vlimpa.replace("!","");
			vlimpa = vlimpa.replace("+","");
			vlimpa = vlimpa.replace("/script","");
			vlimpa = vlimpa.replace("script","");
			vlimpa = vlimpa.replace("/input","");
			vlimpa = vlimpa.replace("input","");
		}
		return vlimpa;
	}

}
