package br.jus.trerj.controle.estudosPreliminares;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Anexo;
import br.jus.trerj.modelo.Area;
import br.jus.trerj.modelo.EstudosPreliminares;
import br.jus.trerj.modelo.Parametros;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ListaEstudo
{
  public ListaEstudo() {}
  
  public int getnumAta(String vusuario, String vsenha)
  {
    int numAta = 0;
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    try
    {
      Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
      String vsql = "SELECT LPad(gecoi.sq_ata_registro_preco.NEXTVAL, 3, '0') AS proximo, To_Char(SYSDATE, 'yyyy') AS ano FROM dual";
      PreparedStatement pstm = conexao.prepareStatement(vsql);
      ResultSet rs = pstm.executeQuery();
      rs.next();
      numAta = rs.getInt("proximo");
      rs.close();
      
      conexao.close();
    }
    catch (Exception localException) {}
    


    return numAta;
  }
  
  public List<Integer> getAnos(String vusuario, String vsenha) throws ClassNotFoundException, SQLException
  {
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    int vidArea = parametros.getVidEstudosPreliminares();
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    List<Integer> ano = new java.util.ArrayList();
    String vsql = "SELECT DISTINCT To_Char(data_inicio_exib, 'yyyy') AS ano from gecoi.conteudo_area WHERE id_area = ? order by To_Char(data_inicio_exib, 'yyyy') DESC";
    


    PreparedStatement pstm = conexao.prepareStatement(vsql);
    
    pstm.setInt(1, vidArea);
    
    ResultSet rs = pstm.executeQuery();
    
    while (rs.next())
    {
      ano.add(Integer.valueOf(rs.getInt("ano")));
    }
    rs.close();
    conexao.close();
    return ano;
  }
  
  public List<Area> getAreas(String vusuario, String vsenha) throws ClassNotFoundException, SQLException
  {
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    List<Area> areas = new java.util.ArrayList();
    String vsql = "SELECT a.id_area, a.descricao FROM gecoi.area a, gecoi.grupo_area g, gecoi.permissao p WHERE descricao like 'Registro de Preços - %' AND a.id_area = g.id_Area AND g.id_grupo = p.id_grupo AND Upper(p.logon_vusuario) = Upper(?)order by a.descricao";
    




    PreparedStatement pstm = conexao.prepareStatement(vsql);
    pstm.setString(1, vusuario);
    ResultSet rs = pstm.executeQuery();
    
    while (rs.next())
    {
      Area area = new Area();
      area.setDescricao(rs.getString("descricao"));
      area.setIdArea(rs.getInt("id_area"));
      areas.add(area);
    }
    rs.close();
    conexao.close();
    return areas;
  }
  
  private String pegaNumProcesso(String descricao)
  {
    String[] numProcesso = descricao.trim().split(" ");
    
    String[] numProcessoAux = numProcesso[(numProcesso.length - 1)].split("/");
    return numProcessoAux[0] + "/" + numProcessoAux[1].substring(numProcessoAux[1].length() - 2);
  }
  
  public List<Anexo> getListaAnexos(String vidConteudo, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
  {
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    List<Anexo> Anexo = new java.util.ArrayList();
    
    String vsql = "SELECT ca.id_area,ordem,a.id_arquivo, a.data_inclusao, ca.data_inicio_exib, a.id_conteudo, a.descricao, co.descricao as descricaoConteudo from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = co.id_conteudo AND co.id_conteudo = ? order by a.ordem ";
    

    PreparedStatement pstm = conexao.prepareStatement(vsql);
    pstm.setInt(1, Integer.parseInt(vidConteudo));
    
    ResultSet rs = pstm.executeQuery();
    
    while (rs.next())
    {
      Anexo anexo = new Anexo();
      anexo.setIdArquivo(rs.getInt("id_arquivo"));
      anexo.setIdConteudo(rs.getInt("id_conteudo"));
      anexo.setDescricao(rs.getString("descricao"));
      anexo.setDescricaoConteudo(rs.getString("descricaoConteudo"));
      anexo.setOrdem(rs.getInt("ordem"));
      Anexo.add(anexo);
    }
    rs.close();
    conexao.close();
    return Anexo;
  }
  
  public List<EstudosPreliminares> getListaReferencia(String vidArquivo, String vusuario, String vsenha)
    throws ClassNotFoundException, SQLException
  {
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    int vidArea = parametros.getVidEstudosPreliminares();
    int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
    int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    List<EstudosPreliminares> Registro = new java.util.ArrayList();
    
    String vsql = "SELECT ca.id_area,ordem,a.id_arquivo, a.data_inclusao, to_char(ca.data_inicio_exib, 'dd/mm/yyyy') as data_inicio_exib, to_char(ca.data_fim_exib, 'dd/mm/yyyy') as data_fim_exib, a.id_conteudo, a.descricao, ca.id_area, Decode(co.observacao, ' a ', '-', co.observacao) as observacao ,(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t \t  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional \t\t  AND t.id_tipo_campo_adicional = ?) AS VigenciaInicial, \t\t(SELECT valor FROM gecoi.campo_adicional ad, gecoi.tipo_campo_adicional t \t\t  WHERE a.id_arquivo = ad.id_arquivo AND ad.id_tipo_campo_adicional = t.id_tipo_campo_adicional \t\t  AND t.id_tipo_campo_adicional = ?) AS VigenciaFinal from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.conteudo co, gecoi.referencia r WHERE a.id_conteudo = ca.id_conteudo AND ca.id_conteudo = co.id_conteudo AND a.id_arquivo = r.id_arquivo_referencia AND r.id_arquivo_principal = ? and ca.id_area = ?order by a.id_arquivo ";
    











    PreparedStatement pstm = conexao.prepareStatement(vsql);
    pstm.setInt(1, vidValidadeInicial);
    pstm.setInt(2, vidValidadeFinal);
    pstm.setInt(3, Integer.parseInt(vidArquivo));
    pstm.setInt(4, vidArea);
    
    ResultSet rs = pstm.executeQuery();
    
    while (rs.next())
    {
      EstudosPreliminares registro = new EstudosPreliminares();
      registro.setIdArquivo(rs.getInt("id_arquivo"));
      registro.setIdConteudo(rs.getInt("id_conteudo"));
      String[] aDescricao = rs.getString("descricao").split("-");
      



      registro.setDescricao(aDescricao[1].trim());
      



      if (aDescricao.length > 2)
        registro.setDescricao(aDescricao[2].trim());
      registro.setDataPublicacao(rs.getString("data_inicio_exib"));
      

      registro.setIdArea(rs.getInt("id_area"));
      Registro.add(registro);
    }
    rs.close();
    conexao.close();
    return Registro;
  }
  

  private String pegaEdital(int vidArquivo, Connection conexao)
  {
    String retorno = "";
    try
    {
      String vsql = "SELECT a.id_arquivo, a.descricao FROM gecoi.referencia r, gecoi.arquivo a WHERE r.id_arquivo_referencia = ? AND r.id_arquivo_principal = a.id_arquivo";
      

      PreparedStatement pstm = conexao.prepareStatement(vsql);
      pstm.setInt(1, vidArquivo);
      
      ResultSet rs = pstm.executeQuery();
      if (rs.next())
      {
        retorno = rs.getString("descricao");
      }
    }
    catch (Exception e)
    {
      System.out.println(e.getMessage());
    }
    return retorno;
  }
  
  public List<EstudosPreliminares> getListaAta(String vtexto, String vano, String vusuario, String vsenha) throws ClassNotFoundException, SQLException
  {
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
    int vidArea = parametros.getVidEstudosPreliminares();
    Connection conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);
    List<EstudosPreliminares> Registro = new java.util.ArrayList();
    
    String vsql = "SELECT a.id_conteudo, a.id_arquivo, a.descricao, a.ordem, ca.data_inicio_exib FROM gecoi.arquivo a, gecoi.conteudo_area ca WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area IN (?) and to_char(ca.data_inicio_exib, 'yyyy') = ?  ";
    


    if (!vtexto.equals(""))
      vsql = vsql + "and upper(a.descricao) like upper(?) ";
    vsql = vsql + "ORDER BY a.descricao, a.id_conteudo, a.ordem ";
    
    PreparedStatement pstm = conexao.prepareStatement(vsql);
    pstm.setInt(1, vidArea);
    pstm.setString(2, vano);
    if (!vtexto.equals("")) {
      pstm.setString(3, "%" + vtexto + "%");
    }
    ResultSet rs = pstm.executeQuery();
    String vedital = "";
    int vidReferencia = 0;
    while (rs.next())
    {
      EstudosPreliminares registro = new EstudosPreliminares();
      registro.setIdArquivo(rs.getInt("id_arquivo"));
      registro.setIdConteudo(rs.getInt("id_conteudo"));
      

      if (rs.getString("descricao").indexOf("-") > 0)
      {
        String[] aDescricao = rs.getString("descricao").split("-");
        registro.setDescricao(aDescricao[0].substring(29).trim());
      }
      




      vsql = "SELECT a.id_arquivo, a.descricao FROM gecoi.referencia r, gecoi.arquivo a WHERE r.id_arquivo_referencia = ? AND r.id_arquivo_principal = a.id_arquivo";
      

      pstm = conexao.prepareStatement(vsql);
      pstm.setInt(1, rs.getInt("id_arquivo"));
      
      vedital = "";
      vidReferencia = 0;
      ResultSet rs2 = pstm.executeQuery();
      if (rs2.next())
      {
        vedital = rs2.getString("descricao");
        vidReferencia = rs2.getInt("id_arquivo");
      }
      



      registro.setDescricao("Sem Referência");
      registro.setIdReferencia(0);
      if (!vedital.equals(""))
      {
        String[] aEdital = vedital.split("-");
        

        registro.setDescricao(aEdital[3]);
        registro.setIdReferencia(vidReferencia);
      }
      



      Registro.add(registro);
    }
    rs.close();
    conexao.close();
    return Registro;
  }
}
