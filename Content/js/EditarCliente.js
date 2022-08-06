$(document).ready(function () {
    $("#EditarUsuario").on('click', function () {
        idpersona = sessionStorage.getItem("idpersona");
        idpais = $("#paisdata").val();

        var datos = {
            idpersona: idpersona,
            nombre: $("#nombre").val(),
            apellido: $("#apellido").val(),
            edad: $("#edad").val(),
            numero: $("#numero").val(),
            idpais: idpais,
            usuario: $("#usuario").val(),
            correo: $("#correo").val(),
            contraseña: $("#contraseña").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/EditarCliente",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "Exito",
                        text: response.Message
                    })
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
            }
        });
    });
});