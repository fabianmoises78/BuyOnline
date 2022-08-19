$(document).ready(function () {

});

function ListarCategorias() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarPaises",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (listaPais) {
            var html = "";

            $.each(listaPais, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  ' + row.IdCat + ' </th>';
                html += '<td> ' + row.Cat + ' </td>';
                html += '<td><button class="btn btn-success" onclick="VerCliente(' + row.IdPersona + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                html += '<tr>';
            });
            $("#ListaCat").append(html);
        }
    });
}