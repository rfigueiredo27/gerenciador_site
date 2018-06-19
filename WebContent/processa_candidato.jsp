<%@ page import="java.sql.*,java.util.*,br.jus.trerj.funcoes.*"%>
<%@include file="/jsp/conexao_pool_zod_v2.jsp"%>

<%
//recebe os parâmetros do usuário e cria as variáveis
String vturno  = request.getParameter("turno"); //turno da eleição ao qual os arquivos pertencem
String vcandidato  = request.getParameter("cand"); //turno da eleição ao qual os arquivos pertencem
int veleicao = 220; //id da eleição
if ( !(vturno.equals("1") || vturno.equals("2")))
	vturno = "1";
//VerificaCaptcha verificacaptcha = new VerificaCaptcha();
//boolean verifica = verificacaptcha.verify(request.getParameter("vcaptchaContainer"));

boolean verifica=true;

if (verifica)
{
	try
	{ 
		//Seleciona os municípios que estão no banco
		Class.forName("oracle.jdbc.driver.OracleDriver");

		con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());
	   
		//sql que traz o nome do município de duas maneiras: uma normal e a outra sem espaços, acentos, letras minúsculas para comparar com o nome do arquivo da pasta
		String vsql = "SELECT count(*) as conta FROM TABLE(INTERESULT.CANDIDATOS(?, ?))";
		  
		PreparedStatement pstm = con.prepareStatement(vsql);
		pstm.setInt(1,veleicao);
		pstm.setString(2,vcandidato);
	
		resultSet = pstm.executeQuery();
		if (resultSet.next())
		{
			if (resultSet.getInt("conta") < 100)
			{
				//sql que traz o nome do município de duas maneiras: uma normal e a outra sem espaços, acentos, letras minúsculas para comparar com o nome do arquivo da pasta
				vsql = "SELECT sq_candidato, nome_candidato,cod_localidade_tse,nome_localidade_tse, nome_candidato_urna, numero_candidato, partido, cargo " +
						"FROM TABLE(INTERESULT.CANDIDATOS(?, ?))";
		  
				pstm = con.prepareStatement(vsql);
				pstm.setInt(1,veleicao);
				pstm.setString(2,vcandidato);
			
				resultSet = pstm.executeQuery();
				if (resultSet.next())
				{
				   out.println("<br/><br/><table width='100%' border='0' cellpadding='0' cellspacing='1' id='sublinhado'>");
				   out.println("<tr>");
				   out.println("<th align='center' colspan='2'>CANDIDATOS</th>");
				   out.println("</tr>");
			  
				   do
				   {
					 out.println("<tr onclick='carrega_votacao_secao(\"/site/eleicoes/2016/resultados/download_votacao_secao.jsp?sq=" + resultSet.getString("sq_candidato") + "&eleicao=" + veleicao + "\");' title='Download arquivo vota&ccedil;&atilde;o'>");
					 out.println("<td width='20%' valign='middle'><img src='/site/eleicoes/2016/resultados/mostra_imagem.jsp?cand=" + resultSet.getString("sq_candidato") + "&eleicao=" + veleicao + "' title='" + resultSet.getString("nome_candidato_urna") + "' width='81' heigth='113' onerror=\"this.src='img/candidato.png';\"/></td>");
					 out.println("<td width='60%'><h4>Nome:</h4> " + resultSet.getString("nome_candidato") + "<br>" );
					 out.println("<h4>Nome na urna:</h4> " + resultSet.getString("nome_candidato_urna") + "<br>");
					 out.println("<h4>N&uacute;mero:</h4> " + resultSet.getString("numero_candidato") + "<br>");
					 out.println("<h4>Munic&iacute;pio:</h4> " + resultSet.getString("nome_localidade_tse") + "<br>");
					 out.println("<h4>Cargo:</h4> " + resultSet.getString("cargo") + "<br>");
					 out.println("<h4>Partido:</h4> " + resultSet.getString("partido") + "</td>");	
					 out.println("</tr>");
				   }while (resultSet.next());
				   
				   out.println("</table>");
				}
			}
			else
			{
				out.println("<br><br><h2>Muitos candidatos encontrados com o termo indicado.  Favor refine a sua busca.</h2>");
			}
		}
		else {
			 out.println("<br><br><h2>Nenhum candidato encontrado com o termo indicado.</h2>");
		}
		resultSet.close();
	}
	catch (SQLException ex)
	{
	   if (ex.getMessage().toString().indexOf("ORA-02391")>-1)  
	   {
		  out.println("<br><center>");
		  out.println("<h2>A consulta n&atilde;o p&ocirc;de ser realizada!</h2>");
		  out.println("<p>No momento h&aacute; muitos usu&aacute;rios simult&acirc;neos!</p>");
		  out.println("<p>Por favor tente mais tarde.</p>");	  
		  out.println("</center>");
	   }
	   else  
		  out.println("Ocorreu um erro de banco: " + ex.getMessage());
	} 
	finally
	{
		if(con!=null && !con.isClosed())
		   con.close();
	}
}
else
{
	out.print("<br><h2>O Captcha n&atilde;o foi validado corretamente</h2>");
}
%>