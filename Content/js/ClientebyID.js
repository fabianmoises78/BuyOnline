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
            $("#titulo").html(null);

            var html = "";

            $.each(cliente, function (index, row) {

                html += '<div id="titulo" class="mx-auto my-4">';
                html += '<h4>Editar Usuario ' + row.Nombre + '</h4>';
                html += '</div>';

                $("#nombre").val(row.Nombre);
                $("#apellido").val(row.Apellido);
                $("#edad").val(row.Edad);
                $("#numero").val(row.Telefono);
                $("#paisdata option[value=" + row.IdPais + "]").attr("selected", true);
                $("#usuario").val(row.Usuario);
                $("#correo").val(row.Correo);
                $("#contraseña").val(row.Contraseña);
                $("#contraseña2").hide();
                $("#mensaje").hide();
                $("#registro").hide();
                $("#EditarUsuario").show();
                if (row.IdEstado == 1) {
                    $("#ActiDesac").show();
                    $("#ActiDesac2").hide();
                } else if (row.IdEstado == 2) {
                    $("#ActiDesac2").show();
                    $("#ActiDesac").hide();
                }

                $("#salir").show();
            });

            $("#titulo").append(html);
        }
    });
}