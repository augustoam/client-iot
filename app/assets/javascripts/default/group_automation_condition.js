$(document).on('turbolinks:load', function () {

  $('#type-condition-select').change(function () {
    updateFormCondition(false);
  })

  $(".form_group_automation_condition").submit(function () {
    updateFormCondition(true);
  })
  $(".device-condition-select").change(function () {
    updateDevicePropriedade($(this));
  })

});

function updateFormCondition(isSubmiting) {
  var $tipoconditionSelect = $("#type-condition-select").find('input');
  var condition = $tipoconditionSelect.val();

  function processaDiv($div, active) {
    if (isSubmiting) {
      if (!active)
        $div.remove();
    } else
      $div.toggle(active);
  }

  processaDiv($(".turn-on-select, .repeat-select, .device-condition-select"), $.inArray(condition, ["Timer"]) >= 0);
  processaDiv($(".device-condition-select, .device-propriedade-select, .value-set-select"), $.inArray(condition, ["Device"]) >= 0);
}
