package br.jus.trerj.controle.destaque;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.ExcluirArquivoConteudo;
import br.jus.trerj.modelo.Parametros;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ExcluiDestaque
{
  public ExcluiDestaque() {}
  
  public String excluir(String vidConteudo, String usuario, String senha, int vpublicadoAtual)
  {
    Connection conexao = null;
    Parametros parametros = new Parametros(new br.jus.trerj.funcoes.ListaAmbiente().mostraAmbiente(usuario, senha));
    
    String retorno = "";
    try {
      conexao = new ConnectionFactory().getConnection(parametros.getBanco(), usuario, senha);
      
      try
      {
        conexao.setAutoCommit(false);
        String vsql = "update gecoi.arquivo set publicado = publicado - 1 where publicado >= ? and id_conteudo IN (SELECT id_conteudo FROM gecoi.conteudo_area WHERE id_area = ?)";
        PreparedStatement pstm = conexao.prepareStatement(vsql);
        pstm.setInt(1, vpublicadoAtual);
        pstm.setInt(2, parametros.getVidAreaDestaque());
        pstm.executeUpdate();
        
        ExcluirArquivoConteudo excluir = new ExcluirArquivoConteudo();
        retorno = excluir.excluir(vidConteudo, usuario, senha);
        














        System.out.println(retorno);
        if (retorno.indexOf("Erro") == -1)
        {
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
        catch (SQLException localSQLException) {}
      }
      







      return retorno;
    }
    catch (ClassNotFoundException localClassNotFoundException) {}
	return retorno;
  }
}