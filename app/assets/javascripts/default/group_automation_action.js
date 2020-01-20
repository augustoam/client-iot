$(document).on('turbolinks:load', function () {

  $('#type-action-select').change(function () {
    updateFormAction(false);
  })

  $('.device-acao-select').change(function () {
    //updatePropriedadesSelect($(this));
  })

  $(".form_group_automation_action").submit(function () {
    updateFormAction(true);
  })

});

function updateFormAction(isSubmiting) {
  var $tipoAcaoSelect = $("#type-action-select").find('input');
  var acao = $tipoAcaoSelect.val();

  function processaDiv($div, ativo) {
    if (isSubmiting) {
      if (!ativo)
        $div.remove();
    } else
      $div.toggle(ativo);
  }

  processaDiv($(".delay-time-select"), $.inArray(acao, ["Delay"]) >= 0);
  processaDiv($(".device-acao-select, .device-propriedade-acao-select"), $.inArray(acao, ["Device"]) >= 0);
  processaDiv($(".run-automacao-select"), $.inArray(acao, ["Rodar Automação"]) >= 0);
  processaDiv($(".turn-on-off-select, .turn-on-off-automation-select"), $.inArray(acao, ["Desligar/Ligar Automação"]) >= 0);
}

function updatePropriedadesSelect(element) {
  var device = JSON.parse($('.device-acao-select').find('input').val())[2];

  $("select#group_automation_action_device_propriedade_id option").empty();

  $("select#group_automation_action_propriedades option").map(function () {
    if ($(this).text().length > 0) {

      $("select#group_automation_action_device_propriedade_id").append($(this)[0].outerHTML)
    }
  })

  $("select#group_automation_action_device_propriedade_id option").map(function () {
    if ($(this).text().length > 0) {
      if (device != JSON.parse($(this).text())[1]) {
        $(`select#group_automation_action_device_propriedade_id option[value=${$(this).index()}]`).remove()
      }
    } else {
      $(`select#group_automation_action_device_propriedade_id option[value=${$(this).index()}]`).remove()
    }
  })
  $('#group_automation_action_device_propriedade_id').formSelect();

}
