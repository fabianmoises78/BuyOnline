$(document).ready(function () {

});

function search(nombre) {

    $.ajax({
        url: "https://localhost:44372/Home/SearchProduct",
        contentType: "Application/json",
        method: "GET",
        data: JSON.stringify(nombre),
        dataType: "json",
        success: function (datos) {
            //limpiar el contenedor de los productos
            $("#resultados").html(null);

            var html = "";
            
            $.each(datos, function () {
                html += '<div class="card" style="width: 18rem; ">';
                html += '<img class="card - img - top" src=' + datos.Imagen + ' alt="Imagen no encontrada...">';
                html += '<div class="card-body">' +
                    '<h5 class="card-title"> ' + datos.titulo + ' </h5>' +
                    '<p class="card-text">@item.Descripcion</p>' +
                    '</div > '
            });

            //llenar div con los productos 
            $("#resultados").html(html);
        },
        error: function (error) {

        }

    });
}

