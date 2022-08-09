$(document).ready(function () {
    $("#buscar").on('click', function () {

        var inf = $("#buscarcliente").val();

        var datos = {
            dat: inf
        };

        $.ajax({
            url: "https://localhost:44372/admin/BuscarCliente",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (busqueda) {
                console.log();
                $('#ListaClientes').html(null);
                console.log();
                var html = "";

                $.each(busqueda, function (index, row) {
                    console.log();
                    html += '<tr>';
                    html += '<th scope="row">  ' + row.IdPersona + ' </th>';
                    html += '<td> ' + row.Nombre + ' </td>';
                    html += '<td> ' + row.Apellido + '</td>';
                    html += '<td> ' + row.Edad + ' </td>';
                    html += '<td> ' + row.Telefono + ' </td>';
                    html += '<td> ' + row.NombrePais + ' </td>';
                    html += '<td> ' + row.Estado + ' </td>';
                    html += '<td> ' + row.IdCliente + ' </td>';
                    html += '<td> ' + row.Usuario + ' </td>';
                    html += '<td> ' + row.Correo + '  </td>';
                    html += '<td> ' + row.Contraseña + ' </td>';
                    html += '<td><button class="btn btn-success" onclick="VerCliente(' + row.IdPersona + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                    html += '<tr>';
                });
                $('#ListaClientes').append(html);
            },
            error: function (error) {
                alert("tuvimos un problema" + error);
            }
        });
    });
});