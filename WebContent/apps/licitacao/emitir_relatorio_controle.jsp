<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>


<%
   String vidArea     = request.getParameter("area")==null ? "" : request.getParameter("area");
   String vano        = request.getParameter("ano")==null ? "" : request.getParameter("ano");
   String vidArquivo  = request.getParameter("idArquivo")==null ? "" : request.getParameter("idArquivo");
%>
       <div id="botao" align="right">
        <input type='button' name='button' class='item_formulario' value='Imprimir' onclick='window.print();'/>
        </div>
      <br>
      <c:set var="idArea" value="<%=vidArea %>" scope="page" />
	  <c:set var="ano" value="<%=vano %>" scope="page" />
	  <c:set var="idArquivo" value="<%=vidArquivo %>" scope="page" />
 	  <jsp:useBean id="lista" class="br.jus.trerj.controle.licitacao.ListaLicitacao" />
	  <c:set var="items" value="${lista.getListaRelatorioControle(idArea, ano, idArquivo, sessionScope['login'], sessionScope['senha'])}" />
	  <c:set var="arquivoAnterior" value="" />
	  <c:forEach var="item" items="${items}" >
      	<c:if test="${arquivoAnterior != item.descricao }" ><br />      	
           	<c:set var="arquivoAnterior" value="${item.descricao }" />
      		<table width="100%" height="35" border="0" align="center" cellpadding="0" cellspacing="1" id="tb_gecoi" >
        		<tr>
          			<th class="texto_branco" bgcolor="#ECECEC"><br />Relat&oacute;rio de Controle dos Editais<br /><br />
          			${item.descricao }<br /><br /></th>
        		</tr>
      		</table>
			<br>      
      	</c:if>
      <table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" id="tb_gecoi">
        <tr > 
          <td width="180">Nome:</td>
          <td width="580">${item.nome}</td>
        </tr>
        <tr bgcolor="#ECECEC"> 
          <td>CPF/CNPJ:</td>
          <td>${item.cpf_cnpj}</td>
        </tr>
        <tr > 
          <td>Tipo Pessoa:</td>
          <td>${item.pessoa}</td>
        </tr>
        <tr bgcolor="#ECECEC"> 
          <td>Endere&ccedil;o:</td>
          <td>${item.endereco} - ${item.bairro} - ${item.cidade} - ${item.uf}</td>
        </tr>
		
        <tr> 
         <td>Contato:</td>
         <td>${item.nome_contato}</td>
        </tr>
        
		<tr bgcolor="#ECECEC"> 
          <td>E_mail:</td>
          <td >${item.email}</td>
        </tr>
        
		<tr> 
          <td>Telefone:</td>
          <td>${item.telefone}</td>
        </tr>
        
		<tr bgcolor="#ECECEC"> 
          <td>Fax:</td>
          <td>${item.fax}</td>
        </tr>
		
        <tr> 
          <td>Data Retirada do Edital:</td>
          <td>${item.data}</td>
        </tr>
        
		<tr bgcolor="#ECECEC">
          <td>Hora Retirada do Edital:</td>
          <td>${item.hora}</td>
        </tr>
      </table>
	  
		<br>
		<c:if test="${item.email != '-' }" >
			<c:set var="listaEmail" value="${listaEmail}${item.email };" />
		</c:if>
		
	  </c:forEach>
            <table border="0" align="center" cellpadding="4" cellspacing="1" id="tb_gecoi">
              <tr>    		  
               <th bgcolor="#ECECEC">E-mail dos Licitantes</th>     
              </tr>	   
	          <tr>    		  
                <td>${listaEmail}</td>     
	          </tr>  
            </table>
            <br />
        <div id="botao">
        		<input type='button' name='button' class='item_formulario' value='Imprimir' onclick='window.print();'/>
        </div>
	  
