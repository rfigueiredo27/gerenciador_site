package br.jus.trerj.modelo;

public class Aditivos {
	private int idArquivo;
	private int idConteudo;
	private String descricao;
	private int ordem;
	private int nTermo;
	private String dataVigenciaInicial;
	private String dataVigenciaFinal;
	private String tipo;
	
	public int getIdArquivo() {
		return idArquivo;
	}
	public void setIdArquivo(int idArquivo) {
		this.idArquivo = idArquivo;
	}
	public int getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(int idConteudo) {
		this.idConteudo = idConteudo;
	}
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
	public String getDataVigenciaInicial() {
		return dataVigenciaInicial;
	}
	public void setDataVigenciaInicial(String dataVigenciaInicial) {
		this.dataVigenciaInicial = dataVigenciaInicial;
	}
	public String getDataVigenciaFinal() {
		return dataVigenciaFinal;
	}
	public void setDataVigenciaFinal(String dataVigenciaFinal) {
		this.dataVigenciaFinal = dataVigenciaFinal;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public int getnTermo() {
		return nTermo;
	}
	public void setnTermo(int nTermo) {
		this.nTermo = nTermo;
	}
	
}
