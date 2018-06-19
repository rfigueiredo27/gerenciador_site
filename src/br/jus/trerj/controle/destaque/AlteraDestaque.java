package br.jus.trerj.controle.destaque;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AlteraDestaque
{
  public AlteraDestaque() {}
  
  public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vobservacao, String vdataIni, String vdataFim, int vpublicadoAtual, int vpublicadoNovo, String usuario, String senha)
  {
    Connection conexao = null;
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
    int vidArea = parametros.getVidAreaDestaque();
    
    String retorno = "";
    try {
      conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
      
      try
      {
        conexao.setAutoCommit(false);
        String vsql = "{call gecoi.g_alterar_conteudo(?, ?, ?, ?, ?) ";
        

        CallableStatement cs = conexao.prepareCall(vsql);
        

        cs.registerOutParameter(1, 12);
        

        cs.setString(2, vidConteudo);
        cs.setString(3, vdescricao);
        cs.setString(4, vobservacao);
        cs.setString(5, usuario);
        
        cs.execute();
        
        retorno = cs.getString(1);
        System.out.println(retorno);
        if (retorno.indexOf("Erro") == -1)
        {
          if (vdescricao != null)
          {
            try
            {
              vsql = "update gecoi.arquivo set descricao = ? where id_arquivo = ?";
              PreparedStatement pstm = conexao.prepareStatement(vsql);
              pstm.setString(1, vdescricao);
              pstm.setInt(2, Integer.parseInt(vidArquivo));
              pstm.executeUpdate();
            }
            catch (Exception e)
            {
              e.printStackTrace();
              try {
                conexao.rollback();
              }
              catch (SQLException localSQLException) {}
            }
          }
          


          if (vdataIni != null)
          {
            try
            {
              vsql = "update gecoi.conteudo_area set data_inicio_exib = to_date(?,'dd/mm/yyyy') where id_conteudo = ?";
              PreparedStatement pstm = conexao.prepareStatement(vsql);
              pstm.setString(1, vdataIni);
              pstm.setInt(2, Integer.parseInt(vidConteudo));
              pstm.executeUpdate();
            }
            catch (Exception e)
            {
              e.printStackTrace();
              try {
                conexao.rollback();
              }
              catch (SQLException localSQLException1) {}
            }
          }
          


          if (vdataFim != null)
          {
            try
            {
              vsql = "update gecoi.conteudo_area set data_fim_exib = to_date(?,'dd/mm/yyyy') where id_conteudo = ?";
              PreparedStatement pstm = conexao.prepareStatement(vsql);
              pstm.setString(1, vdataFim);
              pstm.setInt(2, Integer.parseInt(vidConteudo));
              pstm.executeUpdate();
            }
            catch (Exception e)
            {
              e.printStackTrace();
              try {
                conexao.rollback();
              }
              catch (SQLException localSQLException2) {}
            }
          }
          


          if (vpublicadoAtual != vpublicadoNovo)
          {
            try
            {

              if ((vpublicadoAtual == 0) && (vpublicadoNovo != 0))
              {
                vsql = "UPDATE gecoi.arquivo SET publicado = (SELECT Max(a.publicado)+1 FROM gecoi.arquivo a, gecoi.conteudo_Area ca WHERE a.id_conteudo = ca.id_conteudo AND ca.id_area = ?) WHERE id_conteudo = ?";
                

                PreparedStatement pstm = conexao.prepareStatement(vsql);
                pstm.setInt(1, vidArea);
                pstm.setInt(2, Integer.parseInt(vidConteudo));
                pstm.executeUpdate();
                System.out.println(vidConteudo);
                System.out.println(vidArea);

              }
              else
              {
                if (vpublicadoNovo == 0) {
                  vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";

                }
                else if (vpublicadoAtual > vpublicadoNovo) {
                  vsql = "update gecoi.arquivo set publicado = publicado + 1 where publicado <= ? and publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
                }
                else
                  vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and publicado <= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
                PreparedStatement pstm = conexao.prepareStatement(vsql);
                pstm.setInt(1, vpublicadoAtual);
                if (vpublicadoNovo == 0) {
                  pstm.setInt(2, vidArea);
                }
                else {
                  pstm.setInt(2, vpublicadoNovo);
                  pstm.setInt(3, vidArea);
                }
                pstm.executeUpdate();
                
                vsql = "update gecoi.arquivo set publicado = ? where id_conteudo = ?";
                pstm = conexao.prepareStatement(vsql);
                pstm.setInt(1, vpublicadoNovo);
                pstm.setInt(2, Integer.parseInt(vidConteudo));
                pstm.executeUpdate();
              }
            }
            catch (Exception e)
            {
              e.printStackTrace();
              try {
                conexao.rollback();
              }
              catch (SQLException localSQLException3) {}
            }
          }
          


          conexao.commit();
        }
        else
        {
          conexao.rollback();
          System.out.println(retorno);
        }
        conexao.close();
        
        MostraTv mostraTv = new MostraTv();
        mostraTv.mostra(usuario, senha);




      }
      catch (Exception e)
      {



        e.printStackTrace();
        try {
          conexao.rollback();
        }
        catch (SQLException localSQLException4) {}
      }
      







      return retorno;
    } catch (ClassNotFoundException localClassNotFoundException) {}
	return retorno;
  }
  
  public String alterar(String vidConteudo, String vidArquivo, String vordem, String vacao, String usuario, String senha) {
    Connection conexao = null;
    Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(usuario, senha));
    

    String retorno = "";
    
    try
    {
      conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
      

      try
      {
        conexao.setAutoCommit(false);
        String vsql = "";
        PreparedStatement pstm = null;
        if (vacao.equals("sobe"))
        {
          vsql = "update gecoi.arquivo set ordem = ordem + 1 where id_conteudo = ? and ordem = ?";
          pstm = conexao.prepareStatement(vsql);
          pstm.setInt(1, Integer.parseInt(vidConteudo));
          pstm.setInt(2, Integer.parseInt(vordem) - 1);
          pstm.executeUpdate();
          
          vsql = "update gecoi.arquivo set ordem = ordem - 1 where id_arquivo = ?";
          pstm = conexao.prepareStatement(vsql);
          pstm.setInt(1, Integer.parseInt(vidArquivo));
          pstm.executeUpdate();
        }
        else
        {
          vsql = "update gecoi.arquivo set ordem = ordem - 1 where id_conteudo = ? and ordem = ?";
          pstm = conexao.prepareStatement(vsql);
          pstm.setInt(1, Integer.parseInt(vidConteudo));
          pstm.setInt(2, Integer.parseInt(vordem) + 1);
          pstm.executeUpdate();
          
          vsql = "update gecoi.arquivo set ordem = ordem + 1 where id_arquivo = ?";
          pstm = conexao.prepareStatement(vsql);
          pstm.setInt(1, Integer.parseInt(vidArquivo));
          pstm.executeUpdate();
        }
        

        conexao.commit();
        conexao.close();
        
        MostraTv mostraTv = new MostraTv();
        mostraTv.mostra(usuario, senha);




      }
      catch (Exception e)
      {



        e.printStackTrace();
        try {
          conexao.rollback();
        }
        catch (SQLException localSQLException) {}
      }
      







      return retorno;
    }
    catch (ClassNotFoundException localClassNotFoundException) {}
	return retorno;
  }
}