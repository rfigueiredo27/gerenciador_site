<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@include file="/apps/global/conexao_pool_internauta_v2.jsp"%>

<%
//recupera o número da zona e o ano
String vposto = request.getParameter("posto");
String vinicial = request.getParameter("inicial");
String vfinal = request.getParameter("final");
String vlink      = "analitico.csv";
String caminho = "D:\\Aplic\\Apache Software Foundation\\Tomcat 8.5\\webapps\\gecoi.3.0\\webtemp\\analitico.csv";
FileOutputStream fos = new FileOutputStream(caminho,false);
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

		String vsql = "SELECT TO_CHAR(a.data, 'DD/MM/YYYY') AS data, a.id_posto, a.nome_posto, a.ocupacao, a.cumprimeto_norma, " +
			"a.vagas_abertas, a.agendamentos_marcados, a.raes, " +
			"a.\"RAES/AGENDAMENTOS\", a.servidores, a.vagas_estimadas " +  
			"FROM internauta.monitora_agendamento_diario a " +
			"WHERE a.data BETWEEN To_Date(?, 'dd/mm/yyyy') AND To_Date(?, 'dd/mm/yyyy') ";
		if (vposto.equals("0"))
		vsql = vsql + " and a.nome_posto NOT LIKE '%POSTO DE ATENDIMENTO%' ";
		else 
		vsql = vsql + " AND a.nome_posto = ? ";
		
		PreparedStatement pstm = con.prepareStatement(vsql);
		pstm.setString(1, vinicial);
		pstm.setString(2, vfinal);
		if (!vposto.equals("0"))
		pstm.setString(3, vposto);
		resultSet = pstm.executeQuery();
		
	if (resultSet.next())
	{
		//Monta o cabeçalho dos campos
		//out.print("Nº,Nome,CPF,Data_Nascimento,E_Mail,Telefone,Ecolaridade,Qualificação,Empresa,Tel_Comercial,Cadastro,Certificado\n");
		//String vcep = "";
		String linha = "POSTO DE ATENDIMENTO,DATA,OCUPACAO,CUMPRIMENTO NORMA,VAGAS,AGENDAMENTOS,RAES,RAES / AGENDAMENTO,SERVIDORES\n";
		fos.write(linha.getBytes());
		fos.flush();
		
		do
		{
			//limpa os hifens do cep e os espaços em branco, deixando todos igual
			//vcep = resultSet.getString("cep").trim().replace("-", "");
			linha="\"" + 
						resultSet.getString("nome_posto") + 
						"\",\"" + 
						resultSet.getString("data") + 
						"\",\"" +
						resultSet.getString("ocupacao") + 
						"\",\"" +  
						resultSet.getString("cumprimeto_norma") + 
						"\",\"" + 
						resultSet.getString("vagas_abertas") + 
						"\",\"" + 
						resultSet.getString("agendamentos_marcados") + 
						"\",\"" + 
						resultSet.getString("raes") + 
						"\",\"" + 
						resultSet.getString("RAES/AGENDAMENTOS") + 
						"\",\"" + 
						resultSet.getString("numero_identdd") + 
						"\",\"" + 
						resultSet.getString("servidores") + 
						"\"\n";
			
					fos.write(linha.getBytes());
					fos.flush();
		} while (resultSet.next());
	}
     resultSet.close();
	 fos.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
	vlink = "jsp/erro.htm"; 
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
%>
<script>
top.atualiza_link();
</script>