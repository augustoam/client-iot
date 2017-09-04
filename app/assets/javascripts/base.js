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
});
     
function notice(){
  var msg = $(this).data().msg;
  console.log(msg);
  Materialize.toast(msg, 4000)
}