package br.jus.trerj.modelo;


public class ParametrosTeste {
	private String banco;
	private String localXML;
	private String usuario;
	private String senha;
	private int vidAreaCurriculo;
	private int vidAreaComposicao;
	private int vidAreaDestaque;
	private int vidAreaContrato;
	private int vidAreaPopupMetas;
	private int vidAreaRegistroPrecosSecomp;
	private int vidAreaRegistroPrecosSeccon;
	private int vidAreaLicitacaoConvite;
	private int vidAreaLicitacaoPregaoEletronico;
	private int vidAreaLicitacaoPregaoEletronicoRegistroPreco;
	private int vidAreaLicitacaoPregaoEletronicoSRP;
	private int vidAreaLicitacaoPregaoPresencial;
	private int vidAreaLicitacaoPregaoPresencialRegistroPreco;
	private int vidAreaLicitacaoTomadaPreco;
	
	
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
	public void setLocalXML(String ambiente, String portal) {
		if (ambiente.equals("desenvolvimento"))
			this.localXML = "composicao.xml";
		else
			//this.localXML = "D:\\Apache Software Foundation\\Tomcat 7.0\\webapps\\gecoi.3.0\\gecoi_arquivos\\composicao.xml";
			if (portal.equals("site"))
				this.localXML = "/opt/tomcat/webapps/site/gecoi_arquivos/institucional/composicaoteste.xml";
			else
				this.localXML = "D:/Apache Software Foundation/Tomcat 7.0/webapps/gecoi.3.0/gecoi_arquivos/institucional/composicao.xml";
			//this.localXML = "X:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/gecoi.3.0/institucional/composicao.xml";
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
	
	public int getVidAreaCurriculo() {
		return vidAreaCurriculo;
	}
	
	public void setVidAreaCurriculo(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaCurriculo = 1622;
		else
			this.vidAreaCurriculo = 60;
	}
	public int getVidAreaComposicao() {
		return vidAreaComposicao;
	}
	public void setVidAreaComposicao(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaComposicao = 1622;
		else
			this.vidAreaComposicao = 73;
	}
	public int getVidAreaDestaque() {
		return vidAreaDestaque;
	}
	public void setVidAreaDestaque(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaDestaque = 389;
		else
			this.vidAreaDestaque = 2536;
	}
	public int getVidAreaContrato() {
		return vidAreaContrato;
	}
	public void setVidAreaContrato(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaContrato = 61;
		else
			this.vidAreaContrato = 61;
	}
	public int getVidAreaPopupMetas() {
		return vidAreaPopupMetas;
	}
	public void setVidAreaPopupMetas(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaPopupMetas = 390;
		else
			this.vidAreaPopupMetas = 2485;
	}

	
	public ParametrosTeste() {
		//String ambiente = "desenvolvimento";
		String ambiente = "producao";
		String portal = "site";
		//String portal = "rjweb08";
		setBanco(ambiente);
		setLocalXML(ambiente, portal);
		setUsuario(ambiente);
		setSenha(ambiente);
		setVidAreaCurriculo(ambiente);
		setVidAreaComposicao(ambiente);
		setVidAreaDestaque(ambiente);
		setVidAreaContrato(ambiente);
		setVidAreaPopupMetas(ambiente);
		setVidAreaRegistroPrecosSecomp(ambiente);
		setVidAreaRegistroPrecosSeccon(ambiente);
		setVidAreaLicitacaoConvite(ambiente);
		setVidAreaLicitacaoPregaoEletronico(ambiente);
		setVidAreaLicitacaoPregaoEletronicoRegistroPreco(ambiente);
		setVidAreaLicitacaoPregaoEletronicoSRP(ambiente);
		setVidAreaLicitacaoPregaoPresencial(ambiente);
		setVidAreaLicitacaoPregaoPresencialRegistroPreco(ambiente);
		setVidAreaLicitacaoTomadaPreco(ambiente);
	}
	public int getVidAreaRegistroPrecosSecomp() {
		return vidAreaRegistroPrecosSecomp;
	}
	public void setVidAreaRegistroPrecosSecomp(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaRegistroPrecosSecomp = 1421;
		else
			this.vidAreaRegistroPrecosSecomp = 1421;
	}
	public int getVidAreaRegistroPrecosSeccon() {
		return vidAreaRegistroPrecosSeccon;
	}
	public void setVidAreaRegistroPrecosSeccon(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaRegistroPrecosSeccon = 391;
		else
			this.vidAreaRegistroPrecosSeccon = 2109;
	}
	public int getVidAreaLicitacaoConvite() {
		return vidAreaLicitacaoConvite;
	}
	public void setVidAreaLicitacaoConvite(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoConvite = 881;
		else
			this.vidAreaLicitacaoConvite = 881;
	}
	public int getVidAreaLicitacaoPregaoEletronico() {
		return vidAreaLicitacaoPregaoEletronico;
	}
	public void setVidAreaLicitacaoPregaoEletronico(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoPregaoEletronico = 882;
		else
			this.vidAreaLicitacaoPregaoEletronico = 882;
	}
	public int getVidAreaLicitacaoPregaoEletronicoRegistroPreco() {
		return vidAreaLicitacaoPregaoEletronicoRegistroPreco;
	}
	public void setVidAreaLicitacaoPregaoEletronicoRegistroPreco(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoPregaoEletronicoRegistroPreco = 883;
		else
			this.vidAreaLicitacaoPregaoEletronicoRegistroPreco = 883;
	}
	public int getVidAreaLicitacaoPregaoEletronicoSRP() {
		return vidAreaLicitacaoPregaoEletronicoSRP;
	}
	public void setVidAreaLicitacaoPregaoEletronicoSRP(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoPregaoEletronicoSRP = 884;
		else
			this.vidAreaLicitacaoPregaoEletronicoSRP = 884;
	}
	public int getVidAreaLicitacaoPregaoPresencial() {
		return vidAreaLicitacaoPregaoPresencial;
	}
	public void setVidAreaLicitacaoPregaoPresencial(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoPregaoPresencial = 885;
		else
			this.vidAreaLicitacaoPregaoPresencial = 885;
	}
	public int getVidAreaLicitacaoPregaoPresencialRegistroPreco() {
		return vidAreaLicitacaoPregaoPresencialRegistroPreco;
	}
	public void setVidAreaLicitacaoPregaoPresencialRegistroPreco(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoPregaoPresencialRegistroPreco = 886;
		else
			this.vidAreaLicitacaoPregaoPresencialRegistroPreco = 886;
	}
	public int getVidAreaLicitacaoTomadaPreco() {
		return vidAreaLicitacaoTomadaPreco;
	}
	public void setVidAreaLicitacaoTomadaPreco(String ambiente) {
		if (ambiente.equals("desenvolvimento"))
			this.vidAreaLicitacaoTomadaPreco = 887;
		else
			this.vidAreaLicitacaoTomadaPreco = 887;
	}
}
