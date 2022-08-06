$(document).ready(function () {
    $("#ActiDesac").on('click', function () { //desactiva al usuario

        var idcliente = sessionStorage.getItem("idcliente");
        var idestado = sessionStorage.getItem("idestado");

        datos = {
            idcliente: idcliente,
            idestado: idestado
        };

        $.ajax({
            url: "https://localhost:44372/admin/ActiDesac",
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
                }
                else if (response.Status == 0) {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
                else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Error"
                    })
                }
            }
        });
    });

    $("#ActiDesac2").on('click', function () { //activa al usuario

        var idcliente = sessionStorage.getItem("idcliente");
        var idestado = sessionStorage.getItem("idestado");

        datos = {
            idcliente: idcliente,
            idestado: idestado
        };

        $.ajax({
            url: "https://localhost:44372/admin/ActiDesac",
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
                }
                else if (response.Status == 0) {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
                else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Error"
                    })
                }
            }
        });
    });
});

