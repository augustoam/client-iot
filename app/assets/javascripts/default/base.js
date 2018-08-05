$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };

  $('.card-color').click(function() {
    comandoInfraVermelho($(this));
  });

}).on("click", "li[data-href], div[data-href]", function(e) {
  Turbolinks.visit($(this).data("href"));
});
