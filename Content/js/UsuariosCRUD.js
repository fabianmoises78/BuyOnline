$(document).ready(function () {

});

function VerClientes() {
    $.ajax({
        url: "https://localhost:44372/admin/ListarClientes",
        contentType: "Application/json",
        method: "GET",
        dataType: "jason",
        success: function (datos) {
            var html = "";

            $.each(datos, function () {
                html += '';
            });
        }

    });
}