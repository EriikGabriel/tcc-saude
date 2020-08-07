$(document).ready(function () {
  $(document).on("click", ".btn-edit", function () {
    $("#modal-usuario .modal-body").load("edit-usuario.html");
    $("#modal-usuario .modal-body").data("content", $(this).attr("id"));
    $("#modal-usuario .modal-title h4").html("Editar Usuário");
    $("#modal-usuario").modal("show");
  });

  $("#modal-usuario").on("show.bs.modal", function (e) {
    if ($(".modal-body").data("content")) {
      var url = "../modelo/select-usuario.php";
      var dados = { type: "search-select-usuario", table: "TIPO_USUARIO" };

      $.ajax({
        type: "POST",
        datatype: "json",
        url: url,
        async: true,
        data: dados,
        success: function (dados) {
          if (dados != "") {
            var resTipo = JSON.parse(dados);
            for (let i = 0; i < resTipo.length; i++) {
              $(`<option value="${resTipo[i].idTipoUsuario}">${resTipo[i].tipoUsuario}</option>`).appendTo(
                'select[name="idTipoUsuario"]'
              );
            }
          }

          var dados = {
            id: $(".modal-body").data("content"),
            type: "search-data-usuario",
          };

          $.ajax({
            type: "POST",
            datatype: "json",
            url: url,
            async: true,
            data: dados,
            success: function (dados) {
              var dados = JSON.parse(dados)[0];

              $("#nome").val(dados.nomeUsuario);
              $("#idTipoUsuario").val(dados.idTipoUsuario);
            },
          });
        },
      });
    }
  });

  $(document).on("click", "#eye-password", function () {
    $("input[name='senha']").attr("type") == "password"
      ? $("input[name='senha']").attr("type", "text")
      : $("input[name='senha']").attr("type", "password");
    $("#eye-password i").toggleClass("fa-eye-slash fa-eye");
  });

  $(document).on("submit", "#edit-usuario", function (e) {
    e.preventDefault();

    url = "../modelo/edit-usuario.php";

    var dados = {
      idUsuario: $(".modal-body").data("content"),
      nomeUsuario: $("#nome").val(),
      senhaUsuario: $("#senha").val(),
      idTipoUsuario: $("#idTipoUsuario").val(),
    };

    $.ajax({
      type: "POST",
      datatype: "json",
      url: url,
      async: true,
      data: dados,
      success: function (dados) {
        console.log(dados);
        if (dados == "true") {
          location.href = "list-usuario.html";
        }
      },
    });
  });
});
