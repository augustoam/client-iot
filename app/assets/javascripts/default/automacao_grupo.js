$(document).on('turbolinks:load', function() {

  $('.complete-manually').click(function() {
    completeManually($(this));
  })

});

completeManually = (element) => {
  var vData = {
    group_automation_id: element[0].getAttribute('data-automacao-group')
  };

  $.post({
    data: vData,
    url: "/api/request/complete_manually"
  });
}