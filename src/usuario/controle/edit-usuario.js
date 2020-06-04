$(document).ready(function() {
    $(document).on('click', '.btn-edit', function() {
        $("#modal-usuario .modal-body").load("edit-usuario.html")
        $("#modal-usuario .modal-body").data("content", $(this).attr("id"));
        $("#modal-usuario .modal-title h4").html("Editar Usuário")
        $('#modal-usuario').modal('show')
    })

    $('#modal-usuario').on('show.bs.modal', function (e) {
        if($(".modal-body").data("content")) {
            var url = '../modelo/select-usuario.php'
            var dados = { 
                "type": "search-select-usuario",
                "table": "TIPO_USUARIO" 
            }

            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: url,
                async: true,
                data: dados,
                success: function(dados){
                    var resTipo = JSON.parse(dados)
                    var dados = { 
                        "type": "search-select-usuario",
                        "table": "HOSPITAL" 
                    }
    
                    $.ajax({
                        type: 'POST',
                        datatype: 'json',
                        url: url,
                        async: true,
                        data: dados,
                        success: function(dados){
                            var resHosp = JSON.parse(dados)
    
                            for (let i = 0; i < resTipo.length; i++) {
                                $(
                                    `<option value="${resTipo[i].idTipoUsuario}">${resTipo[i].tipoUsuario}</option>`
                                ).appendTo('select[name="idTipoUsuario"]')
                            }
    
                            for (let i = 0; i < resHosp.length; i++) {
                                $(
                                    `<option value="${resHosp[i].idHospital}">${resHosp[i].nomeHospital}</option>`
                                ).appendTo('select[name="idHospital"]')
                            }

                            var dados = { 
                                "id": $(".modal-body").data("content"),
                                "type": "search-data-usuario"
                            }

                            $.ajax({
                                type: 'POST',
                                datatype: 'json',
                                url: url,
                                async: true,
                                data: dados,
                                success: function(dados){
                                    var dados = JSON.parse(dados)[0]
                                    
                                    $("#nome").val(dados.nomeUsuario)
                                    $("#senha").val(dados.senhaUsuario)
                                    $("#idTipoUsuario").val(dados.idTipoUsuario)
                                    $("#idHospital").val(dados.idHospital)
                                }
                            })
                        }
                    })
                }
            })
        }
    })
})