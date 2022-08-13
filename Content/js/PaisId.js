$(document).ready(function () {

});

function verpais(id) {
    var datos = {
        id: id
    };

    $.ajax({
        url: "https://localhost:44372/admin/PaisbyId",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (ListaPais) {
            $("#titulo").html(null);

            var html = "";

            $.each(ListaPais, function (index, row) {
                sessionStorage.setItem("idpais", row.IdPais);

                html += '<div id="titulo" class="mx-auto my-4">';
                html += '<h4>Editar país ' + row.NombrePais + '</h4>';
                html += '</div>';

                $("#nombrepais").val(row.NombrePais);
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