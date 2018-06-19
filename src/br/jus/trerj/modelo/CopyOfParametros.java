package br.jus.trerj.modelo;


public class CopyOfParametros {
	private String banco;
	private String localXML;
	private String usuario;
	private String senha;
	private String caminho;
	
	
	public String getBanco() {
		return banco;
	}
	public void setBanco(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.banco = "jdbc:oracle:thin:@rjdbs03.tre-rj.gov.br:1521:ursa";
		else
			this.banco = "jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm";
	}
	public String getLocalXML() {
		return localXML;
	}
	public void setLocalXML(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.localXML = "composicao.xml";
		else
			//this.localXML = "D:\\Apache Software Foundation\\Tomcat 7.0\\webapps\\gecoi.3.0\\gecoi_arquivos\\composicao.xml";
			this.localXML = "/opt/tomcat/webapps/site/gecoi_arquivos/institucional/composicao.xml";
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.senha = "5851385";
		else
			this.senha = "internauta";
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.usuario = "gecoi";
		else
			this.usuario = "internauta";
	}
	public String getCaminho() {
		return caminho;
	}
	public void setCaminho(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			//this.caminho = "/composicao/";
			this.caminho = "/gecoi.3.0/apps/composicao_corte/";
		else
			this.caminho = "/gecoi.3.0/apps/composicao_corte/";
	}
	
	public CopyOfParametros() {
		String ambiente = "desenvolvimento";
		//String ambiente = "producao";
		setBanco(ambiente);
		setLocalXML(ambiente);
		setLocalXML(ambiente);
		setUsuario(ambiente);
		setSenha(ambiente);
		setCaminho(ambiente);
	}

}
