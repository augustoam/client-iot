$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };


  $(document).ready(function(){
    // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();

    // Start material select box
    $('select').material_select();
  });

  $('#msg-close').on('click', function(){
    document.getElementById("msg-hide").style.display = "none";
  });

  $('#numeric-keyboard').on('focus', function(){
    document.getElementById("numeric-keyboard").value = "";
  });

  $(".button-collapse").sideNav({
      menuWidth: 300, // Default is 300
      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
      draggable: true
    }
  );

  $('.dropdown-button').dropdown({
      constrainWidth: false, // Does not change width of dropdown to that of the activator
      belowOrigin: true
    }
  );

  $('.notice').each(notice);

  $('.botao-infra-vermelho').click(function(){
    comandoInfraVermelho($(this));
  });

}).on("click", "tr[data-href] td", function(e) {
  var $td = $(this);
  if ($td.find("a.btn").length === 0) // Apenas se a célula não possuir um botão
    Turbolinks.visit($td.parents("tr:first").data("href"));
}).on("click", "li[data-href], div[data-href]", function(e) {
  Turbolinks.visit($(this).data("href"));
});

function notice(){
  var msg = $(this).data().msg;
  console.log(msg);
  Materialize.toast(msg, 4000)
}

function atualizaMode(){
  var switch_mode = document.getElementById('switch-mode');
  var mode = switch_mode.checked;
  var topico = switch_mode.getAttribute("data-topico");
  var componente = switch_mode.getAttribute("data-comp");

  $.ajax({
    type: "POST",
    dataType: "json",
    url: "http://client-iot.herokuapp.com/api/componentes/publish?topico=" +topico+"&mode="+mode+"&componente="+componente
  });
}

function comandoInfraVermelho(element){

  var botaoComandoInfraVermelho = document.getElementById(element[0].id);
  var topico       = botaoComandoInfraVermelho.getAttribute("data-topico");
  var componente   = botaoComandoInfraVermelho.getAttribute("data-componente");
  var acao         = botaoComandoInfraVermelho.getAttribute("data-acao");

  if ((element[0].id).indexOf('switch') !== -1) {
    if (botaoComandoInfraVermelho.checked) {
      acao = 'power-on';
    } else {
      acao = 'power-off';
    }
  }

  $.ajax({
    type: "POST",
    dataType: "json",
    url: "https://client-iot.herokuapp.com/api/componentes/publish?topico=" +topico+"&acao="+acao+"&componente="+componente
  }).done(function() {
    window.location.reload();
  });
}
