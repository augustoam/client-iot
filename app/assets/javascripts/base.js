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

  $('.botao-infra-vermelho').each(function() {
    atualizaEstadoComponente($(this));
  })

  $('.botao-infra-vermelho').click(function() {
    comandoInfraVermelho($(this));
  });

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

function atualizaEstadoComponente(element) {
  var botaoComandoInfraVermelho = document.getElementById(element[0].id);
  var estado = botaoComandoInfraVermelho.getAttribute("data-estado");

  if (estado == "true") {
    botaoComandoInfraVermelho.removeAttribute("unchecked")
    botaoComandoInfraVermelho.setAttribute("checked", "checked")
    botaoComandoInfraVermelho.setAttribute("data-estado", "true")
  } else {
    botaoComandoInfraVermelho.removeAttribute("checked")
    botaoComandoInfraVermelho.setAttribute("unchecked", "unchecked")
    botaoComandoInfraVermelho.setAttribute("data-estado", "false")
  }
}

function notice() {
  var msg = $(this).data().msg;
  console.log(msg);
  Materialize.toast(msg, 4000)
}

function comandoInfraVermelho(element) {
  var botaoComandoInfraVermelho = document.getElementById(element[0].id);
  var topico = botaoComandoInfraVermelho.getAttribute("data-topico");
  var componente_ambiente = botaoComandoInfraVermelho.getAttribute("data-componente-ambiente");
  var acao = botaoComandoInfraVermelho.getAttribute("data-acao");

  if ((element[0].id).indexOf('switch') !== -1) {
    if (botaoComandoInfraVermelho.checked) {
      acao = 'ligar';
    } else {
      acao = 'desligar';
    }
  }

  var vData = {
    topico: topico,
    acao: acao,
    componente_ambiente: componente_ambiente
  };
  console.log('publish topico:' + topico + ' componente:' + componente_ambiente + ' acao:' + acao);
  $.post({
    data: vData,
    url: "/api/componentes/publish"
  }).done(function() {
    //window.location.reload();
  });

}
