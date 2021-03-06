$.extend($.fn.dataTableExt.oSort, {
	"date-br-pre": function(a) {
		if (a == null || a == "") {
			return 0;
		}
		var brDatea = a.split('/');
		return (brDatea[2] + brDatea[1] + brDatea[0]) * 1;
	},

	"date-br-asc": function(a, b) {
		return ((a < b) ? -1 : ((a > b) ? 1 : 0));
	},

	"date-br-desc": function(a, b) {
		return ((a < b) ? 1 : ((a > b) ? -1 : 0));
	}
	
});

$(document)
.ready(
		function tabela_dinamica () {
			$("#gecoi2")
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
						            null,
						            null,
						            { "type": "date-br" },
						            null,
						            null,
						            null
						            ]

					});
		});

function filterGlobal () {
	$('#gecoi2').DataTable().search(
			$('#global_filter').val(),
			$('#global_regex').prop('checked'),
			$('#global_smart').prop('checked')
	).draw();
}

function filterColumn ( i ) {
	$('#gecoi2').DataTable().column(i).search(
			$('#col'+i+'_filter').val(),
			$('#col'+i+'_regex').prop('checked'),
			$('#col'+i+'_smart').prop('checked')
	).draw();
}

$(document).ready(function() {
	$('#gecoi2').DataTable();

	$('input.global_filter').on( 'keyup click', function () {
		filterGlobal();
	} );

	$('input.column_filter').on( 'keyup click', function () {
		filterColumn( $(this).parents('tr').attr('data-column') );
	} );
} );


