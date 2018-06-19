<%
	String vDia = request.getParameter("dataFim");
	String vMetas = request.getParameter("metas");
	String vmesExt = request.getParameter("mesExt");
	String vano = request.getParameter("ano");
	
	String vMensagem = "";
	if (vMetas.length() > 3)
	{
		vMetas = vMetas.substring(4);
		String[] vContaMetas = vMetas.split(",");
		String vDescricaoMetas = "a meta ";
		if (vContaMetas.length > 1)
			vDescricaoMetas = "as metas ";
		vMensagem = vDescricaoMetas + "<bold>" + vMetas + "</bold> e ";
	}
	
%>

<div id="divMetas1" ><p>Dia <bold><%=vDia%></bold> &eacute; o &uacute;ltimo dia para responder <%=vMensagem%> a produtividade dos magistrados de <%=vmesExt%> de <%=vano%>!</p></div>
<div id="divMetas2" ><p>ZE 000 voc&ecirc; ainda n&atilde;o enviou todos os dados.  Assim que envi&aacute;-los essa janela n&atilde;o ir&aacute; mais aparecer.</p></div>
