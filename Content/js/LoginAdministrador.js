$(document).ready(function () {
    $("#LogIn").on('click', function () {

        var datos = {
            Usuario: $("#usuario").val(),
            Contraseña: $("#contraseña").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/inicioAdmin",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "Exito",
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        window.location.href = "https://localhost:44372/admin/Mantenimiento";
                        Swal.Close()
                    })
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
                    icon: 'error',
                    title: 'Error',
                    text: error.responseText
                })
            }
        });
    });
});