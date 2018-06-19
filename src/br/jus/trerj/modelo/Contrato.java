package br.jus.trerj.modelo;

public class Contrato {
	private String descricaoContrato;
	private String nContrato;
	private String nProcesso;
	private int idArquivo;
	private int idConteudo;
	private int ordem_principal;
	private int ordem;
	private String tipo;
	private String dataPublicacao;
	private String dataVigenciaInicial;
	private String dataVigenciaFinal;
	private int ano;
	private int idArea;
	private String observacao;
	private int idReferencia;
	private String nPregao;

	public int getOrdem() {
		return ordem;
	}
	public void setOrdem(int ordem) {
		this.ordem = ordem;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getDataPublicacao() {
		return dataPublicacao;
	}
	public void setDataPublicacao(String dataPublicacao) {
		this.dataPublicacao = dataPublicacao;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	
	/*private String descricao;
	private Blob arquivo;
	private String nome;
	private Blob arquivo_reduzido;
	private Calendar data_inclusao;
	private String nome_arquivo_reduzido;
	private int ordem;
	*/
	public String getDescricaoContrato() {
		return descricaoContrato;
	}
	public void setDescricaoContrato(String descricaoContrato) {
		this.descricaoContrato = descricaoContrato;
	}
	public String getnContrato() {
		return nContrato;
	}
	public void setnContrato(String nContrato) {
		this.nContrato = nContrato;
	}
	public String getnProcesso() {
		return nProcesso;
	}
	public void setnProcesso(String nProcesso) {
		this.nProcesso = nProcesso;
	}
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
	/*
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public Blob getArquivo() {
		return arquivo;
	}
	public void setArquivo(Blob arquivo) {
		this.arquivo = arquivo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Blob getArquivo_reduzido() {
		return arquivo_reduzido;
	}
	public void setArquivo_reduzido(Blob arquivo_reduzido) {
		this.arquivo_reduzido = arquivo_reduzido;
	}
	public Calendar getData_inclusao() {
		return data_inclusao;
	}
	public void setData_inclusao(Calendar data_inclusao) {
		this.data_inclusao = data_inclusao;
	}
	public String getNome_arquivo_reduzido() {
		return nome_arquivo_reduzido;
	}
	public void setNome_arquivo_reduzido(String nome_arquivo_reduzido) {
		this.nome_arquivo_reduzido = nome_arquivo_reduzido;
	}
	public int getOrdem() {
		return ordem;
	}
	public void setOrdem(int ordem) {
		this.ordem = ordem;
	}
*/
	public int getOrdem_principal() {
		return ordem_principal;
	}
	public void setOrdem_principal(int ordem_principal) {
		this.ordem_principal = ordem_principal;
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
	public int getIdArea() {
		return idArea;
	}
	public void setIdArea(int idArea) {
		this.idArea = idArea;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	public int getIdReferencia() {
		return idReferencia;
	}
	public void setIdReferencia(int idReferencia) {
		this.idReferencia = idReferencia;
	}
	public String getnPregao() {
		return nPregao;
	}
	public void setnPregao(String nPregao) {
		this.nPregao = nPregao;
	}
}
