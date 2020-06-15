$(document).ready(function(){   
    $(document).on('click', '.btn-add', function() {
        $("#modal-paciente .modal-body").load("cadastro-paciente.html")
        $("#modal-paciente .modal-title h4").html("Cadastrar Paciente")
        $('#modal-paciente').modal('show')
    })
    
    $(document).on('submit', '#add-paciente', function(e){
        e.preventDefault()

        var dados = $('#add-paciente').serialize()
        var url = "../modelo/create-paciente.php"
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
                        title: 'Erro!',
                        text: dados,
                        icon: 'error',
                        confirmButtonText: 'Tente novamente' 
                    })
                }

                
            }
        })
    })
})