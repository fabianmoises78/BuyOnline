$(document).ready(function () {
    $('#registro').on('click', function () {

        var idpais = $('#paisdata').val();

        var datos = {
            nombre: $('#nombre').val(),
            apellido: $('#apellido').val(),
            edad: $('#edad').val(),
            numero: $('#numero').val(),
            idpais: idpais,
            usuario: $('#usuario').val(),
            correo: $('#correo').val(),
            contraseña: $('#contraseña').val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/RegistrarClientes",
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

                    $('#nombre').val('');
                    $('#apellido').val('');
                    $('#edad').val('');
                    $('#numero').val('');
                    $('#paisdata').select('Pais');
                    $('#usuario').val('');
                    $('#correo').val('');
                    $('#contraseña').val('');
                    $('contraseña2').val('');

                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
            },
            error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error.responseText
                })
            }
        });
    })

    $('#cancelar').on('click', function () {
        $('#modal').modal('hide')
    })
});

