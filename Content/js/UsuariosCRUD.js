$(document).ready(function () {

});

function VerClientes() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarClientes",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (clientes) {
            debugger;
            var html = "";

            $.each(clientes, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  '+row.IdPersona+' </th>';
                html += '<td> '+ row.Nombre+' </td>';
                html += '<td> '+ row.Apellido +'</td>';
                html += '<td> '+row.Edad +' </td>';
                html += '<td> '+row.Telefono +' </td>';
                html += '<td> ' + row.NombrePais+' </td>';
                html += '<td> ' + row.Estado + ' </td>';
                html += '<td> ' + row.IdCliente + ' </td>';
                html += '<td> ' + row.Usuario + ' </td>';
                html += '<td> ' + row.Correo + '  </td>';
                html += '<td> '+ row.Contraseña +' </td>';
                html += '<td><button class="btn btn-success" onclick="" value=" ' + row.IdPersona +'">Editar</button></td>';
                html += '<tr>';
            });
            $('#ListaClientes').append(html);
        },
        error: function (error) {

        }
    });
}