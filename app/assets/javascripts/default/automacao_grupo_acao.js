$(document).on('turbolinks:load', function() {

  $('#tipo-acao-select').change(function() {
    updateFormAcao(false);
  })

  $('.componente-acao-select').change(function() {
    updatePropriedadesSelect($(this));
  })

  $(".form_automacao_grupo_acao").submit(function() {
    updateFormAcao(true);
  })

});

function updateFormAcao(isSubmiting) {
  var $tipoAcaoSelect = $("#tipo-acao-select").find('input');
  var acao = $tipoAcaoSelect.val();

  function processaDiv($div, ativo) {
    if (isSubmiting) {
      if (!ativo)
        $div.remove();
    } else
      $div.toggle(ativo);
  }

  processaDiv($(".delay-time-select"), $.inArray(acao, ["Delay"]) >= 0);
  processaDiv($(".componente-acao-select, .componente-propriedade-acao-select"), $.inArray(acao, ["Componente"]) >= 0);
  processaDiv($(".run-automacao-select"), $.inArray(acao, ["Rodar Automação"]) >= 0);
  processaDiv($(".turn-on-off-select"), $.inArray(acao, ["Desligar/Ligar Automação"]) >= 0);
}

function updatePropriedadesSelect(element) {
  var componente = JSON.parse($('.componente-acao-select').find('input').val())[2];
  $("select#automacao_grupo_acao_componente_propriedade_id option").map(function() {
    if ($(this).text().length > 0 ) {
      if (componente != JSON.parse($(this).text())[1]) {
        $(`select#automacao_grupo_acao_componente_propriedade_id option[value=${$(this).index()}]`).remove()
      }
    }
  })
  $('#automacao_grupo_acao_componente_propriedade_id').formSelect();

}
