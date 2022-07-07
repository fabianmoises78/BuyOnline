$(document).ready(function () {
    $("#validarlogin").validate({
        rules: {
            usuario: {
                required: true,
                minlength: 3
            },
            contraseña: {
                required: true,
                minlength: 8
            }
        },
        messages: {
            usuario: {
                required: "Ingrese su usuario",
                minlenght: "Ingrese un usuario de mas de 3 dijitos"
            },
            contraseña: {
                required: "Ingrese su contraseña",
                minlength: "La contraseña debe tener minimo 8 caracteres"
            }
        }
    });
});

