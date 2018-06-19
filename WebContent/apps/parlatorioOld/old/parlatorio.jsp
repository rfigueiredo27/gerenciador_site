    <form name="fparlatorio" >
    	Edi&ccedil;&atilde;o: <input type="text" name="edicao" id="edicao" value="" onkeyup="SoNumero(event, this)" /><br />
        Data de abertura: <input title="Data de abertura" alt="Data de abertura" type="text" name="dataAbertura" id="dataAbertura" value="Abertura" onfocus="this.value='<%=vhoje%>'" size="10" maxlength="10" /><br />
    	<input type="button" name="bparlatorio" id="bparlatorio" value="Alterar Parlat&oacute;rio" onclick="alterar_parlatorio(this.form);" />
        Caminho do Flipbook:
        Arquivo PDF:
        Arquivo Word:
        Imagem da Capa:
        
       	<input type="button" name="bpublicar" id="bpublicar" value="Publicar Parlat&oacute;rio" onclick="publicar_parlatorio(this.form);" />
    </form>
