<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="br.jus.trerj.controle.revistaJE.AlteraGecoiArquivos"%>

<%
	String vmsg = "";
	String vidArquivo = request.getParameter("idArquivo");
	String vidConteudo = request.getParameter("idConteudo");
	String volume = request.getParameter("volume");
	String numero = request.getParameter("numero");
	String complemento = request.getParameter("complemento");
	String vdescricao = "";
	String vidArea = request.getParameter("idArea");
	
	if(!complemento.equals(""))
	{
		vdescricao = "Revista de Jurisprudência, v. "+volume+", n. "+numero+" - "+complemento ;
		//System.out.println("tem complemento!");
	}	
	else
	{
		vdescricao = "Revista de Jurisprudência, v. "+volume+", n. "+numero;
		//System.out.println("não tem complemento");
	}
	
	//Obter a data atual e converter para string, pois no método incluir a data obrigatoriamente deve ser do tipo String
	Date data = new Date(System.currentTimeMillis());  
	SimpleDateFormat formatarDate = new SimpleDateFormat("dd/MM/yyyy"); 
	String dataPublicacao = formatarDate.format(data);

	AlteraGecoiArquivos altera = new AlteraGecoiArquivos();
	altera.alterar(vidConteudo, vidArquivo, vdescricao, vidArea, dataPublicacao, null, null, "", session.getAttribute("login").toString(), session.getAttribute("senha").toString());
	
	
%>
