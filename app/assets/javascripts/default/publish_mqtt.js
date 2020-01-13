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
  var device_room = elemento.getAttribute("data-device-room");
  var acao = elemento.getAttribute("data-acao");

  var vData = {
    acao: acao,
    device_room: device_room
  };
  console.log('publish device:' + device_room + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/devices/publish"
  });
}

function publishMqtt(element) {
  var elemento = element[0].getElementsByClassName('device-room-publish');
  var device_room = elemento[0].getAttribute("data-device-room");
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
    device_room: device_room
  };
  console.log('publish device:' + device_room + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/devices/publish"
  });

}
