$(document).ready(function(){   
    $(document).on('click', '.btn-add', function() {
        $("#modal-tipo-usuario .modal-body").load("cadastro-tipo-usuario.html")

        $('#modal-tipo-usuario').modal('show')
    })
    
    $(document).on('submit', '#add-tipo-usuario', function(e){
        e.preventDefault()

        var dados = $('#add-tipo-usuario').serialize()
        var url = "../modelo/create_tipo_usuario.php"
        //
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: url,
            async: true,
            data: dados,
            success: function(dados){
                if(dados == "true"){
                    Swal.fire({
                        title: 'TCC',
                        text: "Cadastro efetuado com sucesso",
                        icon: 'success',
                        confirmButtonText: 'Feito' 
                    }).then((result) => {
                        if (result.value) {
                            location.reload()
                        }
                    })
                }else{
                    Swal.fire({
                        title: 'TCC',
                        text: dados.return,
                        icon: 'error',
                        confirmButtonText: 'Tente novamente' 
                    })
                }

                
            }
        })
    })
})