package br.jus.trerj.modelo;

public class RegistroPrecos {
	private int idConteudo;
	private int idArquivo;
	private String Descricao;
	private String DescricaoCompleta;
	private String numProcesso;
	private String numPregao;
	private String dataPublicacao;
	private String dataVigenciaInicial;
	private String dataVigenciaFinal;
	private int idArea;
	private String numAta;
	private int idReferencia;
	private String Fornecedor; 
	
	public int getIdConteudo() {
		return idConteudo;
	}
	public void setIdConteudo(int idConteudo) {
		this.idConteudo = idConteudo;
	}
	public int getIdArquivo() {
		return idArquivo;
	}
	public void setIdArquivo(int idArquivo) {
		this.idArquivo = idArquivo;
	}
	public String getDescricao() {
		return Descricao;
	}
	public void setDescricao(String descricao) {
		Descricao = descricao;
	}
	public int getIdArea() {
		return idArea;
	}
	public void setIdArea(int idArea) {
		this.idArea = idArea;
	}
	public String getNumProcesso() {
		return numProcesso;
	}
	public void setNumProcesso(String numProcesso) {
		this.numProcesso = numProcesso;
	}
	public String getDescricaoCompleta() {
		return DescricaoCompleta;
	}
	public void setDescricaoCompleta(String descricaoCompleta) {
		DescricaoCompleta = descricaoCompleta;
	}
	public String getDataPublicacao() {
		return dataPublicacao;
	}
	public void setDataPublicacao(String dataPublicacao) {
		this.dataPublicacao = dataPublicacao;
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
	public String getNumAta() {
		return numAta;
	}
	public void setNumAta(String numAta) {
		this.numAta = numAta;
	}
	public String getNumPregao() {
		return numPregao;
	}
	public void setNumPregao(String numPregao) {
		this.numPregao = numPregao;
	}
	public int getIdReferencia() {
		return idReferencia;
	}
	public void setIdReferencia(int idReferencia) {
		this.idReferencia = idReferencia;
	}
	public String getFornecedor() {
		return Fornecedor;
	}
	public void setFornecedor(String fornecedor) {
		Fornecedor = fornecedor;
	}

}
