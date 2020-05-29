$(document).ready(function() {
    $(document).on('click', '.btn-edit', function() {
        $("#modal-especialidade .modal-body").load("edit-especialidade.html")
        $("#modal-especialidade .modal-body").data("content", "edit");

        $('#modal-especialidade').modal('show')
    })

    $('#modal-especialidade').on('show.bs.modal', function (e) {
        var url = '../modelo/select-especialidade.php'

        var dados = { 
            "id": $(".btn-view").attr("id"),
            "type": "search-dados"
        }

        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: url,
            async: true,
            data: dados,
            success: function(dados){
                var dados = JSON.parse(dados)[0]

                $("#nome").val(dados.nomeEspecialidade)
            }
        })
        
    })
})