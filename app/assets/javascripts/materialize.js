$(document).on('turbolinks:load', function() {
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
});

function notice() {
  var msg = $(this).data().msg;
  console.log(msg);
  Materialize.toast(msg, 4000)
}
