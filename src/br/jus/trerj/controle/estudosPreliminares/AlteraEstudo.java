package br.jus.trerj.controle.estudosPreliminares;

import br.jus.trerj.conexao.ConnectionFactory;
import br.jus.trerj.funcoes.IncluirGecoiArquivo;
import br.jus.trerj.funcoes.ListaAmbiente;
import br.jus.trerj.modelo.Parametros;
import java.io.PrintStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class AlteraEstudo
{
	public AlteraEstudo() {}

	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vidArea, String vdataAbertura, String vvigenciaInicial, String vvigenciaFinal, String vusuario, String vsenha)
	{
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		int vidValidadeInicial = parametros.getVidCampoValidadeInicial();
		int vidValidadeFinal = parametros.getVidCampoValidadeFinal();
		Connection conexao = null;
		String retorno = "";
		int qtd = 0;
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

			try
			{
				IncluirGecoiArquivo incluir = new IncluirGecoiArquivo();
				conexao.setAutoCommit(false);
				String vsql = "{call gecoi.g_processar_alteracao_arquivo(?, ?, ?, ?, null, ?, null, ?, null, ?, ?, null, null)";





				CallableStatement cs = conexao.prepareCall(vsql);


				cs.registerOutParameter(1, 12);


				cs.setString(2, vdescricao);
				cs.setString(3, vusuario);
				cs.setInt(4, Integer.parseInt(vidConteudo));


				cs.setInt(5, Integer.parseInt(vidArea));
				cs.setString(6, vdataAbertura);


				cs.setInt(7, Integer.parseInt(vidArquivo));
				cs.setString(8, vdescricao);


				cs.execute();

				retorno = cs.getString(1);



				if (retorno.indexOf("Erro") < 0) {
					conexao.commit();
				} else
					conexao.rollback();
				conexao.close();

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

	public String alterar(String vidConteudo, String vidArquivo, String vdescricao, String vusuario, String vsenha) {
		Parametros parametros = new Parametros(new ListaAmbiente().mostraAmbiente(vusuario, vsenha));
		Connection conexao = null;
		String retorno = "";
		try {
			conexao = new ConnectionFactory().getConnection(parametros.getBanco(), vusuario, vsenha);

			try
			{
				conexao.setAutoCommit(false);
				String vsql = "{call gecoi.g_alterar_conteudo(?, ?, null, null, ?) ";


				CallableStatement cs = conexao.prepareCall(vsql);


				cs.registerOutParameter(1, 12);


				cs.setInt(2, Integer.parseInt(vidConteudo));
				cs.setString(3, vusuario);

				cs.execute();

				retorno = cs.getString(1);

				System.out.println(retorno);
				if (retorno.indexOf("Erro:") == -1)
				{
					vsql = "{call gecoi.g_alterar_arquivo(?, ?, ?, null, null) ";

					cs = conexao.prepareCall(vsql);


					cs.registerOutParameter(1, 12);


					cs.setInt(2, Integer.parseInt(vidArquivo));
					cs.setString(3, vdescricao);

					cs.execute();

					retorno = cs.getString(1);
					if (retorno.indexOf("Erro:") == -1)
					{
						conexao.commit();
					}
					else
					{
						conexao.rollback();
					}
				}
				else
				{
					conexao.rollback();
				}
				conexao.close();

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
