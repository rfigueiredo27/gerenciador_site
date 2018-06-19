<%@include file="/includes/prepara_barra_progresso.jsp"%>
<%@ page import="java.util.Calendar"%>
<%
	Calendar c = Calendar.getInstance();
	String vano = "" + c.get(Calendar.YEAR);
%>
<div id='tabs2'>
			<ul>
				<li tabindex='1'><a href='#tabs-21' onclick="" >Inclus&atilde;o de contratos</a></li>
				<li tabindex='2'><a href='#tabs-22' onclick="">Manuten&ccedil;&atilde;o de contratos</a></li>
			</ul>
			<div id='tabs-21'>
				<%@include file="contratos_sem_licitacao_inclusao.jsp"%>
            </div>
			<div id='tabs-22'>
				<%@include file="contratos_sem_licitacao_manutencao.jsp"%>
			</div>
		</div>