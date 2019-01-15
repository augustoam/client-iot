$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };

  $('.card-color').click(function() {
    comandoInfraVermelho($(this));
  });

}).on("click", "tr[data-href] td", function(e) {
    var $td = $(this);
    if($td.find("a.btn").length === 0) // Apenas se a célula não possuir um botão
      Turbolinks.visit($td.parents("tr:first").data("href"));
})
