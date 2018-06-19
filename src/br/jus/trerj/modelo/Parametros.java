package br.jus.trerj.modelo;


public class Parametros
{
  private String banco;
  
  private String localXML;
  
  private String usuario;
  
  private String senha;
  private String vambiente;
  private int vidAreaCurriculo;
  private int vidAreaComposicao;
  private int vidAreaDestaque;
  private int vidAreaContrato;
  private int vidAreaPopupMetas;
  private int vidAreaRegistroPrecosSecomp;
  private int vidAreaRegistroPrecosSeccon;
  private int vidAreaLicitacaoConvite;
  private int vidAreaLicitacaoPregaoEletronico;
  private int vidAreaLicitacaoPregaoEletronicoRegistroPreco;
  private int vidAreaLicitacaoPregaoEletronicoSRP;
  private int vidAreaLicitacaoPregaoPresencial;
  private int vidAreaLicitacaoPregaoPresencialRegistroPreco;
  private int vidAreaLicitacaoTomadaPreco;
  private int vidAreaLicitacaoConcorrenciaPublica;
  private int vidAreaControleAta;
  private int vidAreaControleEntrega;
  private int vidAreaContratoAdesaoRP;
  private int vidAreaContratoContratacaoDireta;
  private int vidCampoValidadeInicial;
  private int vidCampoValidadeFinal;
  private int vidAreaRodizioInternet;
  private int vidAreaRodizioIntranet;
  private int vidDataPublicacao;
  private int vidAreaNoticiaIntranet;
  private int vidAreaNoticiaInternet;
  private int vidAreaAviso;
  private int vidAreaNoticiaIntranetDestaque;
  private int vidAreaNoticiaInternetDestaque;
  private int vidEstudosPreliminares;
  
  public Parametros()
  {
    Parametros("Produção");
  }
  





  private void Parametros(String string) {}
  





  public Parametros(String ambiente)
  {
    String portal = "rjweb08";
    setBanco(ambiente);
    setLocalXML(ambiente, portal);
    setUsuario(ambiente);
    setSenha(ambiente);
    setVidAreaCurriculo(ambiente);
    setVidAreaComposicao(ambiente);
    setVidAreaDestaque(ambiente);
    setVidAreaContrato(ambiente);
    setVidAreaPopupMetas(ambiente);
    setVidAreaRegistroPrecosSecomp(ambiente);
    setVidAreaRegistroPrecosSeccon(ambiente);
    setVidAreaLicitacaoConvite(ambiente);
    setVidAreaLicitacaoPregaoEletronico(ambiente);
    setVidAreaLicitacaoPregaoEletronicoRegistroPreco(ambiente);
    setVidAreaLicitacaoPregaoEletronicoSRP(ambiente);
    setVidAreaLicitacaoPregaoPresencial(ambiente);
    setVidAreaLicitacaoPregaoPresencialRegistroPreco(ambiente);
    setVidAreaLicitacaoTomadaPreco(ambiente);
    setVidAreaLicitacaoConcorrenciaPublica(ambiente);
    setVidAreaControleAta(ambiente);
    setVidAreaControleEntrega(ambiente);
    setVidCampoValidadeInicial(ambiente);
    setVidCampoValidadeFinal(ambiente);
    setVidAreaContratoAdesaoRP(ambiente);
    setVidAreaContratoContratacaoDireta(ambiente);
    setVidAreaRodizioInternet(ambiente);
    setVidAreaRodizioIntranet(ambiente);
    setVidDataPublicacao(ambiente);
    setVidAreaNoticiaIntranet(ambiente);
    setVidAreaNoticiaInternet(ambiente);
    setVidAreaAviso(ambiente);
    setVidAreaNoticiaIntranetDestaque(ambiente);
    setVidAreaNoticiaInternetDestaque(ambiente);
    setVidEstudosPreliminares(ambiente);
  }
  

  public String getBanco() { return banco; }
  
  public void setBanco(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      banco = "jdbc:oracle:thin:@rjdbs03.tre-rj.gov.br:1521:ursa";
    } else
      banco = "jdbc:oracle:thin:@rj1.tre-rj.gov.br:1521:adm";
  }
  
  public String getLocalXML() { return localXML; }
  
  public void setLocalXML(String ambiente, String portal)
  {
    if (ambiente.equals("desenvolvimento")) {
      localXML = "composicao.xml";

    }
    else
    {
    	//rjweb12
    	//localXML = "/opt/tomcat/webapps/site_responsivo/gecoi_arquivos/composicao.xml";
    	//rjweb18
    	localXML = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\gecoi.3.0\\gecoi_arquivos\\composicao.xml";
    }
  }
  




  public String getSenha() { return senha; }
  
  public void setSenha(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      senha = "5851385";
    } else
      senha = "internauta";
  }
  
  public String getUsuario() { return usuario; }
  
  public void setUsuario(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      usuario = "gecoi";
    } else
      usuario = "internauta";
  }
  
  public int getVidAreaCurriculo() {
    return vidAreaCurriculo;
  }
  
  public void setVidAreaCurriculo(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaCurriculo = 1622;
    } else
      vidAreaCurriculo = 60;
  }
  
  public int getVidAreaComposicao() { return vidAreaComposicao; }
  
  public void setVidAreaComposicao(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaComposicao = 1622;
    } else
      vidAreaComposicao = 73;
  }
  
  public int getVidAreaDestaque() { return vidAreaDestaque; }
  
  public void setVidAreaDestaque(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaDestaque = 389;
    } else
      vidAreaDestaque = 2536;
  }
  
  public int getVidAreaContrato() { return vidAreaContrato; }
  
  public void setVidAreaContrato(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaContrato = 61;
    } else
      vidAreaContrato = 61;
  }
  
  public int getVidAreaPopupMetas() { return vidAreaPopupMetas; }
  
  public void setVidAreaPopupMetas(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaPopupMetas = 390;
    } else {
      vidAreaPopupMetas = 2485;
    }
  }
  

  public int getVidAreaRegistroPrecosSecomp() { return vidAreaRegistroPrecosSecomp; }
  
  public void setVidAreaRegistroPrecosSecomp(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaRegistroPrecosSecomp = 1421;
    } else
      vidAreaRegistroPrecosSecomp = 1421;
  }
  
  public int getVidAreaRegistroPrecosSeccon() { return vidAreaRegistroPrecosSeccon; }
  
  public void setVidAreaRegistroPrecosSeccon(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaRegistroPrecosSeccon = 391;
    } else
      vidAreaRegistroPrecosSeccon = 2109;
  }
  
  public int getVidAreaLicitacaoConvite() { return vidAreaLicitacaoConvite; }
  
  public void setVidAreaLicitacaoConvite(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoConvite = 881;
    } else
      vidAreaLicitacaoConvite = 881;
  }
  
  public int getVidAreaLicitacaoPregaoEletronico() { return vidAreaLicitacaoPregaoEletronico; }
  
  public void setVidAreaLicitacaoPregaoEletronico(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoPregaoEletronico = 882;
    } else
      vidAreaLicitacaoPregaoEletronico = 882;
  }
  
  public int getVidAreaLicitacaoPregaoEletronicoRegistroPreco() { return vidAreaLicitacaoPregaoEletronicoRegistroPreco; }
  
  public void setVidAreaLicitacaoPregaoEletronicoRegistroPreco(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoPregaoEletronicoRegistroPreco = 883;
    } else
      vidAreaLicitacaoPregaoEletronicoRegistroPreco = 883;
  }
  
  public int getVidAreaLicitacaoPregaoEletronicoSRP() { return vidAreaLicitacaoPregaoEletronicoSRP; }
  
  public void setVidAreaLicitacaoPregaoEletronicoSRP(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoPregaoEletronicoSRP = 884;
    } else
      vidAreaLicitacaoPregaoEletronicoSRP = 884;
  }
  
  public int getVidAreaLicitacaoPregaoPresencial() { return vidAreaLicitacaoPregaoPresencial; }
  
  public void setVidAreaLicitacaoPregaoPresencial(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoPregaoPresencial = 885;
    } else
      vidAreaLicitacaoPregaoPresencial = 885;
  }
  
  public int getVidAreaLicitacaoPregaoPresencialRegistroPreco() { return vidAreaLicitacaoPregaoPresencialRegistroPreco; }
  
  public void setVidAreaLicitacaoPregaoPresencialRegistroPreco(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoPregaoPresencialRegistroPreco = 886;
    } else
      vidAreaLicitacaoPregaoPresencialRegistroPreco = 886;
  }
  
  public int getVidAreaLicitacaoTomadaPreco() { return vidAreaLicitacaoTomadaPreco; }
  
  public void setVidAreaLicitacaoTomadaPreco(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoTomadaPreco = 887;
    } else
      vidAreaLicitacaoTomadaPreco = 887;
  }
  
  public int getVidAreaLicitacaoConcorrenciaPublica() { return vidAreaLicitacaoConcorrenciaPublica; }
  
  public void setVidAreaLicitacaoConcorrenciaPublica(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaLicitacaoConcorrenciaPublica = 1021;
    } else
      vidAreaLicitacaoConcorrenciaPublica = 1021;
  }
  
  public int getVidAreaControleAta() {
    return vidAreaControleAta;
  }
  
  public void setVidAreaControleAta(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaControleAta = 410;
    } else
      vidAreaControleAta = 0;
  }
  
  public int getVidAreaControleEntrega() {
    return vidAreaControleEntrega;
  }
  
  public void setVidAreaControleEntrega(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaControleEntrega = 409;
    } else
      vidAreaControleEntrega = 0;
  }
  
  public int getVidCampoValidadeInicial() {
    return vidCampoValidadeInicial;
  }
  
  public void setVidCampoValidadeInicial(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidCampoValidadeInicial = 1;
    } else
      vidCampoValidadeInicial = 1;
  }
  
  public int getVidCampoValidadeFinal() {
    return vidCampoValidadeFinal;
  }
  
  public void setVidCampoValidadeFinal(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidCampoValidadeFinal = 2;
    } else
      vidCampoValidadeFinal = 2;
  }
  
  public int getVidAreaContratoAdesaoRP() {
    return vidAreaContratoAdesaoRP;
  }
  
  public void setVidAreaContratoAdesaoRP(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaContratoAdesaoRP = 430;
    } else
      vidAreaContratoAdesaoRP = 2555;
  }
  
  public int getVidAreaContratoContratacaoDireta() {
    return vidAreaContratoContratacaoDireta;
  }
  
  public void setVidAreaContratoContratacaoDireta(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaContratoContratacaoDireta = 429;
    } else
      vidAreaContratoContratacaoDireta = 2554;
  }
  
  public int getVidAreaRodizioInternet() {
    return vidAreaRodizioInternet;
  }
  
  public void setVidAreaRodizioInternet(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaRodizioInternet = 432;
    } else
      vidAreaRodizioInternet = 2558;
  }
  
  public int getVidAreaRodizioIntranet() {
    return vidAreaRodizioIntranet;
  }
  
  public void setVidAreaRodizioIntranet(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidAreaRodizioIntranet = 433;
    } else
      vidAreaRodizioIntranet = 2559;
  }
  
  public String getVambiente() {
    return vambiente;
  }
  
  public void setVambiente(String vambiente) {
    this.vambiente = vambiente;
  }
  
  public int getVidDataPublicacao() {
    return vidDataPublicacao;
  }
  
  public void setVidDataPublicacao(String ambiente) {
    if (ambiente.equals("desenvolvimento")) {
      vidDataPublicacao = 3;
    } else
      vidDataPublicacao = 3;
  }
  
  public int getVidAreaNoticiaIntranet() {
    return vidAreaNoticiaIntranet;
  }
  
  public void setVidAreaNoticiaIntranet(String ambiente) {
    vidAreaNoticiaIntranet = 22;
  }
  
  public int getVidAreaNoticiaInternet() {
    return vidAreaNoticiaInternet;
  }
  
  public void setVidAreaNoticiaInternet(String ambiente) {
    vidAreaNoticiaInternet = 42;
  }
  
  public int getVidAreaAviso() {
    return vidAreaAviso;
  }
  
  public void setVidAreaAviso(String ambiente) {
    vidAreaAviso = vidAreaAviso;
  }
  
  public int getVidAreaNoticiaIntranetDestaque() {
    return vidAreaNoticiaIntranetDestaque;
  }
  
  public void setVidAreaNoticiaIntranetDestaque(String ambiente) {
    vidAreaNoticiaIntranetDestaque = 2461;
  }
  
  public int getVidAreaNoticiaInternetDestaque() {
    return vidAreaNoticiaInternetDestaque;
  }
  
  public void setVidAreaNoticiaInternetDestaque(String ambiente) {
    vidAreaNoticiaInternetDestaque = 2460;
  }
  
  public int getVidEstudosPreliminares() {
    return vidEstudosPreliminares;
  }
  
  public void setVidEstudosPreliminares(String ambiente) {
    vidEstudosPreliminares = 2633;
  }
}
