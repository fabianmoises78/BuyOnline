$(document).ready(function () {
    $("#registro").on('click', function () {
        var datos = {
            nombrecat: $("#nombreCat").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/InsertarCategoria",
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
                    text: error.responseText
                })
            }
        });
    });
});

function ListarCategorias() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarPCategorias",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (listaPais) {
            var html = "";

            $.each(listaPais, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  ' + row.IdCat + ' </th>';
                html += '<td> ' + row.Cat + ' </td>';
                html += '<td><button class="btn btn-success" onclick="ListarCategoria(' + row.IdCat + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                html += '<tr>';
            });
            $("#ListaCat").append(html);
        }
    });
}

function ListarCategoria(id) {
    var datos = {
        idcat: id
    };

    $.ajax({
        url: "https://localhost:44372/admin/ListarPaisbyId",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (listarid) {
            $("#titulo").html(null);

            var html = "";

            $.each(listarid, function (index, row) {
                sessionStorage.setItem("idcat", row.IdCat);


                html += '<div id="titulo" class="mx-auto my-4">';
                html += '<h4>Editar Categoría ' + row.Cat + '</h4>';
                html += '</div>';

                $("#nombreCat").val(row.Cat);
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