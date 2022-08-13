$(document).ready(function () {

});

function ListarPais() {
    $.ajax({
        url: "https://localhost:44372/admin/ListaPais",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (Paises) {
            var html = "";

            $.each(Paises, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  ' + row.IdPais + ' </th>';
                html += '<td> ' + row.NombrePais + ' </td>';
                html += '<td><button class="btn btn-success" onclick="verpais(' + row.IdPais + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                html += '<tr>';
            });
            $('#ListaPaises').append(html);
        }
    });
}