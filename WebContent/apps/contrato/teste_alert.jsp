

<!-- Core files -->

<script type="text/javascript" src="/gecoi.3.0/apps/contrato/scripts/jquery.js"></script>
<script src="/gecoi.3.0/apps/contrato/scripts/jquery.ui.draggable.js" type="text/javascript"></script>
		<script src="/gecoi.3.0/apps/contrato/scripts/alerts.js" type="text/javascript"></script>
		<link href="/gecoi.3.0/apps/contrato/css/alerta.css" rel="stylesheet" type="text/css" media="screen" />



<script type="text/javascript">

			$(document).ready( function() {

				$("#alert_button").click( function() {
					jAlert('Arquivo Incluido', 'Teste');
				});	
			});

		</script>


    <p>
				<input id="alert_button" type="button" value="Show Alert" />
			</p>		

