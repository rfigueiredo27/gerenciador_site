package br.jus.trerj.modelo;

public class StatusLicitacao {
	
	private String Tipo;
	private String numProcesso;
	private String numPregao;
	private String descricao;
	private String idConteudo;
	private int dataFim;
	private int hoje;
	private String status;
	private String mostraEncerrar;
	private String mostraSuspender;
	private String mostraReabrir;
	private String mostraRevogar;
	
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public String getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(String idConteudo) {
		this.idConteudo = idConteudo;
	}
	public int getDataFim() {
		return dataFim;
	}
	public void setDataFim(int dataFim) {
		this.dataFim = dataFim;
	}
	public int getHoje() {
		return hoje;
	}
	public void setHoje(int hoje) {
		this.hoje = hoje;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMostraEncerrar() {
		return mostraEncerrar;
	}
	public void setMostraEncerrar(String mostraEncerrar) {
		this.mostraEncerrar = mostraEncerrar;
	}
	public String getMostraSuspender() {
		return mostraSuspender;
	}
	public void setMostraSuspender(String mostraSuspender) {
		this.mostraSuspender = mostraSuspender;
	}
	public String getMostraReabrir() {
		return mostraReabrir;
	}
	public void setMostraReabrir(String mostraReabrir) {
		this.mostraReabrir = mostraReabrir;
	}
	public String getTipo() {
		return Tipo;
	}
	public void setTipo(String tipo) {
		Tipo = tipo;
	}
	public String getNumProcesso() {
		return numProcesso;
	}
	public void setNumProcesso(String numProcesso) {
		this.numProcesso = numProcesso;
	}
	public String getNumPregao() {
		return numPregao;
	}
	public void setNumPregao(String numPregao) {
		this.numPregao = numPregao;
	}
	public String getMostraRevogar() {
		return mostraRevogar;
	}
	public void setMostraRevogar(String mostraRevogar) {
		this.mostraRevogar = mostraRevogar;
	}

}
