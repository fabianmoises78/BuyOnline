$(document).ready(function () {
    $("#eliminar").on('click', function () {
        var idpais = sessionStorage.getItem("idpais");

        var datos = {
            idpais: idpais
        };

        $.ajax({
            url: "https://localhost:44372/admin/EliminarPais",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "Ëxito",
                        text: response.Message
                    })
                }
                else {
                    Swal.fire({
                        icon: "success",
                        title: "Error",
                        text: response.Message
                    })
                }
            },
            error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error
                })
            }
        });
    });
});