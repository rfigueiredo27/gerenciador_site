<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>


<%
   String vidArea     = request.getParameter("area")==null ? "" : request.getParameter("area");
   String vano        = request.getParameter("ano")==null ? "" : request.getParameter("ano");
   String vidArquivo  = request.getParameter("idArquivo")==null ? "" : request.getParameter("idArquivo");
%>
       <table width="719" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
           <td><a href="#" onclick="window.print();" id="bt_imprimir"><img src="/gecoi.3.0/img/botao_imprimir.gif" width="100" height="40" border="0"/></a></td>
         </tr>
       </table>
      <br>
      <c:set var="idArea" value="<%=vidArea %>" scope="page" />
	  <c:set var="ano" value="<%=vano %>" scope="page" />
	  <c:set var="idArquivo" value="<%=vidArquivo %>" scope="page" />
 	  <jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
	  <c:set var="items" value="${lista.getListaRelatorioControle(idArea, ano, idArquivo, sessionScope['login'], sessionScope['senha'])}" />
	  <c:set var="arquivoAnterior" value="" />
	  <c:forEach var="item" items="${items}" >
      	<c:if test="${arquivoAnterior != item.descricao }" >
           	<table width="725" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
               	<tr bgcolor="#FFFFFF">    		  
               		<td  >E-mail dos Licitantes</td>     
           		</tr>	   
          		<tr bgcolor="#FFFFFF">    		  
					<td  >${item.email}</td>     
          		</tr>  
           	</table>
           	<br />      	
           	<c:set var="arquivoAnterior" value="${item.descricao }" />
      		<table width="725" height="35" border="0" align="center" cellpadding="0" cellspacing="1" id="tab_extrato" >
        		<tr>
          			<th class="texto_branco"><br />Relat&oacute;rio de Controle dos Editais<br /><br />
          			${item.descricao }<br /><br /></th>
        		</tr>
      		</table>
			<br>      
      	</c:if>
      <table width="725" border="0" align="center" cellpadding="4" cellspacing="1" id="tab_extrato">
        <tr > 
          <td width="180">Nome:</td>
          <td width="580">${item.nome}</td>
        </tr>
        <tr > 
          <td>CPF/CNPJ:</td>
          <td>${item.cpf_cnpj}</td>
        </tr>
        <tr > 
          <td>Tipo Pessoa:</td>
          <td>${item.pessoa}</td>
        </tr>
        <tr > 
          <td>Endere&ccedil;o:</td>
          <td>${item.endereco} - ${item.bairro} - ${item.cidade} - ${item.uf}</td>
        </tr>
		
        <tr> 
         <td>Contato:</td>
         <td>${item.nome_contato}</td>
        </tr>
        
		<tr> 
          <td>E_mail:</td>
          <td >${item.email}</td>
        </tr>
        
		<tr> 
          <td>Telefone:</td>
          <td>${item.telefone}</td>
        </tr>
        
		<tr> 
          <td>Fax:</td>
          <td>${item.fax}</td>
        </tr>
		
        <tr> 
          <td>Data Retirada do Edital:</td>
          <td>${item.data}</td>
        </tr>
        
		<tr>
          <td>Hora Retirada do Edital:</td>
          <td>${item.hora}</td>
        </tr>
      </table>
	  
		<br>
		<c:if test="${item.email != '-' }" >
			<c:set var="listaEmail" value="${listaEmail}${item.email };" />
		</c:if>
		
	  </c:forEach>
            <table width="725" border="0" align="center" cellpadding="4" cellspacing="1" id="tab_extrato">
              <tr>    		  
               <th class="texto_branco">E-mail dos Licitantes</th>     
              </tr>	   
	          <tr>    		  
                <td>${listaEmail}</td>     
	          </tr>  
            </table>
            <br />
            <table width="719" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><a href="#" onclick="window.print();" id="bt_imprimir"><img src="img/botao_imprimir.gif" width="100" height="40" border="0"/></a></td>
              </tr>
            </table>
	  
