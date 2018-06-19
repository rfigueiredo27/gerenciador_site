<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>
<%@include file="/apps/global/conexao_pool_gecoi_v2.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script>
function atualizaTela()
{
	parent.tb_remove();
	carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + document.fanexo.idConteudo.value , "divbusca");
}


function excluirAnexo(vidArquivo, vidConteudo, vDescricao)
{
	if (confirm("Deseja realmente excluir o anexo ?") == true)
		$.post("/gecoi.3.0/apps/global/processa_exclusao_anexo.jsp", {idArquivo : vidArquivo}, 
				function(){carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + vidConteudo ,"divbusca");});

}

function trocarOrdem(vidArquivo, vidConteudo, vacao, vanterior, vproximo)
{
		$.post("/gecoi.3.0/apps/gecoi_arquivos/troca_ordem.jsp", 
		{
			atual : vidArquivo,
			acao : vacao,
			anterior : vanterior,
			proximo : vproximo
		
		}, 
		function(){carregaPag("/gecoi.3.0/apps/gecoi_arquivos/alterar_anexo.jsp?id=" + vidConteudo ,"divbusca");});

}
</script>
<%
//Se algum dado foi enviado
Enumeration e = request.getParameterNames();
if(e.hasMoreElements())
{
	String vidConteudo = request.getParameter("id");
	String vcor = "#ECECEC"; // zebra a tabela
	//criação de variáveis
	String vsql         = "";  //instrução da consulta ao banco
	String vnome        = "";  //nome do arquivo
	int    vultimoanexo = 0;   //número de ordem do anexo
%>

<div id="altera_anexo" style="width: 95%;">
	<fieldset style="width: 95%;">
		<legend>Lista de Anexos</legend>
					
					<% 
					request.setCharacterEncoding("UTF-8");
					
					//cabeçalho da tabela
					  out.println("<table class='table' align='center' style='width:95%;'><thead><tr>");
					  out.println("<th scope='col'>ORDEM</th>");
					  out.println("<th scope='col'>ID ARQUIVO</th>");	  
					  out.println("<th scope='col'>T&Iacute;TULO</th>");
					  out.println("<th scope='col'>DATA/HORA</th>");
					  out.println("<th scope='col' colspan='6'>A&Ccedil;&Otilde;ES</th></tr></thead><tbody>");
					
					//ordem dos anexos
					  int vordem = 0;
					  Vector adescricao = new Vector();
					  Vector ainclusao  = new Vector();
					  Vector aidarquivo = new Vector();
					  Vector apasta     = new Vector();
					  Vector anome      = new Vector();
					
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
					
						vsql = "SELECT a.id_arquivo, a.id_conteudo, a.descricao, to_char(a.data_inclusao, 'dd/mm/yyyy - HH24:mi:ss') as data_inclusao, a.ordem, a.nome, " +
					             "ar.pasta_fisica from gecoi.arquivo a, gecoi.conteudo_area ca, gecoi.area ar " +
					             "where a.id_conteudo=ca.id_conteudo and ar.id_area=ca.id_area AND a.ordem>0 AND ca.id_conteudo = ? " +
								 "order by a.ordem";

					    PreparedStatement pstm = con.prepareStatement(vsql);
					    pstm.setString(1,vidConteudo);
					      
						resultSet = pstm.executeQuery();
						while(resultSet.next())
					      {
							adescricao.add(resultSet.getString("descricao"));		  
							ainclusao.add(resultSet.getString("data_inclusao"));		  
							aidarquivo.add(resultSet.getString("id_arquivo"));		  
							apasta.add(resultSet.getString("pasta_fisica"));		  
							anome.add(resultSet.getString("nome"));		 
							vultimoanexo = Integer.parseInt(resultSet.getString("ordem"));
							vordem++;
					      }

						//aqui começa a criação da tabela
						for (int i=1; i <= vordem; i++)
	  {
         out.println("<tr><td align='center'>" + i + "</td>");
         out.println("<td align='center'>" + aidarquivo.get(i-1) + "</td>");	 
         out.println("<td>" + adescricao.get(i-1) + "</td>");
         out.println("<td align='center'>" + ainclusao.get(i-1) + "</td>");
         out.println("<td align='center'>&nbsp;<a href='/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=" + aidarquivo.get(i-1) + "&idConteudo=" + vidConteudo + "' target=\"_blank\" title='Visualizar Arquivo'><img src='/gecoi.3.0/img/consulta.png' alt='Visualizar Arquivo' ></a>&nbsp;</td>");

		 out.println("<td align='center'>&nbsp;<a href=\"#\" onclick=\"carregaPag('/gecoi.3.0/apps/gecoi_arquivos/altera_arquivo_anexo.jsp?idConteudo=" + vidConteudo +"&idArquivo=" + aidarquivo.get(i-1) + "&descricao=" + adescricao.get(i-1) + "','divbusca');\" title='Substituir arquivo anexo'><img src='/gecoi.3.0/img/reverter.png' alt='Substituir arquivo anexo'></a>&nbsp;</td>");	
         

         out.println("<td align='center'>&nbsp;<a href='#' onclick=\"excluirAnexo('" + aidarquivo.get(i-1) +"','" + vidConteudo + "','" + adescricao.get(i-1) + "');\" title='Excluir'><img src='/gecoi.3.0/img/excluir_cinza.png' alt='Excluir' border='0'></a>&nbsp;</td>");
		 
		 out.println("<td align='center'>&nbsp;<a href=\"#\" carregaPag('/gecoi.3.0/apps/gecoi_arquivos/alterar_descricao_anexo.jsp?idConteudo=" + vidConteudo + "&idArquivo=" + aidarquivo.get(i-1) + "&descricao=" + adescricao.get(i-1) + "')  title='Alterar dados do Anexo'><img src='/gecoi.3.0/img/editar_cinza.png' alt='Alterar Dados do Anexo' border='0'></a>&nbsp;</td>");		 

		 if (i==1)
		 {
            //se houver mais de um anexo			
			if (vordem>1)
			{
          	   out.println("<td>&nbsp;</td>");
			   out.println("<td align='center'>&nbsp;<a href='troca_ordem.jsp?acao=baixo&anterior=0&atual=" + aidarquivo.get(i-1) + "&proximo=" + aidarquivo.get(i) + "&iatual=" + i + "' target='rodape' title='Mover para baixo'><img src='/gecoi/arquivos/img/baixo.gif' alt='Mover para baixo' border='0'></a>&nbsp;</td>");
			}
			else
		    {
          	   out.println("<td colspan='2' align='center'>-</td>");
			}
		 }
		 else
		 {
			
		 	if (i == vordem)
			{
		 		out.println("<td align='center'>&nbsp;<a href='troca_ordem.jsp?acao=cima&anterior=" + aidarquivo.get(i-2) + "&atual=" + aidarquivo.get(i-1) + "&proximo=0&iatual=" + i + "' target='rodape' title='Mover para cima'><img src='/gecoi/arquivos/img/alto.gif' alt='Mover para cima' border='0'></a>&nbsp;</td>");
          		out.println("<td>&nbsp;</td>");
			}
		 	else
		 	{
				out.println("<td align='center'>&nbsp;<a href='troca_ordem.jsp?acao=cima&anterior=" + aidarquivo.get(i-2) + "&atual=" + aidarquivo.get(i-1) + "&proximo=" + aidarquivo.get(i) + "&iatual=" + i + "' target='rodape' title='Mover para cima'><img src='/gecoi/arquivos/img/alto.gif' alt='Mover para cima' border='0'></a>&nbsp;</td>");
		 		out.println("<td align='center'>&nbsp;<a href='troca_ordem.jsp?acao=baixo&anterior=" + aidarquivo.get(i-2) + "&atual=" + aidarquivo.get(i-1) + "&proximo=" + aidarquivo.get(i) + "&iatual=" + i + "' target='rodape' title='Mover para baixo'><img enabled='false' src='/gecoi/arquivos/img/baixo.gif' alt='Mover para baixo' border='0'></a>&nbsp;</td>");
			}
         out.println("</tr>");		  
		 }
	  }
	 
      out.println("</tbody></table></div>");	  
	  out.println("<br/><div align='right' id='inclusao'><a href='manutencao_upload_anexo.jsp?idconteudo=" + vidConteudo + "'><u>(+) Adicionar anexo(s)</u></a>&nbsp;&nbsp;</div>");
      resultSet.close(); 
 	  con.close();

   }
   catch (Exception ex)
   {
      out.println(ex.getMessage());
   }
}
%>

<iframe name="rodape" frameborder="0" allowtransparency="yes" height="0"
	width="0"></iframe>
