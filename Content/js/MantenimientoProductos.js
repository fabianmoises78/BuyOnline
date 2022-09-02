$(document).ready(function () {
    $("#registro").on('click', function () {
        var datos = {
            Nombre: $("#nombre").val(),
            Descripcion: $("#descripcion").val(),
            Imagen: $("#link").val(),
            precio: $("#precio").val(),
            Exis: $("#existencias").val(),
            Valoracion: $("#valoracion").val(),
            Idcat: $("#cate").val(),
            Detalles: $("#detalles").val()
        };

        $.ajax({
            url: "https://localhost:44372/admin/RegistrarProducto",
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
                        $("#nombre").val("")
                        $("#descripcion").val("")
                        $("#link").val("")
                        $("#precio").val("")
                        $("#existencias").val("")
                        $("#valoracion").val("")
                        $("#detalles").val("")
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
});

function ListarProductos() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarProductos",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (listarproductos) {
            var html = "";

            $.each(listarproductos, function (index, row) {
                html += '<tr>';
                html += '<th scope="row">  ' + row.IdProducto + ' </th>';
                html += '<td> ' + row.Nombre + ' </td>';
                html += '<td> ' + row.Descripcion + '</td>';
                html += '<td><a href="' + row.Imagen+'" class="btn-link">ver imagen</a></td>'
                html += '<td> ' + row.precio + ' </td>';
                html += '<td> ' + row.Exis + ' </td>';
                html += '<td> ' + row.Valoracion + ' </td>';
                html += '<td> ' + row.Estado + ' </td>';
                html += '<td> ' + row.Cat + ' </td>';
                html += '<td> ' + row.Detalles + '  </td>';;
                html += '<td><button class="btn btn-success" onclick="VerProducto(' + row.IdProducto + ')" data-toggle="modal" data-target=".bd-example-modal-sm" value="">Editar</button></td>';
                html += '<tr>';
            });

            $("#ListaP").append(html);
        }
    });
}

function ListarCategoria() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarPCategorias",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (cate) {
            var html = "";

            $.each(cate, function (index, row) {
                html += '<option value="' + row.IdCat + '">' + row.Cat + '</option>'
            });
            $('#cate').append(html);
        },
        error: function (error) {

        }
    });
}