$(document).ready(function () {

});

function VerCliente(Id) {

    var datos = {
        idpersona: Id
    };

    $.ajax({
        url: "https://localhost:44372/admin/VerClienteID",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (cliente) {
            //limpiamos el formulario donde esta alojado el ingresar usuarios
            $("#modalMantenimiento").html(null);

            var html = "";

            $.each(cliente, function (index, row) {
                html += '<div class="mx-auto my-4">';
                html += '<h4>Editar Usuario ' + row.Nombre + '</h4>';
                html += '</div>'
                html += '<div class="mx-auto">';
                html += '<form id="validarregistro">';
                html += '<input type="text" id="nombre" value=" ' + row.Nombre + '" name="nombre" placeholder="Nombre" class="form-control input-lg my-3 txt" />';
                html += '<input type="text" id="apellido" value="' + row.Apellido + '" name="apellido" placeholder="Apellido" class="form-control input-lg my-3 txt" />';
                html += '<input type="number" id="edad" value="' + row.Edad + '" name="edad" placeholder="Edad" class="form-control my-3 txt" />';
                html += '<input type="text" id="numero" value="' + row.Telefono + '" name="numero" placeholder="Número Telefónico" class="form-control input-lg my-3 txt" />';
                html += '<select id="paisdata" name="pais" class="form-control input-lg my-3 txt">';
                html += '<option selected value="' + row.IdPais + '" >' + row.NombrePais + '</option>';
                html += '</select>';
                html += '<input type="text" id="usuario" value="' + row.Usuario + '" name="usuario" placeholder="Usuario" class="form-control input-lg my-3 txt" />';
                html += '<input type="email" id="correo" value="' + row.Correo + '" name="correo" placeholder="Correo" class="form-control input-lg my-3 txt" />';
                html += '<input id="contraseña" value="' + row.Contraseña + '" name="contraseña" placeholder="Contraseña" class="form-control input-lg my-3 txt" />';
                html += '</form>';
                html += '</div>';
                html += '<div class=" row my-3 mx-auto">';
                html += '<button class="btn btn-success mx-1" id="EditarUsuario">Editar</button>';
                if (row.IdEstado == 1) {
                    html += '<button class="btn btn-success mx-1" id="ActiDesac">Desactivar</button>';
                } else if (row.IdEstado == 2) {
                    html += '<button class="btn btn-success mx-1" id="ActiDesac">Activar</button>';
                }
                html += '<button class="btn btn-danger mx-1" onclick="location.reload()" id="">Salir</button>';
                html += '</div>';
            });

            $("#modalMantenimiento").append(html);
        }
    });
}