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
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        Swal.close()
                        $("#modal").modal('handleUpdate')
                    });
                }
                else{
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
            }, error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error.responseText
                })
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
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        Swal.close()
                        $("#modal").modal('handleUpdate')
                    });
                }
                else{
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message
                    })
                }
            }, error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error.responseText
                })
            }
        });
    });
});

