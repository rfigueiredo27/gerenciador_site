package br.jus.trerj.modelo;

import java.sql.Blob;
import java.util.Calendar;

public class App {
	private int id_app;
	private String nome;
	private String nomeArquivo;
	private String descricao;
	private Blob icone;
	private String caminho;
	private Blob manual_usuario;
	private Calendar dt_inclusao;
	private String icone_extensao;
	
	public int getId_app() {
		return id_app;
	}
	public void setId_app(int id_app) {
		this.id_app = id_app;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public Blob getIcone() {
		return icone;
	}
	public void setIcone(Blob icone) {
		this.icone = icone;
	}
	public Blob getManual_usuario() {
		return manual_usuario;
	}
	public void setManual_usuario(Blob manual_usuario) {
		this.manual_usuario = manual_usuario;
	}
	public String getCaminho() {
		return caminho;
	}
	public void setCaminho(String caminho) {
		this.caminho = caminho;
	}
	public String getIcone_extensao() {
		return icone_extensao;
	}
	public void setIcone_extensao(String icone_extensao) {
		this.icone_extensao = icone_extensao;
	}
	public Calendar getDt_inclusao() {
		return dt_inclusao;
	}
	public void setDt_inclusao(Calendar dt_inclusao) {
		this.dt_inclusao = dt_inclusao;
	}
	public String getNomeArquivo() {
		return nomeArquivo;
	}
	public void setNomeArquivo(String nomeArquivo) {
		this.nomeArquivo = nomeArquivo;
	}
}
