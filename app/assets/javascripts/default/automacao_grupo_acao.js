$(document).on('turbolinks:load', function() {

  $('#tipo-acao-select').change(function() {
    updateFormCondicao(false);
  })

  $(".form_automacao_grupo_acao").submit(function() {
    updateFormCondicao(true);
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

  processaDiv($(".turn-on-select, .repeat-select, .componente-condicao-select"), $.inArray(condicao, ["Timer"]) >= 0);
  processaDiv($(".componente-condicao-select"), $.inArray(condicao, ["Componente"]) >= 0);
}
