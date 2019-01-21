$(document).on('turbolinks:load', function() {

  $('#tipo-condicao-select').change(function() {
    updateFormCondicao(false);
  })

  $(".form_automacao_grupo_condicao").submit(function() {
    updateFormCondicao(true);
  })
  $(".componente-condicao-select").change(function() {
    updateComponentePropriedade($(this));
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
  processaDiv($(".componente-condicao-select, .componente-propriedade-select, .value-set-select"), $.inArray(condicao, ["Componente"]) >= 0);
}

function updateComponentePropriedade(element) {
  $.post({
    url: Routes.update_componente_propriedades_admin_automacao_grupo_automacoes_grupo_condicoes_path($('.input-componente-ambiente').data('grupo-id')),
    data: {
      componente: JSON.parse(element.find('input').val())[1]
    }
  })
}
