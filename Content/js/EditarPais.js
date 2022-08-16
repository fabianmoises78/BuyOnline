$(document).ready(function () {
    $("#EditarUsuario").on('click', function () {
        var idpais = sessionStorage.getItem("idpais");

        var datos = {
            nombrepais: $("#nombrepais").val(),
            idpais: idpais
        };

        $.ajax({
            url: "https://localhost:44372/admin/EditarPais",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "Éxito",
                        text: response.Message
                    })
                }
                else {
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
                    text: error
                })
            }
        });
    });
});