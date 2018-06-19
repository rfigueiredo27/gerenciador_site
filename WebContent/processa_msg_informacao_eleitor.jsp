<%@ page import="java.sql.*,java.util.*,br.jus.trerj.funcoes.*"%>
<%//@include file="/jsp/conexao_pool_internauta.jsp"%>

<%
String vcabecalho = "ATEN&Ccedil;&Atilde;O";   
String vmsg       = "Mensagem enviada com sucesso";
String vemail     = "faleconosco.seaaze@tre-rj.jus.br";    //email da corregedoria

//out.print(request.getParameter("g-recaptcha-response")+"<BR>");
VerificaCaptcha verificacaptcha = new VerificaCaptcha();
boolean verifica = verificacaptcha.verify(request.getParameter("g-recaptcha-response"));

try
{
   //Se algum dado foi enviado
   Enumeration e = request.getParameterNames();
	  
   if(e.hasMoreElements())
   {  
	  //seleciona os dados no banco
      Class.forName("oracle.jdbc.driver.OracleDriver");
      con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());			  
	  
	  //recebe os parâmetros do usuário
      String vassunto         = "Fale Conosco Internet - " + request.getParameter("assunto");
      String vorigem          = request.getParameter("email");
      String vnome            = request.getParameter("nome_completo");
      String vnascimento      = request.getParameter("nascimento");
      String vtitulo          = request.getParameter("titulo");
      String vpai             = request.getParameter("nome_pai");
      String vmae             = request.getParameter("nome_mae");
      String vmunicipio       = request.getParameter("municipio");
      String vddd_residencial = request.getParameter("ddd_residencial");
      String vtel_residencial = request.getParameter("tel_residencial");	  
      String vddd_comercial   = request.getParameter("ddd_comercial");
      String vtel_comercial   = request.getParameter("tel_comercial");	  
      String vtexto           = request.getParameter("mensagem");

	  String vtexto_completo  = "SOLICITANTE" + "<br><hr>" +
	                            "Nome : " + vnome + "<br>" +
	                            "Data de Nascimento: " + vnascimento + "<br>" +
								"T&iacute;tulo de Eleitor: " + vtitulo + "<br>" +
								"Munic&iacute;pio onde vota: " + vmunicipio + "<br><br>" +
								"FILIA&Ccedil;&Atilde;O" + "<br><hr>" +
								"Nome do Pai: " + vpai + "<br>" +
								"Nome da M&atilde;e: " + vmae + "<br><br>" +
								"TELEFONE" + "<br><hr>" +
								"Residencial: " + vddd_residencial + " " + vtel_residencial + "<br>" +
								"Comercial: " + vddd_comercial + " " + vtel_comercial + "<br><br>" +
								"MENSAGEM" + "<br><hr>" + vtexto;
  
      //função sendmail(nome remetente, email remetente, email destino, assunto, mensagem)
      String vsql = "select internauta.sendmail(?,?,?,?,?) as em from dual";

      PreparedStatement pstm = con.prepareStatement(vsql);
      pstm.setString(1,vnome);
      pstm.setString(2,vorigem);
      pstm.setString(3,vemail);
      pstm.setString(4,vassunto);
      pstm.setString(5,vtexto_completo);
	  
      resultSet = pstm.executeQuery();   

      if (resultSet.next())
	  {
	     if (resultSet.getString("em").compareToIgnoreCase("0")!=0)
		 {
		    vcabecalho = "Ocorreu um erro";
		    vmsg = "A sua mensagem n&atilde;o foi enviada. Verifique se o email informado &eacute; um endere&ccedil;o v&aacute;lido.";
		 }

	  }
      resultSet.close(); 
   }
   else
   {
      vmsg = "Nenhum par&acirc;metro foi enviado.";
   }
	  
}
catch (Exception ex)
{
    vcabecalho = "Ocorreu um erro";
    vmsg = "A sua mensagem n&atilde;o foi enviada. Motivo: " + ex.getMessage();
}          
finally
{
   if(con!=null && !con.isClosed())
     con.close(); 	
}
%>
<script language="javascript">
  msg = "<%=vmsg.replaceAll("\\n","")%>";
  parent.$.closePopupLayer('myStaticPopup');
  parent.document.getElementById("cabecalho1").innerHTML = "<h2><%=vcabecalho%></h2>";
  parent.document.getElementById("corpo1").innerHTML = msg + "<br><br><a href=\"javascript:;\" onclick=\"$.closePopupLayer('myStaticPopup1')\" title=\"Fechar\" class=\"close-link\">Fechar</a><br clear=\"all\" /";
  
  parent.openStaticPopup("myStaticPopup1","myHiddenDiv1");
  
  if (msg.indexOf("sucesso")>0)
     parent.document.msg.reset(); 
</script>