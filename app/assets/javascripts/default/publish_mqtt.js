$(document).on('turbolinks:load', function() {

  $('.publish-mqtt').change(function() {
    publishMqtt($(this));
  })

  $('.publish-mqtt-infravermelho').click(function() {
    publishMqttInfravermelho($(this));
  })

});

function publishMqttInfravermelho(element) {
  var elemento = document.getElementById(element[0].id);
  var room_device = elemento.getAttribute("data-device-room");
  var acao = elemento.getAttribute("data-acao");

  var vData = {
    acao: acao,
    room_device: room_device
  };
  console.log('publish device:' + room_device + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/devices/publish"
  });
}

function publishMqtt(element) {
  var elemento = element[0].getElementsByClassName('device-room-publish');
  var room_device = elemento[0].getAttribute("data-device-room");
  var acao = '';

  if ((elemento[0].id).indexOf('switch') !== -1) {
    if (elemento[0].checked) {
      acao = 'ligar';
    } else {
      acao = 'desligar';
    }
  }

  var vData = {
    acao: acao,
    room_device: room_device
  };
  console.log('publish device:' + room_device + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/devices/publish"
  });

}
