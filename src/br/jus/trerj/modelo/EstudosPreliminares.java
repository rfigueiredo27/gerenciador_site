package br.jus.trerj.modelo;

public class EstudosPreliminares
{
  private int idConteudo;
  private int idArquivo;
  private String descricao;
  private String dataPublicacao;
  private int idArea;
  private int idReferencia;
  
  public int getIdConteudo() {
    return idConteudo;
  }
  
  public void setIdConteudo(int idConteudo) { this.idConteudo = idConteudo; }
  
  public int getIdArquivo() {
    return idArquivo;
  }
  
  public void setIdArquivo(int idArquivo) { this.idArquivo = idArquivo; }
  
  public String getDescricao() {
    return descricao;
  }
  
  public void setDescricao(String descricao) { this.descricao = descricao; }
  
  public String getDataPublicacao() {
    return dataPublicacao;
  }
  
  public void setDataPublicacao(String dataPublicacao) { this.dataPublicacao = dataPublicacao; }
  
  public int getIdArea() {
    return idArea;
  }
  
  public void setIdArea(int idArea) { this.idArea = idArea; }
  
  public int getIdReferencia() {
    return idReferencia;
  }
  
  public void setIdReferencia(int idReferencia) { this.idReferencia = idReferencia; }
  


  public EstudosPreliminares(int idConteudo, int idArquivo, String descricao, String dataPublicacao, int idArea, int idReferencia)
  {
    this.idConteudo = idConteudo;
    this.idArquivo = idArquivo;
    this.descricao = descricao;
    this.dataPublicacao = dataPublicacao;
    this.idArea = idArea;
    this.idReferencia = idReferencia;
  }
  
  public EstudosPreliminares() {}
}
