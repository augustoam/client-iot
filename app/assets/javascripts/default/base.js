$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };
  $(document).ready(function() {

    $('.card-color').click(function() {
      comandoInfraVermelho($(this));
    });

    $('.repeat-select').each(function() {
      updateValueRepeat(this);
    })

    $('.repeat-select').click(function() {
      updateValueRepeat(this);
    })

    $('.tipo-condicao-select').change(function() {
      updateFormCondicao(this);
    })
  });

}).on("click", "tr[data-href] td", function(e) {
    var $td = $(this);
    if($td.find("a.btn").length === 0) // Apenas se a célula não possuir um botão
      Turbolinks.visit($td.parents("tr:first").data("href"));
})

function updateValueRepeat(element) {
  if ($('.repeat-data')[0].innerText.length > 0) {
    json = JSON.parse($('.repeat-data')[0].innerText)
    json.forEach(function(data) {
      for (var i = 0; i < $('#automacao_grupo_condicao_repeat')[0].options.length; i++) {
        if (data === $('#automacao_grupo_condicao_repeat')[0].options[i].value) {
          $('#automacao_grupo_condicao_repeat')[0].options[i].selected = true;
        }
      }
    })
  }
}

function updateFormCondicao(element) {

  if ($('.tipo-condicao-select')[0].innerText.length > 0) {
    if ($('.tipo-condicao-select').find('input').val() === 'Componente') {
      $('.turn-on-select').hide();
      $('.repeat-select').hide();
      $('.componente-condicao-select').show();
    } else if ($('.tipo-condicao-select').find('input').val() === 'Timer') {
      $('.turn-on-select').show();
      $('.repeat-select').show();
      $('.componente-condicao-select').hide();
    } else if ($('.tipo-condicao-select').find('input').val() === 'Completado Manualmente') {
      $('.turn-on-select').hide();
      $('.repeat-select').hide();
      $('.componente-condicao-select').hide();
    }
  }
}
