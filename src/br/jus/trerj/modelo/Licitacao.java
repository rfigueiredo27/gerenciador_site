package br.jus.trerj.modelo;

public class Licitacao {
	private String idArquivo;
	private String idConteudo;
	private String tipo;
	private String numPregao;
	private String descricao;
	private String numProcesso;
	private String dataAbertura;
	private String dataFechamento;
	private String dataPublicacao;
	private String situacao;
	
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
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public String getNumProcesso() {
		return numProcesso;
	}
	public void setNumProcesso(String numProcesso) {
		this.numProcesso = numProcesso;
	}
	public String getDataAbertura() {
		return dataAbertura;
	}
	public void setDataAbertura(String dataAbertura) {
		this.dataAbertura = dataAbertura;
	}
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	public String getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(String idConteudo) {
		this.idConteudo = idConteudo;
	}
	public String getIdArquivo() {
		return idArquivo;
	}
	public void setIdArquivo(String idArquivo) {
		this.idArquivo = idArquivo;
	}
	public String getDataFechamento() {
		return dataFechamento;
	}
	public void setDataFechamento(String dataFechamento) {
		this.dataFechamento = dataFechamento;
	}
	public String getDataPublicacao() {
		return dataPublicacao;
	}
	public void setDataPublicacao(String dataPublicacao) {
		this.dataPublicacao = dataPublicacao;
	}

}
