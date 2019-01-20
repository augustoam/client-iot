$(document).on('turbolinks:load', function() {

  $('#tipo-acao-select').change(function() {
    updateFormAcao(false);
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
