<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="br.jus.trerj.controle.revistaJE.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String link = request.getParameter("link");
	String hint = request.getParameter("hint");
	String target = request.getParameter("target");
	String vdescricao = request.getParameter("descricao");
	String vobservacao = "";
	String vidArea = request.getParameter("idArea");
	
	vobservacao = link+"@"+hint+"@"+target;
	
	//Obter a data atual e converter para string, pois no m�todo incluir a data obrigatoriamente deve ser do tipo String
	Date data = new Date(System.currentTimeMillis());  
	SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
	String dataPublicacao = formatarDate.format(data);

	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vidArea, dataPublicacao, null, null, vobservacao, session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	
	
%>
