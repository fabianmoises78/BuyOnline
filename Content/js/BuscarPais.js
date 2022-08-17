$(document).ready(function () {
    $("#buscar").on('click', function () {
        var pais = $("#buscarpais").val();

        var datos = {
            pais: pais
        };

        $.ajax({
            url: "https://localhost:44372/admin/BuscarPais",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (paises) {
                $("#ListaPaises").html(null);

                var html = "";

                $.each(paises, function (index, row) {
                    if (row.IdPais > 0) {
                        html += '<tr>';
                        html += '<th scope="row">  ' + row.IdPais + ' </th>';
                        html += '<td> ' + row.NombrePais + ' </td>';
                        html += '<td><button class="btn btn-success" onclick="verpais(' + row.IdPais + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                        html += '<tr>';
                    } else if(row.IdPais < 0) {
                        html += '<tr>';
                        html += '<th scope="row"> Sin datos </th>';
                        html += '<td> Sin datos </td>';
                        html += '<tr>'
                    }
                });

                $("#ListaPaises").append(html);
            }
        });
    });
});