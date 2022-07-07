$(document).ready(function () {
    
    $('#submit').on('click', function () {

        var datos = {
            Usuario: $('#usuario').val(),
            Contraseña: $('#contraseña').val()
        };
        debugger;
        $.ajax({
            url: "https://localhost:44372/Home/LoginIniciar",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (datos) {
                debugger;
                console.log("success")
            },
            error: function (error) {
                debugger;
                console.log("error")
            }
        });

    })

});


function sendLogin() {

    

}