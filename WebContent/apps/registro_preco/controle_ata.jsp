<script type="text/javascript">

function gerar()
{
	$.post("/gecoi.3.0/apps/registro_preco/gerar_numero_ata.jsp", [], function(resposta){$("#divcontrole").html(resposta)});
}
</script>

<div id="gerar_numero">
<fieldset>
	<legend>Controle do n&uacute;mero da ata de registro de pre&ccedil;o</legend>

<div id="texto"><p>O número da ata a ser usado:</p></div><div id="divcontrole"></div>
<form name="fnumAta" id="fnumAta" >
	<div id="botao"><input type="button" name="controle_ata" id="controle_ata" value="Gerar número" onclick="gerar();" /></div>
</form>
</fieldset>
</div>