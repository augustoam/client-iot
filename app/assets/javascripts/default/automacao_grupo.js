$(document).on('turbolinks:load', function() {

  $('.complete-manually').click(function() {
    completeManually($(this));
  })

});

completeManually = (element) => {
  var vData = {
    automacao_grupo_id: element[0].getAttribute('data-automacao-grupo')
  };

  $.post({
    data: vData,
    url: "/api/request/complete_manually"
  });
}