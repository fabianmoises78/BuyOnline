$(document).ready(function(){

});

function ListarPais() {

    $.ajax({
        url: "https://localhost:44372/admin/ListaPais",
        contentType: "Application/json",
        method: "POST",
        dataType: "json",
        success: function (paises) {
            var html = "";

            $.each(paises, function (index, row) {
                html += '<option value="' + row.IdPais + '">' + row.NombrePais + '</option>'
            });
            $('#paisdata').append(html);
        },
        error: function (error) {

        }
    });
}