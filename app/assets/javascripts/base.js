$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };

  $('#msg-close').on('click', function(){
    document.getElementById("msg-hide").style.display = "none";
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

  $('#switch-mode').change(function(){
    atualizaMode();
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
  var mode = document.getElementById('switch-mode').checked
  console.log(mode);

  if(mode){
    $.ajax({
      type: "POST",
      dataType: "json",
      url: "http://localhost:3000/home/mode_on"
    });
  } else {
    $.ajax({
      type: "POST",
      dataType: "json",
      url: "http://localhost:3000/home/mode_off"
    }); 
  }
}