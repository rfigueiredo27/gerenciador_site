$.fn.dataTableExt.afnSortData['int'] = function (oSettings, iColumn) {
        var aData = [];
        oSettings.oApi._fnGetTrNodes(oSettings).forEach(function (nRow) {
        var oElem = $('td:eq(' + iColumn + ') input', nRow);
        aData.push(oElem.val());
     });
    return aData;
};

$(document)
.ready(
		function tabela_dinamica () {
			$("#documentos")
			.DataTable(
					{
						"oLanguage": {
							"sEmptyTable": "Nenhum registro encontrado",
						    "sInfo": "Mostrando de _START_ at\u00e9 _END_ de _TOTAL_ registros",
						    "sInfoEmpty": "Mostrando 0 at\u00e9 0 de 0 registros",
						    "sInfoFiltered": "(Filtrados de _MAX_ registros)",
						    "sInfoPostFix": "",
						    "sInfoThousands": ".",
						    "sLengthMenu": "Exibir _MENU_ Resultados por p\u00e1gina",
						    "sLoadingRecords": "Carregando...",
						    "sProcessing": "Processando...",
						    "sZeroRecords": "Nenhum registro encontrado",
						    "sSearch": "Filtro",
						    "oPaginate": {
						        "sNext": "Pr\u00f3ximo",
						        "sPrevious": "Anterior",
						        "sFirst": "Primeiro",
						        "sLast": "\u00daltimo"
							}
						},

						"order": [[ 0, "desc" ]],

						"columns": [
						            ['int'],
						            null,
						            null,
						            null,
						            null
						            ]

					});
		});


