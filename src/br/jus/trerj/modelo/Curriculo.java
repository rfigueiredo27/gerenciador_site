package br.jus.trerj.modelo;

import java.sql.Clob;

public class Curriculo {
	private String idConteudo;
	private String idArquivo;
	private String descricao;
	private Clob arquivo;
	private String nomeArquivoTexto;
	private String nomeArquivoImg;
	private String idArquivoTexto;
	private String idArquivoImg;
	private int publicado;
	
	public Clob getArquivo() {
		return arquivo;
	}
	public void setArquivo(Clob arquivo) {
		this.arquivo = arquivo;
	}
	
	public String getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(String idConteudo) {
		this.idConteudo = idConteudo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}	

	public String getIdArquivo() {
		return idArquivo;
	}
	public void setIdArquivo(String idArquivo) {
		this.idArquivo = idArquivo;
	}
	public String getIdArquivoTexto() {
		return idArquivoTexto;
	}
	public void setIdArquivoTexto(String idArquivoTexto) {
		this.idArquivoTexto = idArquivoTexto;
	}
	public String getIdArquivoImg() {
		return idArquivoImg;
	}
	public void setIdArquivoImg(String idArquivoImg) {
		this.idArquivoImg = idArquivoImg;
	}
	public String getNomeArquivoTexto() {
		return nomeArquivoTexto;
	}
	public void setNomeArquivoTexto(String nomeArquivoTexto) {
		this.nomeArquivoTexto = nomeArquivoTexto;
	}
	public String getNomeArquivoImg() {
		return nomeArquivoImg;
	}
	public void setNomeArquivoImg(String nomeArquivoImg) {
		this.nomeArquivoImg = nomeArquivoImg;
	}
	public int getPublicado() {
		return publicado;
	}
	public void setPublicado(int publicado) {
		this.publicado = publicado;
	}	

}
