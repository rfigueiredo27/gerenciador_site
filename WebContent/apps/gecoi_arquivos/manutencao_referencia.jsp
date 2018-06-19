
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.jus.trerj.conexao.ConnectionFactory"%>
<%@page import="br.jus.trerj.funcoes.ListaAmbiente"%>
<%@page import="br.jus.trerj.modelo.Parametros"%>
<%@page language="java" import="java.sql.*,java.util.*"%>

<script src="/gecoi.3.0/apps/gecoi_arquivos/scripts/referencia.js"></script>
<script type="text/javascript" language="javascript" src="/gecoi.3.0/apps/gecoi_arquivos/DataTable/js/referencia_manutencao.js"></script>

<script language="javascript">
function valida_exclusao(idp,idr,ds)
{
	if (confirm("Confirma a exclusão do relacionamento:\n\n - " + ds ))
	{
	   document.exclui.idarquivoprincipal.value = idp;
	   document.exclui.idarquivoreferencia.value = idr;
	   document.exclui.submit();	   
	}
	
}



</script>

<%
//criação de variáveis
String vsql         = "";  //instrução da consulta ao banco
int    vprincipal   = Integer.parseInt(request.getParameter("idprincipal"));
int    vgrupo       = 0;
int vgrupoprincipal = 0;
int    vcruzada     = 0;
int    vtipocruzada = 0;
int    vultimareferencia = 0;
boolean vgrupos_diferentes = false;
String vdescricao = request.getParameter("descricao");
%>

<form name="exclui" action="/gecoi.3.0/apps/gecoi_arquivos/processa_exclusao_referencia.jsp" method="post" target="rodape">
<input type="hidden" name="idarquivoprincipal" />
<input type="hidden" name="idarquivoreferencia" />
<input type="hidden" name="descricao_principal" value="<%=vdescricao %>" />
</form>


<%

//Se algum dado foi enviado
Enumeration e = request.getParameterNames();
if(e.hasMoreElements())
{
   //Recebe os parâmetros do formulário
   vprincipal  = (request.getParameter("idprincipal") == null ? 0 : Integer.parseInt(request.getParameter("idprincipal")));   
   vdescricao  = request.getParameter("descricao");

   //Prepara as variáveis para o acesso ao banco
   Connection con;
   PreparedStatement pstm;
   ResultSet rs;

   try
   {
	 //Configurando a conexão com o banco
	   String vlogin = session.getAttribute("login").toString();
	   String vsenha = session.getAttribute("senha").toString();
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Parametros parametros = new Parametros(
				new ListaAmbiente().mostraAmbiente(vlogin, vsenha));
				con = new ConnectionFactory().getConnection(
				parametros.getBanco(), vlogin, vsenha);
	  
      //pego o grupo do usuario logado
      vsql = "SELECT id_grupo " +
			 "FROM gecoi.permissao " +
			 "WHERE upper(logon_usuario) = Upper(?) ";

      pstm = con.prepareStatement(vsql);
      pstm.setString(1,vlogin);

      rs = pstm.executeQuery();
	  rs.next();
	  vgrupo = rs.getInt("id_grupo");
	  
      //seleciona o grupo do arquivo principal
      vsql = "SELECT g.id_grupo FROM gecoi.arquivo a, gecoi.conteudo_area c, gecoi.grupo_area g " +
	         "WHERE a.id_arquivo = ? AND a.id_conteudo = c.id_conteudo AND c.id_area = g.id_area order by id_grupo desc";

      pstm = con.prepareStatement(vsql);
      pstm.setInt(1,vprincipal);

      rs = pstm.executeQuery();
	  rs.next();
	  vgrupoprincipal = rs.getInt("id_grupo");
	  
      //seleciona os arquivos com os parâmetros informados
      vsql = "SELECT r.id_arquivo_principal, r.id_arquivo_referencia, r.data_inclusao, r.logon_usuario, r.id_grupo, r.id_cruzada, a.descricao " +
			 "FROM gecoi.referencia r, gecoi.arquivo a " +
			 "WHERE r.id_arquivo_principal = ? " +
			 "AND r.id_arquivo_referencia = a.id_arquivo " +
			 "order by a.descricao";

      pstm = con.prepareStatement(vsql);
      pstm.setInt(1,vprincipal);

      rs = pstm.executeQuery();
	  
	  out.println("<div id='altera_dados'><fieldset><legend>Manutenção de Referências</legend>");
	  
	  if (vdescricao.length() >= 100)
	  {
	     out.println("<br><br<br><div align='center'><legend>&nbsp;&nbsp;Arquivo principal:&nbsp;" + vdescricao.substring(0,90) + "...<br><br></legend></div>");
	  }
	  else
	  {
		 out.println("<br><br<br><div align='center'><legend>&nbsp;&nbsp;Arquivo principal:&nbsp;" + vdescricao.substring(0,vdescricao.length()) + "<br><br></legend></div>");
	  }

      //cabeçalho da tabela
	  out.println("<div align='left'><table id='ref' class='table table-striped table-bordered' cellspacing='0' width='100%'><thead>");
      out.println("<tr><th>ORD</th>");
      out.println("<th>T&Iacute;TULO</th>");
      out.println("<th>DATA</th>");
      out.println("<th>HORA</th>");
	  out.println("<th>USU&Aacute;RIO</th>");
      out.println("<th>EXCLUIR</th></tr></thead><tbody>");
	  
	  int i = 0;	  
	  //linhas da tabela
      while(rs.next())
      {
		 i++;
         out.println("<tr><td align='center'>" + i + "</td>");
         out.println("<td>" + rs.getString("descricao") + "</td>");
         
         //Formatação de data e hora para o formato brasileiro
          String[] dateTime = rs.getString("data_inclusao").split(" ");
          String[] data = dateTime[0].split("-");
          String ano = data[0];
          String mes = data[1];
          String dia = data[2];
          String data_formatada = dia + "/" + mes + "/" + ano;
          String[] hora = dateTime[1].split(":");
          String hora2 = hora[0];
          String minuto = hora[1];
          String segundo = hora[2];
          String segundo2 = segundo.substring(0, 2);
          String[] segundo3 = segundo.split(".");
          String hora_formatada = hora2 + ":" + minuto + ":" + segundo2;
          String data_hora = data_formatada + " " + hora_formatada;
      
         out.println("<td align='center'>" + data_formatada + "</td>");
         out.println("<td align='center'>" + hora_formatada + "</td>");
		 out.println("<td align='center'>" + rs.getString("logon_usuario") + "</td>");
		 out.println("<td align='center'>&nbsp;<a href='#' onclick=\"valida_exclusao('" + rs.getString("id_arquivo_principal") + "','" + rs.getString("id_arquivo_referencia") + "','" + rs.getString("descricao") + "');\" title='Excluir'><img src='/gecoi.3.0/img/excluir_cinza.png' alt='Excluir' border='0'></a>&nbsp;</td>");
         out.println("</tr>");
         
		 vcruzada = rs.getInt("id_cruzada");	
		 vultimareferencia = rs.getInt("id_arquivo_referencia");
		 if (vgrupoprincipal != rs.getInt("id_grupo")) 
		 {
			 vgrupos_diferentes = true;
		 }		 
	  }	 
      out.println("</tbody></table></div>");	  
	  out.println("<br/><div id='referencia' align='right'>");
	  if (i > 0)
	  {
		  if (vgrupos_diferentes)
		  {
			  out.println("<p style='color: red; font-size: 11px;' align='center'>A referência cruzada não pode ser feita em arquivos gerenciados por Grupos diferentes.</p>");		 
		  }
		  else
		  {
			  if (vcruzada > 0)
			  {
				  vsql = "SELECT count(*) as conta from gecoi.referencia WHERE id_arquivo_principal = ? AND id_grupo = ?  AND id_cruzada = ? AND id_arquivo_referencia <> ?";
				  pstm = con.prepareStatement(vsql);
				  pstm.setInt(1,vultimareferencia);
				  //pstm.setInt(2,vgrupo);
				  pstm.setInt(2,vgrupoprincipal);
				  pstm.setInt(3,vcruzada);
				  pstm.setInt(4,vprincipal);
				  rs = pstm.executeQuery();
				  rs.next();
				  if (rs.getInt("conta") > 0)
				  	  vtipocruzada = 2;
				  else
				      vtipocruzada = 1;
			  }

			 
		  }
		  
	  }
	  
	  %>
	  <a href="#" onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/manutencao_configurar_referencia.jsp?idprincipal=<%=vprincipal%>&cruzada=<%=vcruzada%>&grupo=<%=vgrupoprincipal%>&tipocruzada=<%=vtipocruzada%>&descricao=<%=vdescricao%>','divbusca');">Configurar relacionamentos</a>&nbsp;&nbsp;&nbsp;&nbsp;
			  <a href="#"	onclick="carregaPag('/gecoi.3.0/apps/gecoi_arquivos/manutencao_incluir_referencia.jsp?idprincipal=<%=vprincipal%>&descricao=<%=vdescricao%>','divbusca');">(+) Adicionar referências</a>&nbsp;&nbsp;	  
	  <%
	  out.print("</div><br><br><div id='botao' align='center'><input type='button' name='cancelar' value='Voltar' onclick='listar();' /></div><br></fieldset></div>");
	  
	  
	  rs.close(); 
 	  con.close();

 	  
   }
   catch (Exception ex)
   {
      out.println(ex.getMessage());
   }
}
%>
<iframe id="rodape" name="rodape" widht="0" height="0" frameborder="0"></iframe>