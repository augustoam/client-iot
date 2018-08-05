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
  var componente_ambiente = elemento.getAttribute("data-componente-ambiente");
  var acao = elemento.getAttribute("data-acao");

  var vData = {
    acao: acao,
    componente_ambiente: componente_ambiente
  };
  console.log('publish componente:' + componente_ambiente + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/componentes/publish"
  });
}

function publishMqtt(element) {
  var elemento = element[0].getElementsByClassName('componente-ambiente-publish');
  var componente_ambiente = elemento[0].getAttribute("data-componente-ambiente");
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
    componente_ambiente: componente_ambiente
  };
  console.log('publish componente:' + componente_ambiente + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/componentes/publish"
  });

}
