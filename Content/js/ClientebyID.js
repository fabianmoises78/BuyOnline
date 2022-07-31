$(document).ready(function () {

});

function VerCliente(Id) {

    var datos = {
        idpersona: Id
    };

    $.ajax({
        url: "https://localhost:44372/admin/VerClienteID",
        contentType: "Application/json"
    });
}