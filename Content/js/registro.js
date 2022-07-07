$(document).ready(function () {
    //Obtener el id del doc
    var cod = document.getElementById("opciones").value = select.value;

    $('#registrarse').on("click", function () {
        alert('boton registrarse')
    });

});

function llenarInput() {
    var select = document.getElementById("opciones");
    document.getElementById("opciones2").value = select.value;
}


function enviar_formulario() {

    var datos = {
        edad: $('#edad').val(),
        nombre: $('#nombre').val()
        //fechaRegistro: getDate()
        // 
    };
    debugger;
    //var url = localStorage.getItem("desarrollo").toString;
    // https://192.179.225.0/Tienda/
    // https://localhost:8080/

    $.ajax({
        url: "https://localhost:44372/Home/RegistroNuevo",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (datos) {
            alert('éxito');
        },
        error: function (error) {

        }

    });

}