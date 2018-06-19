package br.jus.trerj.modelo;

public class ExtratoLicitacao {
	private String tipo;
	private String numPregao;
	private String descricao;
	private String numProcesso;
	private String idConteudo;
	private String dataAbertura;
	private String dataCriacao;
	private String dataImpressao;
	private String dataPublicacao;
	private String situacao;
	
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
	public String getDataAbertura() {
		return dataAbertura;
	}
	public void setDataAbertura(String dataAbertura) {
		this.dataAbertura = dataAbertura;
	}
	public String getDataCriacao() {
		return dataCriacao;
	}
	public void setDataCriacao(String dataCriacao) {
		this.dataCriacao = dataCriacao;
	}
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	public String getNumProcesso() {
		return numProcesso;
	}
	public void setNumProcesso(String numProcesso) {
		this.numProcesso = numProcesso;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getNumPregao() {
		return numPregao;
	}
	public void setNumPregao(String numPregao) {
		this.numPregao = numPregao;
	}
	public String getDataImpressao() {
		return dataImpressao;
	}
	public void setDataImpressao(String dataImpressao) {
		this.dataImpressao = dataImpressao;
	}
	public String getDataPublicacao() {
		return dataPublicacao;
	}
	public void setDataPublicacao(String dataPublicacao) {
		this.dataPublicacao = dataPublicacao;
	}
	
}
