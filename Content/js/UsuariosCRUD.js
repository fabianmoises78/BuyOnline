$(document).ready(function () {

});

function VerClientes() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarClientes",
        contentType: "Application/json",
        method: "GET",
        dataType: "jason",
        success: function (clientes) {
            debugger;
            var html = "";

            $.each(clientes, function () {
                html += '<tr>';
                html += '<th scope="row"> ' + clientes.IdPersona + ' </th>';
                html += '<td>' + clientes.Nombre + '</td>';
                html += '<td>' + clientes.Apellido + '</td>';
                html += '<td>' + clientes.Edad + '</td>';
                html += '<td>' + clientes.Telefono + '</td>';
                html += '<td>' + clientes.Estado + '</td>';
                html += '<td>' + clientes.Nombre1 + '</td>';
                html += '<td>' + clientes.IDCliente + '</td>';
                html += '<td>' + clientes.Usuario + '</td>';
                html += '<td>' + clientes.Correo + '</td>';
                html += '<td>' + clientes.Contraseña + '</td>';
                html += '<td><button class="btn btn-success" onclick="">Editar</button></td>';
                html += '<tr>';
            });
            $('#ListaClientes').append(html);
        },
        error: function (error) {

        }
    });
}