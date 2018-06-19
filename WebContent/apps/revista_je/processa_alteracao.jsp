<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="br.jus.trerj.controle.revistaJE.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String volume = request.getParameter("volume");
	String numero = request.getParameter("numero");
	String mes_inicial = request.getParameter("mes_inicial");
	String mes_final = request.getParameter("mes_final");
	String ano_inicial = request.getParameter("ano_inicial");
	String ano_final = request.getParameter("ano_final");
	String vDescricao = "";
	String vidArea = request.getParameter("idArea");
	
	if(ano_inicial.equals(ano_final))
		vDescricao = "Revista Jusciça Eleitoral em Debate - Volume "+volume+" - Número "+numero+" - "+mes_inicial+" a "+mes_final+" de "+ano_final;
	else
		vDescricao = "Revista Jusciça Eleitoral em Debate - Volume "+volume+" - Número "+numero+" - "+mes_inicial+" de " +ano_inicial+" a "+mes_final+" de "+ano_final;
	
	//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
	Date data = new Date(System.currentTimeMillis());  
	SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
	String dataPublicacao = formatarDate.format(data);

	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vDescricao, vidArea, dataPublicacao, null, null, "", session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	
	
%>
