$(document).ready(function (){
    $("#validarregistro").validate({
        rules: {
            nombre: {
                required: true,
                minlength: 3
            },
            apellido: {
                required: true,
                minlength: 3
            },
            edad: {
                required: true,
                minlength: 2,
                maxlength: 3
            },
            numero: {
                required: true,
                minlength: 8,
                maxlength: 12
            },
            usuario: {
                required: true,
                minlength: 6
            },
            correo: {
                required: true,
                minlength: 4
            },
            contraseña: {
                required: true,
                minlength: 8
            },
            contraseña2: {
                required: true,
                minlength: 8
            }
        },
        messages: {
            nombre: {
                required: "Ingrese su nombre.",
                minlength: "El minimo aceptado son 6 caracteres."
            },
            apellido: {
                required: "Ingrese su apellido.",
                minlength: "El minimo aceptado son 6 caracteres."
            },
            edad: {
                required: "Ingrese su edad.",
                minlength: "El minimo aceptado son 2 numeros",
                maxlength: "El maximo aceptado son 3 numeros"
            },
            numero: {
                required: "Ingrese su numero telefonico",
                minlength: "El minimo aceptado es 8 numeros",
                maxlength: "El maximo aceptado es 12 numeros"
            },
            usuario: {
                required: "Ingrese su usuario",
                minlength: "El minimo aceptado son 6 caracteres."
            },
            correo: {
                required: "Recuerde el formato 'ejemplo@dominio.com'.",
                minlength: "El minimo aceptado es 4 caracteres."
            },
            contraseña: {
                required: "Ingrese su contraseña.",
                minlength: "El minimo son 8 caracteres"
            },
            contraseña2: {
                required: "Confirme su contraseña",
                minlength: "El minimo son 8 caracteres."
            }
        }
    });
});

$('#nombre').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$('#apellido').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$('#numero').on('input', function (e) {
    if (!/^[ 0-9]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ 0-9]+/ig, "");
    }
});

$('#usuario').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$('#correo').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ@._-]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$('#contraseña').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$('#contraseña2').on('input', function (e) {
    if (!/^[ a-z0-9áéíóúüñ]*$/i.test(this.value)) {
        this.value = this.value.replace(/[^ a-z0-9áéíóúüñ]+/ig, "");
    }
});

$(document).ready(function () {
    $('#mensaje').hide();
});

var cambiosPass = function () {
    var cont = $('#contraseña').val();
    var cont2 = $('#contraseña2').val();

    if (cont2 == cont) {
        $('#mensaje').hide();
        $('#mensaje').attr("class", "form-control");
        $('#mensaje').show();
        $('#mensaje').html("Las contraseñas si coinciden.");
    }
    else {
        $('#mensaje').html("Las contraseñas no coindicen.");
        $('#mensaje').show();
    }
}
$('#contraseña').on('keyup', cambiosPass);
$('#contraseña2').on('keyup', cambiosPass);