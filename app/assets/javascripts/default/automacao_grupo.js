$(document).on('turbolinks:load', function() {

  $('.complete-manually').click(function() {
    completeManually($(this));
  })

});

completeManually = (element) => {
  var vData = {
    automacao_group_id: element[0].getAttribute('data-automacao-group')
  };

  $.post({
    data: vData,
    url: "/api/request/complete_manually"
  });
}