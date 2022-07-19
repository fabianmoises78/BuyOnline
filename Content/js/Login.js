$(document).ready(function () {
    var url = window.localStorage.getItem("url");

    $('#LogIn').on('click', function () {

        var datos = {
            Usuario: $('#usuario').val(),
            Contraseña: $('#contraseña').val()
        };
        
        debugger;
        $.ajax({
            url: url + "/Home/LoginIniciar",
            contentType: "Application/json",
            method: "POST",
            data: JSON.stringify(datos),
            dataType: "json",
            success: function (response) {
                if (response.Status == 1) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Exito',
                        text: response.Message,
                        timer: 2000
                    }).then(function () {
                        window.location.href = url;
                        Swal.Close()
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
                    text: error.responseText
                })
            }
        });

    })

});
