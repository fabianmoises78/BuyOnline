$(document).ready(function () {
    $('#registro').on('click', function () {

        var datos = {
            nombrepais: $("#nombrepais").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/RegistrarPais",
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

                    $("#nombrepais").val('');
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
                    text: error
                })
            }
        });
    });
});