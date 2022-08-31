$(document).ready(function () {
    $("#registro").on('click', function () {
        var datos = {
            nombreTP: $("#nombreTP").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/InsertarTipoPago",
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
                        $("#nombreTP").val("")
                        Swal.close()
                    })
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        Swal.close()
                    })
                }
            }, error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: Error,
                    text: error.responseText,
                    timer: 2000
                }).then(function () {
                    Swal.close()
                })
            }
        });
    });

    $("#EditarUsuario").on('click', function () {
        var id = sessionStorage.getItem("idtp");

        var datos = {
            idtp: id,
            nombretp: $("#nombreTP").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/EditarTipoPago",
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
                    }).then(function () {
                        Swal.close()
                        Location.reload()
                    })
                } else {
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

    $("#eliminar").on('click', function () {
        var id = sessionStorage.getItem("idtp");

        var datos = {
            idtp: id
        };

        $.ajax({
            url: "https://localhost:44372/admin/EliminarTipoPago",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "Éxito",
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        Swal.close()
                        location.reload()
                    })
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: response.Message,
                        timer: 2000
                    })
                }
            }, error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error.responseText,
                    timer: 2000
                })
            }
        });
    });

    $("#buscar").on('click', function () {
        var datos = {
            data: $("#buscarTP").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/BuscvarTipoPago",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (Buscar) {
                $("#ListaTP").html(null);

                var html = "";

                $.each(Buscar, function (index, row) {
                    html += '<tr>';
                    html += '<th scope="row">  ' + row.IdTipoP + ' </th>';
                    html += '<td> ' + row.TipoPago + ' </td>';
                    html += '<td><button class="btn btn-success" onclick="ListarTipoPago(' + row.IdTipoP + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="' + row.IdTipoP + '">Editar</button></td>';
                    html += '<tr>';
                });
                $("#ListaTP").append(html)
            }, error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: error.responseText
                })
            }
        });
    });

    $("#eliminar").on('click', function () {
        $("#modal").modal("hide");
    });
});

function ListarTP() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarTipoPago",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (listarTP) {
            var html = "";

            $.each(listarTP, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  ' + row.IdTipoP + ' </th>';
                html += '<td> ' + row.TipoPago + ' </td>';
                html += '<td><button class="btn btn-success" onclick="ListarTipoPago(' + row.IdTipoP + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="' + row.IdTipoP + '">Editar</button></td>';
                html += '<tr>';
            });
            $("#ListaTP").append(html)
        }
    });
}

function ListarTipoPago(id) {
    var datos = {
        idtp: id
    };

    $.ajax({
        url: "https://localhost:44372/admin/ListarTPbyId",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (listartpid) {
            $("#titulo").html(null);
            var html = "";

            $.each(listartpid, function (index, row) {
                sessionStorage.setItem("idtp", row.IdTipoP);

                html += '<div id="titulo" class="text-center my-4">';
                html += '<h4>Editar Tipo de Pago: ' + row.TipoPago + '</h4>';
                html += '</div>';

                $("#nombreTP").val(row.TipoPago);
                $("#registro").hide();
                $("#EditarUsuario").show();
                $("#ActiDesac").hide();
                $("#ActiDesac2").hide();
                $("#eliminar").show();
                $("#salir").show();
            });

            $("#titulo").append(html);
        }
    });
}