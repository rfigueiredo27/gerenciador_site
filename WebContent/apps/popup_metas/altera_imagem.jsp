<%
String vidConteudo = request.getParameter("idConteudo");
String vidArquivo = request.getParameter("idArquivo");
%>

  	<form name="fimagem" action="/gecoi.3.0/SubstituiArquivo" target="processa_background" enctype="multipart/form-data">
  		<input type="text" name="id_conteudo" id="id_conteudo" value="<%=vidConteudo%>" />
  		<input type="text" name="id_arquivo" id="id_arquivo" value="<%=vidArquivo%>" />
  		<!-- a descri��o pode ser nulo que n�o vai alterar na procedure -->
  		<input type="text" name="descricao" id="descricao" value="" /> 
      	<input title="Arquivo a ser substitu�do" alt="Arquivo a ser substitu�do" type="file" name="arquivo" id="arquivo"/>      	
        <input type="submit" name="save" value="Altera o arquivo" />
  	</form>
	<iframe name="processa_background" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>
  	