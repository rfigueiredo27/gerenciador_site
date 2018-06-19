package br.jus.trerj.modelo;

public class Anexo {
	private String descricao;
	private String descricaoRedu;
	private String descricaoConteudo;
	private int ordem;
	private int idArquivo;
	private int idConteudo;
	private int total;

	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public int getOrdem() {
		return ordem;
	}
	public void setOrdem(int ordem) {
		this.ordem = ordem;
	}
	public int getIdArquivo() {
		return idArquivo;
	}
	public void setIdArquivo(int idArquivo) {
		this.idArquivo = idArquivo;
	}
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}

	public int getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(int idConteudo) {
		this.idConteudo = idConteudo;
	}
	
	public String getDescricaoRedu() {
		return descricaoRedu;
	}
	public void setDescricaoRedu(String descricaoRedu) {
		this.descricaoRedu = descricaoRedu;
	}
	public String getDescricaoConteudo() {
		return descricaoConteudo;
	}
	public void setDescricaoConteudo(String descricaoConteudo) {
		this.descricaoConteudo = descricaoConteudo;
	}

	

}
