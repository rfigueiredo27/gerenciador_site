<%@ page language="java" import="java.sql.*,java.io.*, java.util.*, oracle.jdbc.OracleTypes" %>

<%
//String vcor       = "#ECECEC";  // zebra a tabela
%>

<h2>Selecione a reportagem para inclu&iacute;-la no DESTAQUE</h2>
	<table id="tb_gecoi"><thead>
		<tr>
			<th scope="col" width="20%">Se&ccedil;&atilde;o</th>
			<th scope="col" width="70%">Reportagem</th>
			<th scope="col" width="10%" colspan="2">A&Ccedil;&Otilde;ES</th>
		</tr></thead>
<% 
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = connectionFactory.getConnection(identificador, request.getServletPath(), request.getRemoteAddr());

	String vsql = "SELECT aq.descricao, aq.id_arquivo, aq.id_conteudo, co.data_criacao " +
                   "FROM gecoi.conteudo co, gecoi.arquivo aq, gecoi.conteudo_area ca " +
                   "WHERE aq.id_conteudo=co.id_conteudo AND co.id_conteudo=ca.id_conteudo " +
                   "AND ca.id_area=? AND Nvl(co.observacao,' ') <> 'PUBLICADO' and aq.ordem > 0 ";
	PreparedStatement pstm = con.prepareStatement(vsql);
	pstm.setInt(1, vid_area);
	resultSet = pstm.executeQuery();
   
	if ( resultSet.next() )
	{
		do 
		{
			String[] vdescricao = resultSet.getString("descricao").split("@@");
			if (vcor.equals(""))
				vcor="#ECECEC";
			else
				vcor="";    
%>
			<tr bgcolor=<%=vcor%> >
				<td align="left"><%=vdescricao[0]%></td>
				<td align="left"><%=vdescricao[1]%></td>
				<td><a href="/gecoi.3.0/apps/global/grava_arquivo.jsp?idArquivo=<%=resultSet.getString("id_arquivo")%>" target="_blank" title="Visualização da not&iacute;cia"><img id="arquivo<%=resultSet.getString("id_arquivo")%>" name="arquivo<%=resultSet.getString("id_arquivo")%>" src="/gecoi.3.0/img/consulta.png" onClick="" width="22" height="22" /></a></td>
				<td><a href="#" onclick="carregaPag('/gecoi.3.0/apps/','divbusca');"  title="Manutenção da TV"><img id="tv<%=resultSet.getString("id_arquivo")%>" name="tv<%=resultSet.getString("id_arquivo")%>" src="/gecoi.3.0/img/texto.jpg" onClick="" width="22" height="22" /></a></td>
			</tr>					
<%
		}while (resultSet.next());
	}
	resultSet.close();
}
catch (Exception ex)
{
	out.print("Ocorreu o seguinte erro na gravacao do arquivo: " + ex.getMessage() );
}
finally
{
	if(con!=null && !con.isClosed())
		con.close();
}
%>
	</table>
<form name="fdestaque" action="/gecoi.3.0/apps/parlatorio/processa_novo_destaque.jsp" method="post"  target="processa_background" enctype="multipart/form-data" id="formulario" autocomplete="off" >
<div id="data_destaque">
    		<fieldset>
                <legend>Data de Publica&ccedil;&atilde;o</legend>
				<input title="Data de publica&ccedil;&atilde;o" alt="Data de publica&ccedil;&atilde;o" type="text" name="dataDestaque" id="dataDestaque" size="10" maxlength="10"/>
            </fieldset>
	    </div>
<div id="descricao_destaque">
    		<fieldset>
                <legend>Descri&ccedil;&atilde;o</legend>
				<textarea title="Descri&ccedil;&atilde;o do Destaque" alt="Descri&ccedil;&atilde;o do Destaque" name="descricaoDestaque" id="descricaoDestaque"></textarea>
            </fieldset>
	    </div>
        <div id="incluir_imagem_destaque">
      		<fieldset>
        	<legend>Incluir Imagem do Destaque</legend>
        	<div id="campoArquivo" align="left"><input title="Imagem a ser inserida" alt="Imagem a ser inserida" type="file" name="arquivo" id="arquivo" /></div>
			<div id="progressBar" style="display: none;">
				<div id="theMeter">
            		<div id="progressBarText"></div>
                	<div id="progressBarBox">
                		<div id="progressBarBoxContent"></div>
               		</div>
            	</div>
         	</div>
   		  </fieldset>
      </div>
      <div id="botao">
        	<input type="button" name="cancelar" value="Cancelar" onclick="atualizaTela();" />
         	<input type="button" name="gravar" id="gravar" value="Gravar" onclick="criticaAnexo();"  />
      </div>
</form>
<div id="divbusca"></div>
<iframe name="processa_background" frameborder="0" allowtransparency="yes" height="0" width="0"></iframe>