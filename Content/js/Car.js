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


function AddToCar(Id) {

    var datos =
    {
        IdProducto : Id
    }

    debugger;

    $.ajax({
        url: "https://localhost:44372/Home/WishList",
        contentType: "Application/json",
        method: "POST",
        data: JSON.stringify(datos),
        dataType: "json",
        success: function (response) {

            if (response.Status == 1) {
                Swal.fire({
                    icon: 'success',
                    title: 'Exito',
                    text: response.Message
                    
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: response.Message
                    
                })
            }

        },
        error: function (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.responseText,
                footer: '<a href="">Why do I have this issue?</a>'
            })
        }
    });

}