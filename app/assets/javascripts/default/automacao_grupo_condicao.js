$(document).on('turbolinks:load', function() {

  $('#tipo-condicao-select').change(function() {
    updateFormCondicao(false);
  })

  $(".form_group_automation_condition").submit(function() {
    updateFormCondicao(true);
  })
  $(".device-condicao-select").change(function() {
    updateDevicePropriedade($(this));
  })

});

function updateFormCondicao(isSubmiting) {
  var $tipoCondicaoSelect = $("#tipo-condicao-select").find('input');
  var condicao = $tipoCondicaoSelect.val();

  function processaDiv($div, ativo) {
    if (isSubmiting) {
      if (!ativo)
        $div.remove();
    } else
      $div.toggle(ativo);
  }

  processaDiv($(".turn-on-select, .repeat-select, .device-condicao-select"), $.inArray(condicao, ["Timer"]) >= 0);
  processaDiv($(".device-condicao-select, .device-propriedade-select, .value-set-select"), $.inArray(condicao, ["Device"]) >= 0);
}
