$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };

  $(document).ready(function() {
    // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();

    // Start material select box
    $('select').material_select();
  });

  $('#msg-close').on('click', function() {
    document.getElementById("msg-hide").style.display = "none";
  });

  $('#numeric-keyboard').on('focus', function() {
    document.getElementById("numeric-keyboard").value = "";
  });

  $(".button-collapse").sideNav({
    menuWidth: 300, // Default is 300
    closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
    draggable: true
  });

  $('.dropdown-button').dropdown({
    constrainWidth: false, // Does not change width of dropdown to that of the activator
    belowOrigin: true
  });

  $('.notice').each(notice);

  $('.publish-mqtt').change(function() {
    publishMqtt($(this));
  })

  $('.card-color').click(function() {
    comandoInfraVermelho($(this));
  });

}).on("click", "tr[data-href] td", function(e) {
  var $td = $(this);
  if ($td.find("a.btn").length === 0) // Apenas se a célula não possuir um botão
    Turbolinks.visit($td.parents("tr:first").data("href"));
}).on("click", "li[data-href], div[data-href]", function(e) {
  Turbolinks.visit($(this).data("href"));
});

function notice() {
  var msg = $(this).data().msg;
  console.log(msg);
  Materialize.toast(msg, 4000)
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
  }).done(function() {
    //window.location.reload();
  });

}
